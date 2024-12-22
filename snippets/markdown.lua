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
  -- Beamer slides meta snippet
  s("meta-beamer", {
    t({"---",
    "title: "}), i(1, "A Fancy Title"), t({"",  -- Title text node
    "#subtitle: A Subtitle",  -- Subtitle line (commented out for optional use)
    "author: Daniel C. Posmik (He/Him/His)", 
    "date: today",
    "institute: Brown University School of Public Health, Department of Biostatistics",
    "#bibliography: references.bib",  -- Bibliography line remains commented out
    "toc: "}), c(2, {  -- Choice node for TOC
      t("false"),
      t("true")
    }), t({"",  -- Formatting and additional settings
    "format:",
    "  beamer:",
    "    aspectratio: 43",  -- Aspect ratio added
    "    include-in-header: \"/Users/posmikdc/Documents/assets/latex/beamer/beamerthememinimal.sty\"",
    "    titlegraphic: background.png",  -- Title graphic option
    "---", "",
    }),
    i(0)  -- Cursor ends here
  }),

  -- Report meta snippet
  s("meta-report", {
    t({"---",
    "title: "}), i(1, "title"), t({"",
    "author: Daniel Posmik",
    "date: today"}), t({"",
    "format: "}), c(2, {
      t("pdf"),
      t("html")
    }), t({"",
    "toc: "}), c(3, {
      t("false"),
      t("true")
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
