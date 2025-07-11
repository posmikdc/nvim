local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

-- Helper functions {{{
-- Date function
local date = function()
  return { os.date('%Y-%m-%d') }
end

-- Function to create aligned subsection header
local function aligned_subsection(args)
  local title = args[1][1] or ""
  local total_length = 80 -- Adjust this value as necessary for your alignment needs
  local filler_length = total_length - #title - 2
  return string.rep("=", filler_length)
end
-- }}}

-- Snippets {{{
ls.add_snippets("r", {
  -- R Script Header
  s("meta", {
    t({
      "################################################################################",
      "################################################################################",
      "### Title: " }),
    i(1, "script_title"),
    t({ "",
      "### Author: " }),
    i(2, "author"),
    t({ "",
      "### Date: " }),
    f(date, {}),
    t({ "",
      "################################################################################",
      "################################################################################",
      "",
      "# Libraries ====================================================================",
      "",
      "# Set-Up =======================================================================",
      "",
      "" }),
    t({
      "################################################################################",
      "### " }),
    i(3, "section_title"),
    t({ "",
      "################################################################################",
      "" }),
    i(0)
  }),
  -- R Script Section Header
  s("section", {
    t({
      "################################################################################",
      "### " }),
    i(1, "section_title"),
    t({ "",
      "################################################################################",
      "" }),
    i(0)
  }),
  -- R Script Subsection Header
  s("subsection", {
    t("# "),
    i(1, "subsection_title"),
    f(aligned_subsection, { 1 }),
    t({ "", "" }),
    i(0)
  }),
})
-- }}}
