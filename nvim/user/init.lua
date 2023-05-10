-- vim.wo.colorcolumn = "80"
-- vim.opt.autoindent = true
-- vim.opt.expandtab = false
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4
vim.api.nvim_command('highlight Normal guibg=NONE')
return {
	lsp = {
		formatting = {
			format_on_save = false, -- enable or disable automatic formatting on save
		},
	},
	plugins = {
		"marko-cerovac/material.nvim",
		"sainnhe/sonokai",
		"sainnhe/everforest",
		"KabbAmine/yowish.vim",
		"trapd00r/neverland-vim-theme",
		"AdnanHodzic/vim-hue",
		"42Paris/42header",
		"shaunsingh/nord.nvim",
	},
	-- default_theme = {
	-- 	colors = {
	-- 		bg = "#000000"
	-- 	},
	-- },
	-- colorscheme = "material",
	colorscheme = "nord",
	highlight = {
		Normal = {
			guibg = "None"
		},
	},
	options = {
		opt = {
			autoindent = true,
			expandtab = false,
			tabstop = 4,
			shiftwidth = 4,
		},
		wo = {
			colorcolumn = "80",
		},
		-- g = {
		-- everforest_background = "hard"
		-- },
	},
}
