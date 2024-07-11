-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    require('cmp').setup.filetype('R', {
      enabled = false,
    })
  end,
})
