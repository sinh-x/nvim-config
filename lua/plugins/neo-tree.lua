return {
  'nvim-neo-tree/neo-tree.nvim',
  opts = {
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
