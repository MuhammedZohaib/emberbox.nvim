-- emberbox.lua
--
-- Warm dark colorscheme: Gruvbox x modern Neovim x darker cleaner UI.
--
-- Design system ("Emberbox"):
--   * Backgrounds: warm brown/charcoal ladder, with recessed sidebars and
--     raised floats/popups.
--   * Syntax hierarchy: yellow functions and orange keywords carry structure;
--     properties, params, comments, and inactive UI stay quieter.
--   * Red is reserved for errors, removals, and hard conflicts.
--   * Orange/yellow answer "where am I / where next": cursor, search, matches,
--     jump labels, selected completion.
--   * Blue/aqua are supporting colors for links, info, types, and hints.
--   * Diff/diagnostic backgrounds are the accent washed into bg (10-24%),
--     never flat gray, so syntax stays readable inside them.
--   * Hue-to-meaning is constant everywhere: strings=green, funcs=yellow,
--     keywords=orange, types=aqua, constants=purple, members/modules=beige.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "emberbox"

local p = {
	-- upgraded gruvbox surface ladder
	bg_deep = "#181310", -- deep sidebar / recessed areas
	bg = "#211a16", -- main canvas
	bg_alt = "#2a211c", -- cursorline
	bg_float = "#2d241e", -- floating windows
	bg_pop = "#362a22", -- popup/completion
	bg_border = "#4d3c30", -- borders / visual
	bg_hover = "#5d493a", -- hover / scrollbar

	-- text ladder
	fg = "#e6d6b8", -- warm cream
	fg_dim = "#c8b99b", -- secondary text
	fg_muted = "#9f8f76", -- muted UI
	fg_faint = "#6f6252", -- line numbers / invisibles
	comment = "#837263",
	doc_comment = "#a08d7a",

	-- gruvbox-modern accents
	red = "#ea6962", -- errors
	orange = "#e78a4e", -- keywords / warnings / cursor
	yellow = "#e0b45c", -- functions / important UI
	green = "#a9b665", -- strings / additions
	aqua = "#89b482", -- types / hints
	blue = "#7daea3", -- links / info / selections
	purple = "#d3869b", -- constants / numbers / regex
	beige = "#c7ad83", -- quiet identifiers

	-- tinted backgrounds
	diff_add_bg = "#27341f",
	diff_del_bg = "#3a2420",
	diff_change_bg = "#332b1f",
	diff_text_bg = "#4a3822",
	ref_bg = "#30291f",
	err_bg = "#35211f",
	warn_bg = "#35281d",
	info_bg = "#24302d",
	hint_bg = "#27301f",
	conflict_cur = "#2f3a24",
	conflict_cur_label = "#42512f",
	conflict_inc = "#263a37",
	conflict_inc_label = "#36504b",
	conflict_anc = "#3a2a34",
}

local set = vim.api.nvim_set_hl

------------------------------------------------------------------
-- Base editor surface
------------------------------------------------------------------
set(0, "Normal", { fg = p.fg, bg = p.bg })
set(0, "NormalNC", { fg = p.fg, bg = p.bg })
set(0, "Cursor", { fg = p.bg, bg = p.orange })
set(0, "lCursor", { link = "Cursor" })
set(0, "TermCursor", { link = "Cursor" })
set(0, "CursorLine", { bg = p.bg_alt })
set(0, "CursorColumn", { bg = p.bg_alt })
set(0, "CursorLineNr", { fg = p.yellow, bold = true })
set(0, "LineNr", { fg = p.fg_faint })
set(0, "SignColumn", { bg = p.bg })
set(0, "ColorColumn", { bg = p.bg_alt })
set(0, "Visual", { bg = p.bg_border })
set(0, "VisualNOS", { link = "Visual" })
set(0, "Search", { fg = p.bg, bg = p.yellow, bold = true })
set(0, "IncSearch", { fg = p.bg, bg = p.orange, bold = true })
set(0, "CurSearch", { link = "IncSearch" })
set(0, "Substitute", { fg = p.bg, bg = p.orange, bold = true })
set(0, "MatchParen", { fg = p.orange, bg = p.bg_border, bold = true })
set(0, "NonText", { fg = p.fg_faint })
set(0, "Whitespace", { fg = p.bg_border })
set(0, "SpecialKey", { fg = p.fg_faint })
set(0, "EndOfBuffer", { fg = p.bg })
set(0, "Conceal", { fg = p.fg_muted })
set(0, "Directory", { fg = p.blue })
set(0, "Title", { fg = p.yellow, bold = true })
set(0, "ModeMsg", { fg = p.fg_dim, bold = true })
set(0, "MoreMsg", { fg = p.green })
set(0, "Question", { fg = p.green })
set(0, "QuickFixLine", { bg = p.bg_pop, bold = true })

