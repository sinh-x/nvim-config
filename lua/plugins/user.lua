-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  'andweeb/presence.nvim',
  {
    'ray-x/lsp_signature.nvim',
    event = 'BufRead',
    config = function() require('lsp_signature').setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    'goolord/alpha-nvim',
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        ' █████  ███████ ████████ ██████   ██████',
        '██   ██ ██         ██    ██   ██ ██    ██',
        '███████ ███████    ██    ██████  ██    ██',
        '██   ██      ██    ██    ██   ██ ██    ██',
        '██   ██ ███████    ██    ██   ██  ██████',
        ' ',
        '    ███    ██ ██    ██ ██ ███    ███',
        '    ████   ██ ██    ██ ██ ████  ████',
        '    ██ ██  ██ ██    ██ ██ ██ ████ ██',
        '    ██  ██ ██  ██  ██  ██ ██  ██  ██',
        '    ██   ████   ████   ██ ██      ██',
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { 'max397574/better-escape.nvim', enabled = true },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    'L3MON4D3/LuaSnip',
    config = function(plugin, opts)
      require 'astronvim.plugins.configs.luasnip'(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require 'luasnip'
      luasnip.filetype_extend('javascript', { 'javascriptreact' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function(plugin, opts)
      require 'astronvim.plugins.configs.nvim-autopairs'(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require 'nvim-autopairs'
      local Rule = require 'nvim-autopairs.rule'
      local cond = require 'nvim-autopairs.conds'
      npairs.add_rules(
        {
          Rule('$', '$', { 'tex', 'latex' })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex '%%')
            -- don't add a pair if  the previous character is xxx
            :with_pair(cond.not_before_regex('xxx', 3))
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex 'xx')
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule('a', 'a', '-vim')
      )
    end,
  },

  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require 'nvim-tmux-navigation'

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      -- set keymaps
      local keymap = vim.keymap

      keymap.set('n', '<C-Left>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      keymap.set('n', '<C-Down>', nvim_tmux_nav.NvimTmuxNavigateDown)
      keymap.set('n', '<C-Up>', nvim_tmux_nav.NvimTmuxNavigateUp)
      keymap.set('n', '<C-Right>', nvim_tmux_nav.NvimTmuxNavigateRight)
      keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
    end,
  },
  -- neorg setup
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },
  {
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = true,
  },
  -- qmk setup
  {
    'codethread/qmk.nvim',
    config = function()
      ---@type qmk.UserConfig
      local conf = {
        name = 'LAYOUT_sinh_x_58',
        layout = {
          '_ x x x x x x _ _ _ x x x x x x',
          '_ x x x x x x _ _ _ x x x x x x',
          '_ x x x x x x _ _ _ x x x x x x',
          '_ x x x x x x x _ x x x x x x x',
          '_ _ _ x x x x x _ x x x x x _ _',
        },
      }
      require('qmk').setup(conf)
    end,
  },
  -- setup obsidian
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/Documents/Sinh-organized',
        },
      },
      -- see below for full list of options 👇
    },
  },
  -- markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
    ft = { 'markdown' },
  },
  -- Zen mode
  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- Disable neo-tree
  {
    'nvim-neotree/neo-tree.nvim',
    enabled = false,
  },
}
