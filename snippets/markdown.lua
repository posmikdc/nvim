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
  return {os.date('%Y-%m-%d')}
end

-- Snippets {{{ 
ls.add_snippets("markdown", {
  -- YAML meta header for markdown
  s("meta", {
    t({"---",
    "title: "}), i(1, "title"), t({"",
    "author: Daniel Posmik",
    "date: "}), f(date, {}), t({"",
    "format: "}), c(2, {
      t("html"),
      t("pdf")
    }), t({"",
    "toc: "}), c(3, {
      t("true"),
      t("false")
    }), t({"",
    "number_sections: "}), c(4, {
      t("true"),
      t("false")
    }), t({"",
    "---", ""}),
    i(0), -- Cursor ends here
    t({"",
    "\\newpage",
    "",
    "```{r setup, include=FALSE}",
    "# Set up knit environment",
    "knitr::opts_chunk$set(echo = F)",
    "knitr::opts_chunk$set(error = F)",
    "knitr::opts_chunk$set(warning = F)",
    "knitr::opts_chunk$set(message = F)",
    "```",
    "",
    "# **Code Appendix**",
    "",
    "```{r, ref.label = knitr::all_labels()}",
    "#| echo: true",
    "#| eval: false",
    "```", ""})
  }),
})