set(0, "Pmenu", { fg = p.fg, bg = p.bg_pop })
set(0, "PmenuSel", { fg = p.bg, bg = p.yellow, bold = true })
set(0, "PmenuSbar", { bg = p.bg_border })
set(0, "PmenuThumb", { bg = p.bg_hover })
set(0, "WildMenu", { link = "PmenuSel" })
set(0, "NormalFloat", { fg = p.fg, bg = p.bg_float })
set(0, "FloatBorder", { fg = p.bg_hover, bg = p.bg_float })
set(0, "FloatTitle", { fg = p.yellow, bg = p.bg_float, bold = true })
set(0, "WinSeparator", { fg = p.bg_border })

set(0, "StatusLine", { fg = p.fg_dim, bg = p.bg_alt })
set(0, "StatusLineNC", { fg = p.fg_faint, bg = p.bg_alt })
set(0, "WinBar", { fg = p.fg_dim, bold = true })
set(0, "WinBarNC", { fg = p.fg_faint })
set(0, "TabLine", { fg = p.fg_faint, bg = p.bg_alt })
set(0, "TabLineSel", { fg = p.bg, bg = p.orange, bold = true })
set(0, "TabLineFill", { bg = p.bg_deep })
set(0, "Folded", { fg = p.fg_muted, bg = p.bg_alt, italic = true })
set(0, "FoldColumn", { fg = p.fg_faint, bg = p.bg })

set(0, "SpellBad", { undercurl = true, sp = p.red })
set(0, "SpellCap", { undercurl = true, sp = p.blue })
set(0, "SpellLocal", { undercurl = true, sp = p.aqua })
set(0, "SpellRare", { undercurl = true, sp = p.purple })

------------------------------------------------------------------
-- Comments, strings
------------------------------------------------------------------
set(0, "Comment", { fg = p.comment, italic = true })
set(0, "@comment", { link = "Comment" })
set(0, "@comment.documentation", { fg = p.doc_comment, italic = true })
set(0, "Todo", { fg = p.bg, bg = p.orange, bold = true })
set(0, "@comment.todo", { fg = p.bg, bg = p.orange, bold = true })
set(0, "@comment.note", { fg = p.bg, bg = p.blue, bold = true })
set(0, "@comment.warning", { fg = p.bg, bg = p.beige, bold = true })
set(0, "@comment.error", { fg = p.bg, bg = p.red, bold = true })

set(0, "String", { fg = p.green })
set(0, "@string", { link = "String" })
set(0, "@string.documentation", { fg = p.fg_muted, italic = true })
set(0, "@string.escape", { fg = p.orange, bold = true })
set(0, "@string.regexp", { fg = p.purple })
set(0, "@string.special.url", { fg = p.blue, underline = true })
set(0, "@character", { fg = p.green })
set(0, "@character.special", { fg = p.orange })

