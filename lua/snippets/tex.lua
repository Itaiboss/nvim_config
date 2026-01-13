local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Helper function to detect math context
local function in_mathzone()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
    -- TEXT MODE SNIPPETS (work anywhere)
    
    -- Inline math: mk -> $ $
    s({trig = "mk", snippetType = "autosnippet"}, {
        t("$"), i(1), t("$"), i(0)
    }),
    
    -- Display math: dm -> \[ \]
    s({trig = "dm", snippetType = "autosnippet"}, {
        t({"\\[", "\t"}), i(1), t({"", "\\]"}), i(0)
    }),
    
    -- MATH MODE SNIPPETS (only work inside $ $ or \[ \])
    
    -- Fraction: ff -> \frac{}{}
    s({trig = "ff", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0)
    }),
    
    -- Subscript: __ -> _{}
    s({trig = "__", snippetType = "autosnippet", condition = in_mathzone}, {
        t("_{"), i(1), t("}"), i(0)
    }),
    
    -- Superscript: td -> ^{}
    s({trig = "td", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("^{"), i(1), t("}"), i(0)
    }),
    
    -- Square root: sq -> \sqrt{}
    s({trig = "sq", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\sqrt{"), i(1), t("}"), i(0)
    }),
    
    -- Sum: sum -> \sum_{}^{}
    s({trig = "sum", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\sum_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("}"), i(0)
    }),
    
    -- Integral: int -> \int_{}^{}
    s({trig = "int", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\int_{"), i(1), t("}^{"), i(2), t("}"), i(0)
    }),
    
    -- Limit: lim -> \lim_{} 
    s({trig = "lim", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\lim_{"), i(1, "n \\to \\infty"), t("} "), i(0)
    }),
    
    -- Partial derivative: pder -> \frac{\partial }{\partial }
    s({trig = "pder", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\frac{\\partial "), i(1), t("}{\\partial "), i(2), t("}"), i(0)
    }),
    
    -- Vector: vec -> \vec{}
    s({trig = "vec", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\vec{"), i(1), t("}"), i(0)
    }),
    
    -- Hat: hat -> \hat{}
    s({trig = "hat", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\hat{"), i(1), t("}"), i(0)
    }),
    
    -- Bar: bar -> \bar{}
    s({trig = "bar", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {
        t("\\bar{"), i(1), t("}"), i(0)
    }),
    
    -- GREEK LETTERS (symbol triggers - no wordTrig needed)
    
    s({trig = ";a", snippetType = "autosnippet", condition = in_mathzone}, {t("\\alpha")}),
    s({trig = ";b", snippetType = "autosnippet", condition = in_mathzone}, {t("\\beta")}),
    s({trig = ";g", snippetType = "autosnippet", condition = in_mathzone}, {t("\\gamma")}),
    s({trig = ";G", snippetType = "autosnippet", condition = in_mathzone}, {t("\\Gamma")}),
    s({trig = ";d", snippetType = "autosnippet", condition = in_mathzone}, {t("\\delta")}),
    s({trig = ";D", snippetType = "autosnippet", condition = in_mathzone}, {t("\\Delta")}),
    s({trig = ";e", snippetType = "autosnippet", condition = in_mathzone}, {t("\\epsilon")}),
    s({trig = ";ve", snippetType = "autosnippet", condition = in_mathzone}, {t("\\varepsilon")}),
    s({trig = ";z", snippetType = "autosnippet", condition = in_mathzone}, {t("\\zeta")}),
    s({trig = ";t", snippetType = "autosnippet", condition = in_mathzone}, {t("\\theta")}),
    s({trig = ";T", snippetType = "autosnippet", condition = in_mathzone}, {t("\\Theta")}),
    s({trig = ";l", snippetType = "autosnippet", condition = in_mathzone}, {t("\\lambda")}),
    s({trig = ";L", snippetType = "autosnippet", condition = in_mathzone}, {t("\\Lambda")}),
    s({trig = ";m", snippetType = "autosnippet", condition = in_mathzone}, {t("\\mu")}),
    s({trig = ";p", snippetType = "autosnippet", condition = in_mathzone}, {t("\\pi")}),
    s({trig = ";P", snippetType = "autosnippet", condition = in_mathzone}, {t("\\Pi")}),
    s({trig = ";s", snippetType = "autosnippet", condition = in_mathzone}, {t("\\sigma")}),
    s({trig = ";S", snippetType = "autosnippet", condition = in_mathzone}, {t("\\Sigma")}),
    s({trig = ";o", snippetType = "autosnippet", condition = in_mathzone}, {t("\\omega")}),
    s({trig = ";O", snippetType = "autosnippet", condition = in_mathzone}, {t("\\Omega")}),
    s({trig = ";f", snippetType = "autosnippet", condition = in_mathzone}, {t("\\phi")}),
    s({trig = ";vf", snippetType = "autosnippet", condition = in_mathzone}, {t("\\varphi")}),
    
    -- MATH SYMBOLS (symbol triggers - no wordTrig needed)
    
    s({trig = "<=", snippetType = "autosnippet", condition = in_mathzone}, {t("\\leq")}),
    s({trig = ">=", snippetType = "autosnippet", condition = in_mathzone}, {t("\\geq")}),
    s({trig = "!=", snippetType = "autosnippet", condition = in_mathzone}, {t("\\neq")}),
    s({trig = "~=", snippetType = "autosnippet", condition = in_mathzone}, {t("\\approx")}),
    s({trig = "->", snippetType = "autosnippet", condition = in_mathzone}, {t("\\to")}),
    s({trig = "=>", snippetType = "autosnippet", condition = in_mathzone}, {t("\\implies")}),
    s({trig = "=<", snippetType = "autosnippet", condition = in_mathzone}, {t("\\impliedby")}),
    s({trig = "iff", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {t("\\iff")}),
    s({trig = "...", snippetType = "autosnippet", condition = in_mathzone}, {t("\\ldots")}),
    s({trig = "inf", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {t("\\infty")}),
    s({trig = "ooo", snippetType = "autosnippet", condition = in_mathzone}, {t("\\infty")}),
    s({trig = "inn", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {t("\\in")}),
    s({trig = "notin", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {t("\\notin")}),
    s({trig = "subset", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {t("\\subset")}),
    s({trig = "forall", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {t("\\forall")}),
    s({trig = "exists", wordTrig = true, snippetType = "autosnippet", condition = in_mathzone}, {t("\\exists")}),
    
    -- TEXT FORMATTING (work anywhere, manual trigger with Tab)
    
    -- Bold: bf -> \textbf{}
    s("bf", {
        t("\\textbf{"), i(1), t("}"), i(0)
    }),
    
    -- Italic: it -> \textit{}
    s("it", {
        t("\\textit{"), i(1), t("}"), i(0)
    }),
    
    -- Underline: ul -> \underline{}
    s("ul", {
        t("\\underline{"), i(1), t("}"), i(0)
    }),
    
    -- ENVIRONMENTS (manual trigger with Tab)
    
    -- Generic environment: beg -> \begin{}\end{}
    s("beg", {
        t("\\begin{"), i(1, "env"), t("}"),
        t({"", "\t"}), i(2),
        t({"", "\\end{"}), 
        f(function(args) return args[1][1] end, {1}),
        t("}"), i(0)
    }),
    
    -- Equation: eqn -> equation environment
    s("eqn", {
        t({"\\begin{equation}", "\t"}), i(1),
        t({"", "\\end{equation}"}), i(0)
    }),
    
    -- Align: ali -> align environment
    s("ali", {
        t({"\\begin{align}", "\t"}), i(1),
        t({"", "\\end{align}"}), i(0)
    }),
    
    -- Matrix: mat -> matrix environment
    s("mat", {
        t({"\\begin{bmatrix}", "\t"}), i(1),
        t({"", "\\end{bmatrix}"}), i(0)
    }),
    
    -- Cases: case -> cases environment
    s("case", {
        t({"\\begin{cases}", "\t"}), i(1),
        t({"", "\\end{cases}"}), i(0)
    }),
    
    -- Itemize: item -> itemize with first item
    s("item", {
        t({"\\begin{itemize}", "\t\\item "}), i(1),
        t({"", "\\end{itemize}"}), i(0)
    }),
    
    -- Enumerate: enum -> enumerate with first item
    s("enum", {
        t({"\\begin{enumerate}", "\t\\item "}), i(1),
        t({"", "\\end{enumerate}"}), i(0)
    }),
    
    -- COMMON COMMANDS (manual trigger with Tab)
    
    -- Section: sec -> \section{}
    s("sec", {
        t("\\section{"), i(1), t("}"), i(0)
    }),
    
    -- Subsection: sub -> \subsection{}
    s("sub", {
        t("\\subsection{"), i(1), t("}"), i(0)
    }),
    
    -- Label: lab -> \label{}
    s("lab", {
        t("\\label{"), i(1), t("}"), i(0)
    }),
    
    -- Reference: ref -> \ref{}
    s("ref", {
        t("\\ref{"), i(1), t("}"), i(0)
    }),
    
    -- Citation: cite -> \cite{}
    s("cite", {
        t("\\cite{"), i(1), t("}"), i(0)
    }),
}
