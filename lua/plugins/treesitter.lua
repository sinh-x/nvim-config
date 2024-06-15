return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>', -- set to `false` to disable one of the mappings
          node_incremental = '<c-space>',
          scope_incremental = 'gcc',
          node_decremental = 'grr',
        },
      },
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'vim',
        'lua',
        'vimdoc',
        'html',
        'css',
        'fish',
        'json',
        -- r programmeng
        'r',
        'rnoweb',
        'markdown',
        'markdown_inline',
      },
    },
  },
}
