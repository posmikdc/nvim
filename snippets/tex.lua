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
local rec_ls
rec_ls = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
    })
  )
end
-- }}}

-- Snippets {{{ 
ls.add_snippets("tex", {
  -- Itemize 
  s("item", {
    t({ "\\begin{itemize}", "\t\\item " }),
    i(1),
    d(2, rec_ls, {}), -- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many \item as necessary by utilizing a choiceNode.
    t({ "", "\\end{itemize}" }),
  }),
  -- Equation 
  s("eqn", {
    t({ "\\[", "\\begin{aligned}", " " }),
    i(1, "Math here (don't forget &= for alignment)"),
    t({ ", \\quad \\text{" }),
    i(2, "Description here"),
    t({ "} \\\\", "\\end{aligned}", "\\]" }),
  }),
-- Add the snippet for pset
  s("meta-pset", {
    t({
    "\\documentclass[11pt,letterpaper]{article}",
    "",
    "% Packages",
    "\\usepackage{amsfonts,latexsym,amsthm,amssymb,amsmath,amscd,euscript}",
    "\\usepackage{framed}",
    "\\usepackage[margin=1in]{geometry}",
    "\\usepackage{hyperref}",
    "\\usepackage{xcolor}",
    "\\usepackage{setspace}",
    "",
    "% Hyperref setup",
    "\\hypersetup{",
    "    colorlinks=true,",
    "    linkcolor=blue,",
    "    citecolor=blue,",
    "    urlcolor=blue,",
    "    pdfborder={0 0 0},",
    "    pdftitle={Assignment Template},",
    "    pdfauthor={Daniel Posmik}",
    "}",
    "",
    "% Short-hands",
    "\\def\\p{\\mathrm{P}}",
    "\\def\\P{\\mathbf{P}}",
    "\\def\\E{\\mathbb{E}}",
    "\\def\\V{\\mathrm{Var}}",
    "\\def\\Cov{\\mathrm{Cov}}",
    "\\def\\X{\\mathfrak{X}}",
    "\\def\\Sum{\\sum\\nolimits}",
    "\\def\\Prod{\\prod\\nolimits}",
    "",
    "% Title Section",
    "\\newcommand{\\assignmenttitle}[5]{%",
    "\\begin{framed}",
    "    \\centering",
    "    \\large",
    "    \\textbf{#1} \\\\ % Title",
    "    \\vspace{0.5em}",
    "    \\small",
    "    \\textit{Course:} #2, \\textit{Semester:} #3, \\textit{Instructor:} #4 \\\\",
    "    \\textit{Due:} #5 \\\\",
    "    \\vspace{1em}",
    "    \\textbf{Daniel Posmik} (E-Mail: \\href{mailto:daniel_posmik@brown.edu}{\\texttt{daniel\\_posmik@brown.edu}})",
    "\\end{framed}",
    "}",
    "",
    "% Begin Document",
    "\\begin{document}",
    "",
    "% Insert Title Information",
    "\\assignmenttitle{Assignment Title}{Course Name}{Semester}{Instructor Name}{Due Date}",
    "",
    "% Content goes here...",
    "",
    "\\end{document}"
  }),
   }),
}, {
  key = "tex",
})
-- }}}
