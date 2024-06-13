return {
  "codethread/qmk.nvim",
  config = function()
    ---@type qmk.UserConfig
    local conf = {
      name = "LAYOUT_sinh_x_58",
      layout = {
        "_ x x x x x x _ _ _ x x x x x x",
        "_ x x x x x x _ _ _ x x x x x x",
        "_ x x x x x x _ _ _ x x x x x x",
        "_ x x x x x x x _ x x x x x x x",
        "_ _ _ x x x x x _ x x x x x _ _",
      },
    }
    require("qmk").setup(conf)
  end,
}
