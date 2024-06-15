return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'williamboman/mason.nvim' },
    },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function()
      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true,
      })

      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Re-enable autoformat-on-save',
      })

      require('conform').setup {
        formatters = {
          rprettify = {
            inherit = false,
            stdin = false,
            command = 'rprettify',
            args = { '$FILENAME' },
          },
        },
        formatters_by_ft = {
          bash = { 'shfmt' },
          sh = { 'shfmt' },
          fish = { 'fish_indent' },
          lua = { 'stylua' },
          go = { 'goimports', 'gofumpt', 'goimports-reviser' },
          javascript = { { 'prettierd', 'prettier' } },
          typescript = { { 'prettierd', 'prettier' } },
          javascriptreact = { { 'prettierd', 'prettier' } },
          typescriptreact = { { 'prettierd', 'prettier' } },
          vue = { { 'prettierd', 'prettier' } },
          css = { { 'prettierd', 'prettier' } },
          scss = { { 'prettierd', 'prettier' } },
          less = { { 'prettierd', 'prettier' } },
          html = { { 'prettierd', 'prettier' } },
          json = { { 'prettierd', 'prettier' } },
          jsonc = { { 'prettierd', 'prettier' } },
          yaml = { { 'prettierd', 'prettier' } },
          markdown = { { 'prettierd', 'prettier' } },
          ['markdown.mdx'] = { { 'prettierd', 'prettier' } },
          graphql = { { 'prettierd', 'prettier' } },
          handlebars = { { 'prettierd', 'prettier' } },
          r = { 'rprettify' },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 3000,
          lsp_fallback = true,
        },
      }
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  --   lazy = false,
  -- },
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
