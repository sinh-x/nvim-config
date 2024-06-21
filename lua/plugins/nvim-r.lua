-- This Lua script is configuring the plugins that help working with R in Neovim editor.

return {
  -- The first plugin is R-nvim/R.nvim, which is not lazily loaded.
  -- Note that lazyvim has pre-configured setups for this already just set it load in advance
  -- as ti use R instensively
  {
    "R-nvim/R.nvim",
    lazy = false,
  },
  -- The second plugin is R-nvim/cmp-r.
  "R-nvim/cmp-r",
  -- The third plugin is hrsh7th/nvim-cmp, which is a completion engine for Neovim.
  {
    "hrsh7th/nvim-cmp",
    -- The opts function is used to configure the plugin. Thist take the example provided on LazyVim website.
    -- And added the sources sections for better auto-completion.
    opts = function(_, opts)
      -- This function checks if there are words before the cursor.
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      -- Here we are configuring the mappings for the plugin.
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- If the completion menu is visible, select the next item.
          if cmp.visible() then
            cmp.select_next_item()
          -- If a snippet is active, jump to the next placeholder.
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          -- If there are words before the cursor, trigger completion.
          elseif has_words_before() then
            cmp.complete()
          -- Otherwise, fallback to the default behavior.
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          -- If the completion menu is visible, select the previous item.
          if cmp.visible() then
            cmp.select_prev_item()
          -- If a snippet is active, jump to the previous placeholder.
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          -- Otherwise, fallback to the default behavior.
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      -- Here we are configuring the sources for the plugin.
      opts.soucres = vim.tbl_extend("force", opts.sources, {
        { name = "copilot" },
        { name = "luasnip" },
        { name = "cmp_r" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path", option = { trailing_slash = false } },
      })
    end,
  },
  -- The fourth plugin is stevearc/conform.nvim, which is a code formatter for Neovim.
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local conform = require("conform")

      -- Here we are configuring the formatters for the plugin using local script prettify for R.
      -- Content of thes script is as below. Make sure it executable and in  bin PATH.
      -- #!/usr/bin/env sh
      -- cp "$1" "$1".bak
      -- R --quiet --no-echo -e "styler::style_file(\"$1\")" 1>/dev/null 2>&1
      -- cat "$1"

      opts.formatters = vim.tbl_extend("force", opts.formatters, {
        rprettify = {
          inherit = "false",
          stdin = false,
          command = "rprettify",
          args = { "$FILENAME" },
        },
      })

      -- Here we are added the local prettify for R into the list of formatterr by file type or the plugin.
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft, {
        r = { "rprettify" },
      })
    end,
  },
  -- The fifth plugin is dense-analysis/ale, which is a linting engine for Neovim.
  {
    "dense-analysis/ale",
    config = function()
      -- Here we are configuring the linters for the plugin.
      vim.g.ale_linters = { r = { "lintr" } }
    end,
  },
}
