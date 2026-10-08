local ls = require 'luasnip'
local s, i = ls.snippet, ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    'vitest',
    fmt("import {{ describe, expect, it }} from 'vitest';\n\ndescribe('{}', () => {{\n  it('{}', () => {{\n    {}\n  }});\n}});", {
      i(1, 'subject'),
      i(2, 'behaves as expected'),
      i(0, 'expect(true).toBe(true);'),
    })
  ),
  s('testcase', fmt("it('{}', () => {{\n  {}\n}});", { i(1, 'behaves as expected'), i(0, 'expect(true).toBe(true);') })),
  s('testasync', fmt("it('{}', async () => {{\n  {}\n}});", { i(1, 'resolves successfully'), i(0) })),
}
