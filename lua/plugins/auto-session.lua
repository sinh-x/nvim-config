return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      auto_session_root_dir = '~/nvim-sessions/',
    }
  end,
  lazy = false,
}