------------------------------------------------------------------
-- Identifiers
------------------------------------------------------------------
set(0, "@variable", { fg = p.fg })
set(0, "@variable.parameter", { fg = p.fg_dim, italic = true })
set(0, "@variable.member", { fg = p.beige })
set(0, "@property", { link = "@variable.member" })
set(0, "@variable.builtin", { fg = p.purple, italic = true })
set(0, "@module", { fg = p.beige })
set(0, "@namespace", { link = "@module" })
set(0, "@label", { fg = p.beige, bold = true })

------------------------------------------------------------------
-- Functions & keywords
------------------------------------------------------------------
set(0, "@function", { fg = p.yellow })
set(0, "@function.call", { fg = p.yellow })
set(0, "@function.builtin", { fg = p.yellow, italic = true })
set(0, "@function.method", { fg = p.yellow })
set(0, "@function.method.call", { fg = p.yellow })
set(0, "@function.macro", { fg = p.orange, bold = true })
set(0, "@constructor", { fg = p.aqua, bold = true })

set(0, "@keyword", { fg = p.orange })
set(0, "@keyword.function", { fg = p.orange, italic = true })
set(0, "@keyword.operator", { fg = p.orange })
set(0, "@keyword.return", { fg = p.orange, bold = true })
set(0, "@keyword.import", { fg = p.orange })
set(0, "@keyword.conditional", { fg = p.orange })
set(0, "@keyword.repeat", { fg = p.orange })
set(0, "@keyword.exception", { fg = p.red, bold = true })
set(0, "@keyword.modifier", { fg = p.orange, italic = true })
set(0, "@keyword.type", { fg = p.aqua, italic = true })
set(0, "@keyword.coroutine", { fg = p.orange, italic = true })
set(0, "@keyword.debug", { fg = p.orange, italic = true })
set(0, "@keyword.directive", { fg = p.purple })
set(0, "@keyword.directive.define", { link = "@keyword.directive" })

set(0, "@operator", { fg = p.orange })
set(0, "@punctuation.bracket", { fg = p.fg_muted })
set(0, "@punctuation.delimiter", { fg = p.fg_muted })
set(0, "@punctuation.special", { fg = p.orange })

------------------------------------------------------------------
-- Types & literals
------------------------------------------------------------------
set(0, "@type", { fg = p.aqua })
set(0, "@type.builtin", { fg = p.aqua, italic = true })
set(0, "@type.definition", { fg = p.aqua, bold = true })
set(0, "@type.qualifier", { fg = p.orange, italic = true })
set(0, "@attribute", { fg = p.beige })
set(0, "@attribute.builtin", { fg = p.beige, italic = true })
set(0, "@tag", { fg = p.aqua })
set(0, "@tag.builtin", { fg = p.aqua })
set(0, "@tag.attribute", { fg = p.beige })
set(0, "@tag.delimiter", { fg = p.fg_muted })

set(0, "@number", { fg = p.purple })
set(0, "@number.float", { fg = p.purple })
set(0, "@boolean", { fg = p.purple, italic = true })
set(0, "@constant", { fg = p.purple })
set(0, "@constant.builtin", { fg = p.purple, italic = true })
set(0, "@constant.macro", { fg = p.purple, bold = true })

------------------------------------------------------------------
-- Markup
------------------------------------------------------------------
set(0, "@markup.heading", { fg = p.yellow, bold = true })
set(0, "@markup.heading.1", { fg = p.orange, bold = true })
set(0, "@markup.heading.2", { fg = p.aqua, bold = true })
set(0, "@markup.strong", { bold = true })
set(0, "@markup.italic", { italic = true })
set(0, "@markup.strikethrough", { strikethrough = true })
set(0, "@markup.underline", { underline = true })
set(0, "@markup.link", { fg = p.blue, underline = true })
set(0, "@markup.link.url", { fg = p.blue, underline = true })
set(0, "@markup.link.label", { fg = p.purple })
set(0, "@markup.raw", { fg = p.green })
set(0, "@markup.list", { fg = p.orange })
set(0, "@markup.list.checked", { fg = p.green })
set(0, "@markup.list.unchecked", { fg = p.fg_faint })
set(0, "@markup.quote", { fg = p.fg_muted, italic = true })
set(0, "@diff.plus", { fg = p.green })
set(0, "@diff.minus", { fg = p.red })
set(0, "@diff.delta", { fg = p.orange })

