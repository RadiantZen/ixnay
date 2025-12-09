local lspconfig = require("lspconfig")

lspconfig.bashls.setup({})
lspconfig.lua_ls.setup({})
lspconfig.marksman.setup({})
-- lspconfig.nil_ls.setup{}
lspconfig.nixd.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.tinymist.setup({
	settings = {
		exportPdf = "never",
	},
})
lspconfig.harper_ls.setup({})
