return {
  'nvim-neo-tree/neo-tree.nvim',
  opts = {
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.opt_local.relativenumber = true
        end,
      },
    },
    window = {
      mappings = {
        ['A'] = {
          'add_directory',
          config = {
            show_path = 'relative', -- "none", "relative", "absolute"
          },
        },
        ['a'] = {
          'add',
          config = {
            show_path = 'relative', -- "none", "relative", "absolute"
          },
        },
        ['m'] = {
          'move',
          config = {
            show_path = 'relative', -- "none", "relative", "absolute"
          },
        },
      },
    },
  },
}
