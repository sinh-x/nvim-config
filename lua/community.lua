-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  'AstroNvim/astrocommunity',
  { import = 'astrocommunity.pack.lua' },
  { import = 'astrocommunity.pack.cpp' },
  { import = 'astrocommunity.pack.markdown' },
  { import = 'astrocommunity.pack.bash' },
  { import = 'astrocommunity.pack.html-css' },
  { import = 'astrocommunity.pack.json' },
  { import = 'astrocommunity.pack.yaml' },
  { import = 'astrocommunity.pack.fish' },
  { import = 'astrocommunity.recipes.heirline-vscode-winbar' },
  { import = 'astrocommunity.split-and-window.windows-nvim' },
  -- import/override with your plugins folder
}
