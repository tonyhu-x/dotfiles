local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- auto run :PackerCompile
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("sainnhe/gruvbox-material")
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- lualine requires a patched font with icons
	-- we can find one from ryanoasis/nerd-fonts
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use("nanozuki/tabby.nvim")
	use({
		"justinmk/vim-sneak",
		config = function()
			vim.cmd("let g:sneak#label = 1")
			vim.cmd("let g:sneak#use_ic_scs = 1")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				mappings = {
					basic = false,
					extra = false,
				},
			})
		end,
	})

	use({
		"NMAC427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 500
			require("which-key").setup()
		end,
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("nvim-tree").setup({
				sort_by = "extension",
				view = {
					width = {},
				},
			})
		end,
	})

	use("folke/neodev.nvim")

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		run = ":MasonUpdate",
	})

	use({
		"L3MON4D3/LuaSnip",
		"micangl/cmp-vimtex",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/cmp-luasnip-choice",
	})

	use({
		"lervag/vimtex",
		config = function()
			vim.cmd("let g:vimtex_complete_enabled = 0")
			vim.cmd('let g:vimtex_view_method = "sioyek"')
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
