-- core
-- require "phil.plugins"
require("phil.options")
require("phil.plugins-lazy")
require("phil.theme")
require("phil.keymaps")
require("phil.lualine")
--plugins
require("phil.nvim-cmp")
-- require "phil.lsp.null"
require("phil.conform")
require("phil.lint")
-- require "phil.lsp.lsp-installer"
require("phil.mason")
require("phil.lsp.lsp-mason")
require("phil.lsp.lspconfig")
require("phil.lsp.rust")
require("phil.luasnip")
require("phil.lsp.keymaps")
require("phil.neo-tree")
require("phil.treesitter")
require("phil.comment")
require("phil.surround")
require("phil.autopairs")
require("phil.fold")
-- require "phil.mini-pairs"
-- require "phil.bufferline"
-- require "phil.tabby"
require("phil.telescope")
require("phil.trouble")
require("phil.gitsigns")
require("phil.toggleterm")
require("phil.whichkey")
require("phil.outline")
require("phil.markdown-preview")
-- require "phil.glow"
-- require "phil.colorizor"
require("phil.zen")
require("phil.octo")
require("phil.session")
require("phil.dap")

-- fix https://github.com/neovim/neovim/issues/21856
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	callback = function()
		vim.fn.jobstart("", { detach = true })
	end,
})

local scnvim = require("scnvim")
local map = scnvim.map
local map_expr = scnvim.map_expr

scnvim.setup({
	keymaps = {
		["<M-e>"] = map("editor.send_line", { "i", "n" }),
		["<C-e>"] = {
			map("editor.send_block", { "i", "n" }),
			map("editor.send_selection", "x"),
		},
		["<CR>"] = map("postwin.toggle"),
		["<M-CR>"] = map("postwin.toggle", "i"),
		["<M-L>"] = map("postwin.clear", { "n", "i" }),
		["<C-k>"] = map("signature.show", { "n", "i" }),
		["<F12>"] = map("sclang.hard_stop", { "n", "x", "i" }),
		["<leader>st"] = map("sclang.start"),
		["<leader>sk"] = map("sclang.recompile"),
		["<F1>"] = map_expr("s.boot"),
		["<F2>"] = map_expr("s.meter"),
	},
	editor = {
		highlight = {
			color = "IncSearch",
		},
	},
	postwin = {
		float = {
			enabled = true,
		},
	},
})
