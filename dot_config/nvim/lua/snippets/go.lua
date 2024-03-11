local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
-- local r = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
  s(
    "ie",
    fmt(
      [[
    if err != nil {{
      return {}, err
    }}
    ]],
      {
        i(1, "nil"),
      }
    )
  ),
})
