-- This Lua script is configuring the plugins that help working with R in Neovim editor.

return {
  -- The first plugin is R-nvim/R.nvim, which is not lazily loaded.
  -- Note that lazyvim has pre-configured setups for this already just set it load in advance
  -- as ti use R instensively
  {
    'R-nvim/R.nvim',
    lazy = false,
    opts = function(_, opts)
      opts.nvimpager = 'split_h'
      opts.min_editor_width = 1000
      opts.hook = {
        on_filetype = function()
          -- This function will be called at the FileType event
          -- of files supported by R.nvim. This is an
          -- opportunity to create mappings local to buffers.
          vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
          vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
        end,
      }
    end,
  },
  -- The second plugin is R-nvim/cmp-r.
  'R-nvim/cmp-r',
  -- The third plugin is hrsh7th/nvim-cmp, which is a completion engine for Neovim.
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-emoji',
      'jalvesaq/cmp-zotcite',
      'jmbuhr/otter.nvim',
    },
    -- The opts function is used to configure the plugin. Thist take the example provided on LazyVim website.
    -- And added the sources sections for better auto-completion.
    opts = function(_, opts)
      -- This function checks if there are words before the cursor.
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      local kind_icons = {
        Copilot = '',
        Text = '',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '󱢌',
        Field = '󰽐',
        Variable = 'α',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '',
      }

      local cmp = require 'cmp'

      -- Here we are configuring the mappings for the plugin.
      -- Tap for next / Shift + Tab for previous
      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          -- If the completion menu is visible, select the next item.
          if cmp.visible() then
            cmp.select_next_item()
            -- If a snippet is active, jump to the next placeholder.
          elseif vim.snippet.active { direction = 1 } then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
            -- If there are words before the cursor, trigger completion.
          elseif has_words_before() then
            cmp.complete()
            -- Otherwise, fallback to the default behavior.
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          -- If the completion menu is visible, select the previous item.
          if cmp.visible() then
            cmp.select_prev_item()
            -- If a snippet is active, jump to the previous placeholder.
          elseif vim.snippet.active { direction = -1 } then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
            -- Otherwise, fallback to the default behavior.
          else
            fallback()
          end
        end, { 'i', 's' }),
      })

      local function remove_sources(source)
        for i = 1, #opts.sources do
          if opts.sources[i].name == source then
            table.remove(opts.sources, i)
            break
          end
        end
      end

      -- Here I remove and added sources with custom configuration.
      remove_sources 'path'
      remove_sources 'luasnip'
      remove_sources 'cmp_r'
      remove_sources 'nvim_lsp'
      table.insert(opts.sources, {
        name = 'path',
        priority = 1000,
        option = {
          trailing_slash = false,
          label_trailing_slash = true,
          get_cwd = function()
            return vim.fn.getcwd()
          end,
        },
      })
      table.insert(opts.sources, {
        name = 'luasnip',
        priority = 1000,
      })
      table.insert(opts.sources, {
        name = 'cmp_r',
        priority = 1001,
      })
      table.insert(opts.sources, {
        name = 'nvim_lsp',
        priority = 1002,
      })

      table.insert(opts.sources, {
        name = 'emoji',
      })
      table.insert(opts.sources, {
        name = 'otter',
      })

      opts.formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, vim_item)
          -- Kind icons
          if kind_icons[vim_item.kind] then
            vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          else
            vim_item.kind = vim_item.kind
          end
          -- Source
          vim_item.menu = ({
            copilot = 'a',
            latex_symbols = '',
            lbdb = 'lb',
            otter = 'o',
            nvim_lsp = '',
            nvim_lua = 'L',
            luasnip = '',
            buffer = '﬘',
            cmdline = ':',
            path = '',
            cmp_zotcite = 'Z',
            cmp_r = 'R',
          })[entry.source.name] or entry.source.name
          return vim_item
        end,
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters = vim.tbl_extend('force', opts.formatters, {
        rprettify = {
          inherit = 'false',
          stdin = false,
          command = 'rprettify',
          args = { '$FILENAME' },
        },
      })

      -- Here we are added the local prettify for R into the list of formatterr by file type or the plugin.
      opts.formatters_by_ft = vim.tbl_extend('force', opts.formatters_by_ft, {
        r = { 'rprettify' },
      })
    end,
  },
}
