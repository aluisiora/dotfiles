return {
  "andythigpen/nvim-coverage",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("coverage").setup()
    require("keymaps").coverage()
  end,
}
