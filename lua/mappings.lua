-- This file is used to set up custom key mappings in Neovim.
-- The 'map' function is used to create new key mappings.
-- The 'nomap' function is used to disable existing key mappings.

require 'nvchad.mappings'

-- add yours here

local map = vim.keymap.set
map('n', '<C-q>', "<cmd>q<cr>", { desc = "Quit" } )
map('n', '<leader>qq', "<cmd>qa!<cr>", { desc = "Quit" } )
map('n', '<leader>qs', "<cmd>wqa<cr>", { desc = "Quit" } )
-- Map ';' to ':' in normal mode to enter command mode
map('n', ';', ':', { desc = 'CMD enter command mode' })
-- Map 'jj' to '<ESC>' in insert mode to exit insert mode
map('i', 'jj', '<ESC>', { desc = 'Exit insert mode' })
-- Map '<C-s>' to '<cmd>w<cr><esc>' in insert, normal, and visual mode to save the file
map({ 'i', 'n', 'v' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- Disalbe mappings
local nomap = vim.keymap.del

-- Disable C-j,h,k,l for moving around in normal mode
nomap('n', '<C-j>')
nomap('n', '<C-h>')
nomap('n', '<C-k>')
nomap('n', '<C-l>')

-- Disable default keyboard help map in normal mode
nomap('n', '<leader>wk')
nomap('n', '<leader>wK')

-- change buffer mappings
-- Disable '<leader>x' and '<leader>b' in normal mode
nomap('n', '<leader>x')
nomap('n', '<leader>b')
-- Map '<leader>bn' to '<cmd>enew<cr>' in normal mode to create a new buffer
map('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New buffer' })
-- Map '<leader>bc' to a function that closes the current buffer in normal mode
map('n', '<leader>bc', function()
  require('nvchad.tabufline').close_buffer()
end, { desc = 'buffer close' })

-- Copilot chat mappings

-- This mapping is for the 'CopilotChat' functionality in normal mode.
-- '<leader>ac' triggers the 'CopilotChatToggle' command which is used to open/close CopilotChat.
map('n', '<leader>ac', 'ggVG<cmd>CopilotChatToggle<cr>', { desc = 'Open/close CopilotChat' })
-- Map '<leader>ac' to 'ggVG<cmd>CopilotChatReview<cr>' in normal mode to review code with CopilotChat
map('n', '<leader>ar', 'ggVG<cmd>CopilotChatReview<cr>', { desc = 'Review code with CopilotChat' })
-- Map '<leader>ad' to 'ggVG<cmd>CopilotChatDocs<cr>' in normal mode to document code with CopilotChat
map('n', '<leader>ad', 'ggVG<cmd>CopilotChatDocs<cr>', { desc = 'Document code with CopilotChat' })

-- These mappings are for the 'CopilotChat' functionality in visual mode.
-- '<leader>ar' triggers the 'CopilotChatReview' command which is used to review the code with CopilotChat.
map('v', '<leader>ar', '<cmd>CopilotChatReview<cr>', { desc = 'Document code with CopilotCahat' })
-- '<leader>ad' triggers the 'CopilotChatDocs' command which is used to document the code with CopilotChat.
map('v', '<leader>ad', '<cmd>CopilotChatDocs<cr>', { desc = 'Document code with CopilotChat' })

