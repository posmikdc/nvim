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
  s("pset", {
    t({
      "% ====================",
      "% Set-Up ",
      "% ====================",
      "",
      "% Document class ",
      "\\documentclass[12pt]{amsart}",
      "",
      "% Packages ",
      "\\usepackage{amsfonts,latexsym,amsthm,amssymb,amsmath,amscd,euscript}",
      "\\usepackage{framed}",
      "\\usepackage{fullpage}",
      "\\usepackage{hyperref}",
      "",
      "% PSet format ",
      "\\hypersetup{colorlinks=true,citecolor=blue,urlcolor =black,linkbordercolor={1 0 0}}",
      "\\newenvironment{statement}[1]{\\smallskip\\noindent\\color[rgb]{1.00,0.00,0.50} {\\bf #1.}}{}",
      "\\allowdisplaybreaks[1]",
      "",
      "\\newtheorem{theorem}{Theorem}",
      "\\newtheorem*{proposition}{Proposition}",
      "\\newtheorem{lemma}[theorem]{Lemma}",
      "\\newtheorem{corollary}[theorem]{Corollary}",
      "\\newtheorem{conjecture}[theorem]{Conjecture}",
      "\\newtheorem{postulate}[theorem]{Postulate}",
      "\\theoremstyle{definition}",
      "\\newtheorem{defn}[theorem]{Definition}",
      "\\newtheorem{example}[theorem]{Example}",
      "\\theoremstyle{remark}",
      "\\newtheorem*{remark}{Remark}",
      "\\newtheorem*{notation}{Notation}",
      "\\newtheorem*{note}{Note}",
      "",
      "% Globals ",
      "\\input{/Users/posmikdc/Documents/assets/latex/globals}",
      "",
      "% ====================",
      "% Document",
      "% ====================",
      "",
      "\\title{Problem Set $",
    }),
    i(1, "n"), -- Insert problem set number
    t({
      "$}",
      "\\date{\\today}",
      "",
      "\\begin{document}",
      "",
      "\\begin{framed}",
      "\\maketitle ",
      "\\vspace*{-0.25in} \\noindent",
    }),
    i(2, "PHP0000"), -- Insert course number
    t({
      " \\hfill \\name \\\\",
      "Prof. ",
    }),
    i(3, "John Doe"), -- Insert instructor name
    t({
      " \\hfill{Pronouns: He/Him/His} \\\\",
      "\\today \\hfill {\\href{mailto:daniel_posmik@brown.edu}{{\\tt \\emailuniversity}}}",
      "\\end{framed}",
      "",
      "\\begin{statement}{1}",
      "    This is the problem statement. To help your graders, always preface your solution with the problem statement. Also, putting the problem statement in a different color helps your graders distinguish between problem and solution. We use the {\\tt statement} environment to help us do this.",
      "\\end{statement}",
      "",
      "\\begin{proof}",
      "    Type your solution in this body. Feel free to use definitions, lemmas, and examples as needed in your proofs; e.g.:",
      "    \\begin{defn}",
      "      Define $\\exp(x)$ for $x \\in \\mathbb{R}$ to be the value of $$\\sum_{i = 0}^\\infty\\frac{x^i}{i!}.$$",
      "    \\end{defn}",
      "    As in the above definition, use separate equations rather than in-line equations as much as possible. In general, if your mathematical expression takes up more than an inch on paper, you should probably put it in its own line. This makes your problemset more readable. Use equation arrays for lists of equalities:",
      "    \\begin{align*}",
      "        0 &= 0 + 0 + 0 + 0 + \\dots\\\\",
      "        &= (1 - 1) + (1 - 1) + \\dots \\\\",
      "        &= 1 + (-1 + 1) + (-1 + 1) + \\dots \\\\",
      "        &= 1 + 0 + 0 + 0 \\dots \\\\",
      "        &= 1.",
      "    \\end{align*}",
      "",
      "    If you need to list things, use {\\tt enumerate} or {\\tt itemize}; e.g. Daily Schedule:",
      "    \\begin{enumerate}",
      "        \\item Do the problem set.",
      "        \\item Do the problem set.",
      "        \\item Do the problem set.",
      "    \\end{enumerate}",
      "    And {\\tt itemize} gives you bullet points.",
      "\\end{proof}",
      "",
      "\\begin{statement}{2}",
      "    Show that there are no nontrivial integer solutions to $a^n + b^n = c^n$ when $n\\ge 3$ is an integer.",
      "\\end{statement}",
      "",
    }),
  }),
}, {
  key = "tex",
})
-- }}}