------------------------------------------------------------------
-- LSP semantic tokens & LSP UI
------------------------------------------------------------------
set(0, "@lsp.type.variable", { link = "@variable" })
set(0, "@lsp.type.parameter", { link = "@variable.parameter" })
set(0, "@lsp.type.property", { link = "@variable.member" })
set(0, "@lsp.type.enumMember", { link = "@constant" })
set(0, "@lsp.type.function", { link = "@function" })
set(0, "@lsp.type.method", { link = "@function.method" })
set(0, "@lsp.type.type", { link = "@type" })
set(0, "@lsp.type.class", { link = "@type.definition" })
set(0, "@lsp.type.interface", { link = "@type" })
set(0, "@lsp.type.enum", { link = "@type.definition" })
set(0, "@lsp.type.struct", { link = "@type.definition" })
set(0, "@lsp.type.namespace", { link = "@module" })
set(0, "@lsp.type.decorator", { link = "@attribute" })
set(0, "@lsp.type.macro", { link = "@function.macro" })
set(0, "@lsp.type.event", { fg = p.purple })
set(0, "@lsp.type.typeParameter", { fg = p.aqua, italic = true })
set(0, "@lsp.type.regexp", { link = "@string.regexp" })
set(0, "@lsp.mod.readonly", { italic = true })
set(0, "@lsp.mod.deprecated", { strikethrough = true })
set(0, "@lsp.mod.documentation", { link = "@comment.documentation" })
set(0, "DiagnosticUnnecessary", { fg = p.fg_faint, italic = true })

set(0, "LspReferenceText", { bg = p.ref_bg })
set(0, "LspReferenceRead", { bg = p.ref_bg })
set(0, "LspReferenceWrite", { bg = p.ref_bg, underline = true, sp = p.blue })
set(0, "LspInlayHint", { fg = p.fg_faint, italic = true })
set(0, "LspCodeLens", { fg = p.fg_faint, italic = true })
set(0, "LspSignatureActiveParameter", { fg = p.orange, bold = true })

------------------------------------------------------------------
-- Legacy :syntax groups
------------------------------------------------------------------
set(0, "Statement", { fg = p.orange })
set(0, "Conditional", { fg = p.orange })
set(0, "Repeat", { fg = p.orange })
set(0, "Label", { fg = p.beige, bold = true })
set(0, "Operator", { fg = p.orange })
set(0, "Keyword", { fg = p.orange })
set(0, "Exception", { fg = p.red, bold = true })
set(0, "Include", { fg = p.orange })
set(0, "Define", { fg = p.orange })
set(0, "Macro", { fg = p.purple, bold = true })
set(0, "PreProc", { fg = p.purple })
set(0, "StorageClass", { fg = p.orange, italic = true })
set(0, "Structure", { fg = p.aqua })
set(0, "Typedef", { fg = p.aqua, bold = true })
set(0, "Type", { fg = p.aqua })
set(0, "Function", { fg = p.yellow })
set(0, "Identifier", { fg = p.fg })
set(0, "Constant", { fg = p.purple })
set(0, "Character", { fg = p.green })
set(0, "Number", { fg = p.purple })
set(0, "Boolean", { fg = p.purple, italic = true })
set(0, "Float", { fg = p.purple })
set(0, "Special", { fg = p.orange })
set(0, "SpecialChar", { fg = p.orange })
set(0, "Tag", { fg = p.aqua })
set(0, "Delimiter", { fg = p.fg_muted })
set(0, "Underlined", { fg = p.blue, underline = true })
set(0, "Ignore", { fg = p.fg_faint })

