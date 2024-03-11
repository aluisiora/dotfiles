local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local r = require("luasnip.extras").rep

ls.add_snippets("lua", {
  s("fna", {
    t({ "function()", "\t" }),
    i(1),
    t({ "", "end,", "" }),
  }),
})
