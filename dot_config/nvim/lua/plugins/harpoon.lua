local function actions(h)
  return {
    append = function()
      h:list():append()
    end,
    toggle_quick_menu = function()
      h.ui:toggle_quick_menu(h:list())
    end,
    jump_to_previous = function()
      h:list():prev()
    end,
    jump_to_next = function()
      h:list():next()
    end,
    jump_to = function(idx)
      return function()
        h:list():select(idx)
      end
    end,
  }
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup()
    local a = actions(harpoon)
    require("keymaps").harpoon(a)
  end,
}