------------------------------------------------------------------
-- Diagnostics (tinted virtual-text surfaces, not flat gray)
------------------------------------------------------------------
set(0, "DiagnosticError", { fg = p.red })
set(0, "DiagnosticWarn", { fg = p.orange })
set(0, "DiagnosticInfo", { fg = p.blue })
set(0, "DiagnosticHint", { fg = p.aqua })
set(0, "DiagnosticOk", { fg = p.green })
set(0, "DiagnosticUnderlineError", { undercurl = true, sp = p.red })
set(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = p.orange })
set(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = p.blue })
set(0, "DiagnosticUnderlineHint", { undercurl = true, sp = p.aqua })
set(0, "DiagnosticVirtualTextError", { fg = p.red, bg = p.err_bg })
set(0, "DiagnosticVirtualTextWarn", { fg = p.orange, bg = p.warn_bg })
set(0, "DiagnosticVirtualTextInfo", { fg = p.blue, bg = p.info_bg })
set(0, "DiagnosticVirtualTextHint", { fg = p.aqua, bg = p.hint_bg })
set(0, "DiagnosticSignError", { fg = p.red })
set(0, "DiagnosticSignWarn", { fg = p.orange })
set(0, "DiagnosticSignInfo", { fg = p.blue })
set(0, "DiagnosticSignHint", { fg = p.aqua })
set(0, "Error", { fg = p.red, bold = true })
set(0, "ErrorMsg", { fg = p.red, bold = true })
set(0, "WarningMsg", { fg = p.orange, bold = true })

------------------------------------------------------------------
-- Diff (tinted line backgrounds; syntax stays readable inside)
------------------------------------------------------------------
set(0, "DiffAdd", { bg = p.diff_add_bg })
set(0, "DiffChange", { bg = p.diff_change_bg })
set(0, "DiffDelete", { fg = p.fg_faint, bg = p.diff_del_bg })
set(0, "DiffText", { bg = p.diff_text_bg, bold = true })
set(0, "Added", { fg = p.green })
set(0, "Changed", { fg = p.orange })
set(0, "Removed", { fg = p.red })

------------------------------------------------------------------
-- Gitsigns / Diffview / git-conflict
------------------------------------------------------------------
set(0, "GitSignsAdd", { fg = p.green })
set(0, "GitSignsChange", { fg = p.orange })
set(0, "GitSignsDelete", { fg = p.red })
set(0, "GitSignsChangeDelete", { fg = p.orange })
set(0, "GitSignsTopDelete", { fg = p.red })
set(0, "GitSignsUntracked", { fg = p.beige })
set(0, "GitSignsAddInline", { bg = p.conflict_cur_label })
set(0, "GitSignsDeleteInline", { bg = p.conflict_anc })
set(0, "GitSignsCurrentLineBlame", { fg = p.fg_faint, italic = true })

set(0, "DiffviewFilePanelTitle", { fg = p.aqua, bold = true })
set(0, "DiffviewFilePanelCounter", { fg = p.orange })
set(0, "DiffviewFilePanelFileName", { fg = p.fg })
set(0, "DiffviewDim1", { fg = p.fg_faint })

set(0, "GitConflictCurrent", { bg = p.conflict_cur })
set(0, "GitConflictCurrentLabel", { bg = p.conflict_cur_label })
set(0, "GitConflictIncoming", { bg = p.conflict_inc })
set(0, "GitConflictIncomingLabel", { bg = p.conflict_inc_label })
set(0, "GitConflictAncestor", { bg = p.conflict_anc })
set(0, "GitConflictAncestorLabel", { bg = p.conflict_anc })

