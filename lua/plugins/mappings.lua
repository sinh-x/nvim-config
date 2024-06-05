--[[ -- Mapping data with "desc" stored directly by vim.keymap.set().
-- ]]
-- Please use this mapping table to set keyboard mabbing since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  'AstroNvim/astrocore',
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- first is the key moed
      n = {
        ['<leader>a'] = { "<cmd>echo 'Hello world!'<cr>", desc = 'Say hello world' },
      },
      t = {},
      v = {},
      i = {},
    },
  },
}
