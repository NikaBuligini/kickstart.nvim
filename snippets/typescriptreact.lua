local ls = require 'luasnip'
local s, i = ls.snippet, ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
  s(
    'component',
    fmt('type {}Props = {{\n  {}\n}};\n\nexport function {}({{ {} }}: {}Props) {{\n  return (\n    {}\n  );\n}}', {
      i(1, 'Component'),
      i(2, 'title: string;'),
      rep(1),
      i(3, 'title'),
      rep(1),
      i(0, '<div>{title}</div>'),
    })
  ),
}