------------------------------------------------------------------
-- nvim-cmp completion menu
------------------------------------------------------------------
set(0, "CmpItemAbbr", { fg = p.fg })
set(0, "CmpItemAbbrDeprecated", { fg = p.fg_faint, strikethrough = true })
set(0, "CmpItemAbbrMatch", { fg = p.orange, bold = true })
set(0, "CmpItemAbbrMatchFuzzy", { fg = p.beige })
set(0, "CmpItemMenu", { fg = p.fg_muted, italic = true })
set(0, "CmpGhostText", { fg = p.fg_faint, italic = true })
set(0, "CmpItemKindFunction", { fg = p.yellow })
set(0, "CmpItemKindMethod", { fg = p.yellow })
set(0, "CmpItemKindConstructor", { fg = p.aqua, bold = true })
set(0, "CmpItemKindVariable", { fg = p.fg })
set(0, "CmpItemKindField", { fg = p.beige })
set(0, "CmpItemKindProperty", { fg = p.beige })
set(0, "CmpItemKindClass", { fg = p.aqua, bold = true })
set(0, "CmpItemKindInterface", { fg = p.aqua })
set(0, "CmpItemKindStruct", { fg = p.aqua })
set(0, "CmpItemKindEnum", { fg = p.aqua, bold = true })
set(0, "CmpItemKindEnumMember", { fg = p.purple })
set(0, "CmpItemKindModule", { fg = p.beige })
set(0, "CmpItemKindKeyword", { fg = p.orange })
set(0, "CmpItemKindConstant", { fg = p.purple })
set(0, "CmpItemKindOperator", { fg = p.orange })
set(0, "CmpItemKindTypeParameter", { fg = p.aqua, italic = true })
set(0, "CmpItemKindEvent", { fg = p.purple })
set(0, "CmpItemKindUnit", { fg = p.purple })
set(0, "CmpItemKindValue", { fg = p.purple })
set(0, "CmpItemKindColor", { fg = p.aqua })
set(0, "CmpItemKindFile", { fg = p.beige })
set(0, "CmpItemKindFolder", { fg = p.beige })
set(0, "CmpItemKindReference", { fg = p.beige })
set(0, "CmpItemKindSnippet", { fg = p.green })
set(0, "CmpItemKindText", { fg = p.fg })

------------------------------------------------------------------
-- fzf-lua
------------------------------------------------------------------
set(0, "FzfLuaNormal", { fg = p.fg, bg = p.bg_float })
set(0, "FzfLuaBorder", { fg = p.bg_hover, bg = p.bg_float })
set(0, "FzfLuaTitle", { fg = p.bg, bg = p.orange, bold = true })
set(0, "FzfLuaPreviewNormal", { fg = p.fg, bg = p.bg_float })
set(0, "FzfLuaPreviewBorder", { fg = p.bg_hover, bg = p.bg_float })
set(0, "FzfLuaPreviewTitle", { fg = p.aqua, bg = p.bg_float, bold = true })
set(0, "FzfLuaCursorLine", { bg = p.bg_pop })
set(0, "FzfLuaSearch", { fg = p.orange, bold = true })
set(0, "FzfLuaHeaderBind", { fg = p.orange })
set(0, "FzfLuaHeaderText", { fg = p.fg_muted })
set(0, "FzfLuaPathColNr", { fg = p.fg_faint })
set(0, "FzfLuaPathLineNr", { fg = p.beige })
set(0, "FzfLuaBufName", { fg = p.purple })
set(0, "FzfLuaBufNr", { fg = p.orange })
set(0, "FzfLuaBufFlagCur", { fg = p.orange })
set(0, "FzfLuaBufFlagAlt", { fg = p.blue })
set(0, "FzfLuaTabTitle", { fg = p.aqua, bold = true })
set(0, "FzfLuaTabMarker", { fg = p.orange, bold = true })
set(0, "FzfLuaLiveSym", { fg = p.orange, bold = true })
set(0, "FzfLuaFzfMatch", { fg = p.orange, bold = true })
set(0, "FzfLuaFzfPrompt", { fg = p.orange })
set(0, "FzfLuaFzfPointer", { fg = p.orange })

