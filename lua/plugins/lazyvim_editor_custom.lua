return {
  'folke/trouble.nvim',
  keys = {
    {
      '<leader>cS',
      '<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>',
      desc = 'LSP references/definitions/... (Trouble)',
    },
  },
}
