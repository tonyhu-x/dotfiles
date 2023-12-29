HOME = os.getenv("HOME")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
 
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
-- this tells it to use same value as tabstop
vim.opt.shiftwidth = 0

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

-- numbering
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmenu = true
vim.opt.splitright = true

-- diagnostics
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { numhl = sign.name })
end

-- file format
-- create new files with CRLF in Windows directories
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*',
    callback = function()
        if string.find(vim.fn.expand('%:p'), 'mnt') ~= nil then
            vim.opt.ff = 'dos'
        end
        if string.find(vim.fn.getcwd(), 'mnt') ~= nil then
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
    auto_install = true,
    highlight = {
        enable = true,
        disable = {"latex"}
    },
    indent = {
        enable = true
    }
}