------------------------------------------------------------------
-- Neo-tree (recessed sidebar)
------------------------------------------------------------------
set(0, "NeoTreeNormal", { fg = p.fg_dim, bg = p.bg_deep })
set(0, "NeoTreeNormalNC", { fg = p.fg_dim, bg = p.bg_deep })
set(0, "NeoTreeEndOfBuffer", { fg = p.bg_deep, bg = p.bg_deep })
set(0, "NeoTreeWinSeparator", { fg = p.bg_border, bg = p.bg })
set(0, "NeoTreeDirectoryName", { fg = p.fg_dim })
set(0, "NeoTreeDirectoryIcon", { fg = p.blue })
set(0, "NeoTreeRootName", { fg = p.aqua, bold = true })
set(0, "NeoTreeFileName", { fg = p.fg_dim })
set(0, "NeoTreeFileNameOpened", { fg = p.fg, bold = true })
set(0, "NeoTreeIndentMarker", { fg = p.bg_border })
set(0, "NeoTreeExpander", { fg = p.fg_faint })
set(0, "NeoTreeDotfile", { fg = p.fg_faint })
set(0, "NeoTreeGitAdded", { fg = p.green })
set(0, "NeoTreeGitModified", { fg = p.orange })
set(0, "NeoTreeGitDeleted", { fg = p.red })
set(0, "NeoTreeGitUntracked", { fg = p.beige })
set(0, "NeoTreeGitIgnored", { fg = p.fg_faint })
set(0, "NeoTreeGitConflict", { fg = p.red, bold = true })
set(0, "NeoTreeFloatBorder", { fg = p.bg_hover, bg = p.bg_deep })
set(0, "NeoTreeFloatTitle", { fg = p.aqua, bg = p.bg_deep, bold = true })
set(0, "NeoTreeTabActive", { fg = p.fg, bg = p.bg, bold = true })
set(0, "NeoTreeTabInactive", { fg = p.fg_faint, bg = p.bg_deep })

------------------------------------------------------------------
-- Flash (jump labels must be the loudest thing on screen)
------------------------------------------------------------------
set(0, "FlashBackdrop", { fg = p.fg_faint })
set(0, "FlashMatch", { fg = p.fg, bg = p.bg_border })
set(0, "FlashCurrent", { fg = p.bg, bg = p.yellow, bold = true })
set(0, "FlashLabel", { fg = p.bg, bg = p.orange, bold = true })
set(0, "FlashPrompt", { link = "NormalFloat" })

------------------------------------------------------------------
-- Which-key / Noice / Notify / Trouble
------------------------------------------------------------------
set(0, "WhichKey", { fg = p.orange, bold = true })
set(0, "WhichKeyGroup", { fg = p.blue })
set(0, "WhichKeyDesc", { fg = p.fg })
set(0, "WhichKeySeparator", { fg = p.fg_faint })
set(0, "WhichKeyNormal", { fg = p.fg, bg = p.bg_deep })
set(0, "WhichKeyTitle", { fg = p.aqua, bold = true })

set(0, "NoiceCmdlineIcon", { fg = p.orange })
set(0, "NoiceCmdlinePopupBorder", { fg = p.bg_hover, bg = p.bg_deep })
set(0, "NoiceCmdlinePopupTitle", { fg = p.aqua, bold = true })
set(0, "NoiceMini", { fg = p.fg_muted, bg = p.bg_alt })
set(0, "NoiceLspProgressTitle", { fg = p.fg_muted, italic = true })
set(0, "NoiceLspProgressClient", { fg = p.aqua })

set(0, "NotifyBackground", { bg = p.bg })
set(0, "NotifyERRORBorder", { fg = p.red })
set(0, "NotifyERRORIcon", { fg = p.red })
set(0, "NotifyERRORTitle", { fg = p.red, bold = true })
set(0, "NotifyWARNBorder", { fg = p.orange })
set(0, "NotifyWARNIcon", { fg = p.orange })
set(0, "NotifyWARNTitle", { fg = p.orange, bold = true })
set(0, "NotifyINFOBorder", { fg = p.bg_hover })
set(0, "NotifyINFOIcon", { fg = p.blue })
set(0, "NotifyINFOTitle", { fg = p.blue, bold = true })
set(0, "NotifyDEBUGBorder", { fg = p.bg_hover })
set(0, "NotifyDEBUGIcon", { fg = p.fg_muted })
set(0, "NotifyDEBUGTitle", { fg = p.fg_muted, bold = true })
set(0, "NotifyTRACEBorder", { fg = p.bg_hover })
set(0, "NotifyTRACEIcon", { fg = p.purple })
set(0, "NotifyTRACETitle", { fg = p.purple, bold = true })

