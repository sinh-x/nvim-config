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
  -- nvim-tmux-navigation
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-Left>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-Down>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-Up>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-Right>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
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
    'oflisback/obsidian-bridge.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('obsidian-bridge').setup {
        obsidian_server_address = 'http://localhost:27123',
      }
    end,
    event = {
      'BufReadPre *.md',
      'BufNewFile *.md',
    },
    lazy = true,
  },
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
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'dailies',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },
      templates = {
        folder = 'Templates',
        date_format = '%Y-%m-%d-%a',
        time_format = '%H:%M',
      },
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
    'nvim-neo-tree/neo-tree.nvim',
    enabled = false,
  },
  -- code outline --
  {
    'hedyhli/outline.nvim',
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })

      require('outline').setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },
  -- improve command input ui
  {
    'VonHeikemen/fine-cmdline.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' },
    },
    config = function() vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>FineCmdline<CR>', { desc = 'Open fine cmd' }) end,
  },
  -- vim marks
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { '.', '<', '>', '^' },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = '⚑',
          virt_text = 'hello world',
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      }
    end,
  },
}
