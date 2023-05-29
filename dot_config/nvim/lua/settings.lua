HOME = os.getenv("HOME")
vim.opt.exrc = true
 
-- theme and related settings
if vim.opt.termguicolors ~= nil then
    vim.opt.termguicolors = true
end
vim.cmd('colorscheme gruvbox-material')
require('lualine').setup {
    options = {
        theme = 'gruvbox-material'
    }
}

vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

-- numbering
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmenu = true
vim.opt.splitright = true

-- file format
-- create new files with CRLF in Windows directories
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*',
    callback = function()
        if string.find(vim.fn.expand('%:p'), 'mnt') ~= nil then
            vim.opt.ff = 'dos'
        end
    end
})

-- swap file
vim.opt.directory = HOME .. '/.vim/tmp/swap//'

-- saving
vim.opt.aw = true
-- vim.cmd('au InsertLeave * w') -- write file on insert exit

-- treesitter
require('nvim-treesitter.install').prefer_git = true
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    }
}