set(0, "TroubleNormal", { fg = p.fg_dim, bg = p.bg_deep })
set(0, "TroubleNormalNC", { fg = p.fg_dim, bg = p.bg_deep })
set(0, "TroubleText", { fg = p.fg_dim })
set(0, "TroubleCount", { fg = p.bg, bg = p.yellow, bold = true })
set(0, "TroubleIndent", { fg = p.bg_border })

------------------------------------------------------------------
-- Indent guides / folds / scrollbar / misc UI
------------------------------------------------------------------
set(0, "IblIndent", { fg = p.bg_alt })
set(0, "IblWhitespace", { fg = p.bg_alt })
set(0, "IblScope", { fg = p.bg_hover })
set(0, "UfoFoldedEllipsis", { fg = p.orange })
set(0, "ScrollbarHandle", { bg = p.bg_pop })
set(0, "ZenBg", { fg = p.fg, bg = p.bg })
set(0, "TodoBgTODO", { fg = p.bg, bg = p.orange, bold = true })
set(0, "TodoFgTODO", { fg = p.orange })

------------------------------------------------------------------
-- Alpha dashboard / Lazy / Mason
------------------------------------------------------------------
set(0, "AlphaHeader", { fg = p.yellow })
set(0, "AlphaButtons", { fg = p.fg_dim })
set(0, "AlphaShortcut", { fg = p.orange, bold = true })
set(0, "AlphaFooter", { fg = p.fg_muted, italic = true })

set(0, "LazyH1", { fg = p.bg, bg = p.orange, bold = true })
set(0, "LazyButton", { fg = p.fg_dim, bg = p.bg_pop })
set(0, "LazyButtonActive", { fg = p.bg, bg = p.yellow, bold = true })
set(0, "LazySpecial", { fg = p.orange })
set(0, "LazyProgressDone", { fg = p.orange })
set(0, "LazyProgressTodo", { fg = p.bg_border })

set(0, "MasonHeader", { fg = p.bg, bg = p.orange, bold = true })
set(0, "MasonHighlight", { fg = p.blue })
set(0, "MasonHighlightBlock", { fg = p.bg, bg = p.yellow })
set(0, "MasonHighlightBlockBold", { fg = p.bg, bg = p.yellow, bold = true })
set(0, "MasonMuted", { fg = p.fg_muted })
set(0, "MasonMutedBlock", { fg = p.fg_dim, bg = p.bg_pop })

------------------------------------------------------------------
-- Terminal ANSI colors (bright row = same hue, +lightness)
------------------------------------------------------------------
vim.g.terminal_color_0 = p.bg_pop
vim.g.terminal_color_1 = p.red
vim.g.terminal_color_2 = p.green
vim.g.terminal_color_3 = p.yellow
vim.g.terminal_color_4 = p.blue
vim.g.terminal_color_5 = p.purple
vim.g.terminal_color_6 = p.aqua
vim.g.terminal_color_7 = p.fg_dim
vim.g.terminal_color_8 = p.fg_faint
vim.g.terminal_color_9 = "#f07168"
vim.g.terminal_color_10 = "#b8bb26"
vim.g.terminal_color_11 = "#fabd2f"
vim.g.terminal_color_12 = "#83a598"
vim.g.terminal_color_13 = "#d3869b"
vim.g.terminal_color_14 = "#8ec07c"
vim.g.terminal_color_15 = p.fg
