-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map("n", "<A-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Vertical resize -2" })
map("n", "<A-Down>", "<Cmd>resize -2<CR>", { desc = "Horizontal resize -2" })
map("n", "<A-Up>", "<Cmd>resize +2<CR>", { desc = "Horizontal resize +2" })
map("n", "<A-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Vertical resize +2" })
