-- Same with text node, used for function nodes
local function text_same_with(args) return args[1] end

-- Same with text node, used for dynamic nodes
local function insert_same_with(args)
    return sn(nil, {
        i(1, args[1]),
    })
end

local compd = s({
    trig = "compd",
    dscr = "Dict comprehension",
}, {
    t("{"),
    d(3, insert_same_with, 2),
    t(": "),
    d(4, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t("}"),
})

local compdi = s({
    trig = "compdi",
    dscr = "Dict comprehension with 'if'",
}, {
    t("{"),
    d(3, insert_same_with, 2),
    t(": "),
    d(4, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t(" if "),
    d(5, insert_same_with, 2),
    t("}"),
})

local compg = s({
    trig = "compg",
    dscr = "Generator comprehension",
}, {
    t("("),
    d(3, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t(")"),
})

local compgi = s({
    trig = "compgi",
    dscr = "Generator comprehension with 'if'",
}, {
    t("("),
    d(3, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t(" if "),
    d(4, insert_same_with, 2),
    t(")"),
})

local compl = s({
    trig = "compl",
    dscr = "List comprehension",
}, {
    t("["),
    d(3, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t("]"),
})

local compli = s({
    trig = "compli",
    dscr = "List comprehension with 'if'",
}, {
    t("["),
    d(3, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t(" if "),
    d(4, insert_same_with, 2),
    t("]"),
})

local comps = s({
    trig = "comps",
    dscr = "Set comprehension",
}, {
    t("{"),
    d(3, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t("}"),
})

local compsi = s({
    trig = "compsi",
    dscr = "Set comprehension with 'if'",
}, {
    t("{"),
    d(3, insert_same_with, 2),
    t(" for "),
    i(2),
    t(" in "),
    i(1),
    t(" if "),
    d(4, insert_same_with, 2),
    t("}"),
})

local iter = s({
    trig = "iter",
    dscr = "Iterate (for ... in ...)",
}, {
    t("for "),
    i(2, "var"),
    t(" in "),
    i(1, "iterable"),
    t({ ":", "" }),
    t("\t"),
})

local itere = s({
    trig = "itere",
    dscr = "Iterate (for ... in enumerate)",
}, {
    t("for "),
    i(3, "i"),
    t(", "),
    i(2),
    t(" in enumerate("),
    i(1),
    t({ "):", "" }),
    t("\t"),
})

local main = s({
    trig = "main",
    dscr = "if __name__ == '__main__'",
}, {
    t({
        "if __name__ == '__main__':",
        "\t",
    }),
})

local prop = s({
    trig = "prop",
    dscr = "Property getter",
}, {
    t({ "@property", "" }),
    t({ "def " }),
    i(1),
    t({ "(self):", "" }),
    t({ "\treturn " }),
})

local props = s({
    trig = "props",
    dscr = "Property getter/setter",
}, {
    t({ "@property", "" }),
    t({ "def " }),
    i(1),
    t({ "(self):", "" }),
    t({ "\treturn " }),
    i(0),
    t({ "", "", "" }),
    t({ "@" }),
    f(text_same_with, 1),
    t({ ".setter", "" }),
    t({ "def " }),
    f(text_same_with, 1),
    t({ "(self, value):", "" }),
    t({ "\tpass" }),
})

local propsd = s({
    trig = "propsd",
    dscr = "Property getter/setter/deleter",
}, {
    t({ "@property", "" }),
    t({ "def " }),
    i(1),
    t({ "(self):", "" }),
    t({ "\treturn " }),
    i(0),
    t({ "", "", "" }),
    t({ "@" }),
    f(text_same_with, 1),
    t({ ".setter", "" }),
    t({ "def " }),
    f(text_same_with, 1),
    t({ "(self, value):", "" }),
    t({ "\tpass" }),
    t({ "", "", "" }),
    t({ "@" }),
    f(text_same_with, 1),
    t({ ".deleter", "" }),
    t({ "def " }),
    f(text_same_with, 1),
    t({ "(self):", "" }),
    t({ "\tpass" }),
})

local super = s({
    trig = "super",
    dscr = "'super(...)' call",
}, { t("super("), i(1), t(")."), i(2), t("("), i(3), t(")") })

return {
    -- From InteliJ
    compd,
    compdi,
    compg,
    compgi,
    compl,
    compli,
    comps,
    compsi,
    iter,
    itere,
    main,
    prop,
    props,
    propsd,
    super,
}
