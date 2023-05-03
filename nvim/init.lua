-- vim.wo.colorcolumn = "80"
-- vim.opt.autoindent = true
-- vim.opt.expandtab = false
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4
return {
	lsp = {
		formatting = {
			format_on_save = false, -- enable or disable automatic formatting on save
		},
	},
	-- default_theme = {
	-- 	colors = {
	-- 		bg = "#000000"
	-- 	},
	-- },
	-- colorscheme = "material",
	colorscheme = "neverland2",
	options = {
		opt = {
			autoindent = true,
			expandtab = false,
			tabstop = 4,
			shiftwidth = 4,
		},
		wo = {
			colorcolumn = "80"
		},
		-- g = {
		-- everforest_background = "hard"
		-- },
	},
	plugins = {
		init = {
			{
				"marko-cerovac/material.nvim",
				"sainnhe/sonokai",
				"sainnhe/everforest",
				"KabbAmine/yowish.vim",
				"trapd00r/neverland-vim-theme",
				"AdnanHodzic/vim-hue",
				"xiyaowong/transparent.nvim",
				"42Paris/42header",
			},
		},
	},
}
