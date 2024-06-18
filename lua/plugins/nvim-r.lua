-- This Lua script is configuring the plugins that help working with R in Neovim editor.

return {
  -- The first plugin is R-nvim/R.nvim, which is not lazily loaded.
  -- Note that lazyvim has pre-configured setups for this already just set it load in advance
  -- as ti use R instensively
  {
    'R-nvim/R.nvim',
    lazy = false,
  },
  -- The second plugin is R-nvim/cmp-r.
  'R-nvim/cmp-r',
  -- The third plugin is hrsh7th/nvim-cmp, which is a completion engine for Neovim.
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji' },
    -- The opts function is used to configure the plugin. Thist take the example provided on LazyVim website.
    -- And added the sources sections for better auto-completion.
    opts = function(_, opts)
      -- This function checks if there are words before the cursor.
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

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

      -- -- Here we are configuring the sources for the plugin.
      -- 1 - r language server
      -- 2 - r objects
      -- 3 - path
      -- I have to remeve the 3rd source which is cmp-path configure byth LazyVim
      -- and switch to my configuration
      for i = 1, #opts.sources do
        if opts.sources[i].name == 'path' then
          table.remove(opts.sources, i)
          break
        end
      end
      -- table.remove(opts.sources, 3)
      table.insert(opts.sources, {
        name = 'path',
        option = {
          trailing_slash = false,
          label_trailing_slash = true,
          get_cwd = function()
            return vim.fn.getcwd()
          end,
        },
      })
    end,
  },
  -- The fifth plugin is dense-analysis/ale, which is a linting engine for Neovim.
  {
    'dense-analysis/ale',
    config = function()
      -- Here we are configuring the linters for the plugin.
      vim.g.ale_linters = { r = { 'lintr' } }
    end,
  },
}
