return {
  "nvim-neo-tree/neo-tree.nvim",
 opts = {
    window = {
      mappings = {
               ["A"] = { 
              "add_directory",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "relative" -- "none", "relative", "absolute"
              }
            },
       ["a"] = { 
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "relative" -- "none", "relative", "absolute"
              }
            },
        ["m"] = { 
              "move",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "relative" -- "none", "relative", "absolute"
              }
            },

      },
    },
  },
}
