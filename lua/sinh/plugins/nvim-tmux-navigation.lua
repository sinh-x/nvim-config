return {
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
}
