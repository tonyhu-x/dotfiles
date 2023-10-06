-- auto run :PackerCompile
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'sainnhe/gruvbox-material'

    -- lualine requires a patched font with icons
    -- we can find one from ryanoasis/nerd-fonts
    use {
	    'nvim-lualine/lualine.nvim',
	    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use 'nanozuki/tabby.nvim'
    use {
        'justinmk/vim-sneak',
        config = function()
            vim.cmd('let g:sneak#label = 1')
        end
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
                mappings = {
                    basic = false,
                    extra = false
                }
            }
        end
    }

    use {
        'NMAC427/guess-indent.nvim',
        config = function()
            require('guess-indent').setup({})
        end
    }

    use {
        'folke/which-key.nvim',
        config = function()
            vim.opt.timeout = true
            vim.opt.timeoutlen = 500
            require('which-key').setup()
        end,
    }

    use {
        'nvim-tree/nvim-tree.lua',
	    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('nvim-tree').setup {
                sort_by = 'extension',
                view = {
                    width = {},
                },
            }
        end,
    }

    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        run = ':MasonUpdate',
    }

    use {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/cmp-luasnip-choice',
    }
end)

