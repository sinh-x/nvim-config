return {
  {
    "R-nvim/R.nvim",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "markdown", "markdown_inline", "r", "rnoweb" },
      })
    end,
  },
  "R-nvim/cmp-r",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "cmp_r" },
          { name = "buffer" },
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
        },
        completion = {
          autocomplete = {
            3, -- Autocomplete if the typed character is an identifier character
          },
        },
      })
      require("cmp_r").setup({})
    end,
  },
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_linters = { r = { "lintr" } }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
    end,
  },
}
