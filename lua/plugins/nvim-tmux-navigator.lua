return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-Left>", "<cmd>TmuxNavigateLeft<cr>", desc = "Move to window on the left"},
    { "<c-Down>", "<cmd>TmuxNavigateDown<cr>", desc = "Move to window below" },
    { "<c-Up>", "<cmd>TmuxNavigateUp<cr>", desc = "Move to window above" },
    { "<c-Right>", "<cmd>TmuxNavigateRight<cr>", desc = "Move to window on the right" },
    { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Move to previous active window" },
  },
}
