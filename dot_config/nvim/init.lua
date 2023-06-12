local init_vscode

local init_all = function()
    if vim.g.vscode == nil then
        require('settings')
        require('plugins')
        require('keymaps')
        require('lsp')
        require('autocmpl')
        require('tabby')
    else
        init_vscode()
    end
end

init_vscode = function()
    local opts = { noremap = true, silent = true }
    local keymap = vim.keymap.set

    vim.g.mapleader = ' '

    keymap('', '`', '\'', opts)
    keymap('', '\'', '`', opts)
    keymap('', '<leader>e', "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>", opts)
    keymap('', '<leader>E', "<Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>", opts)
    keymap('', '<leader>p', "<Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>", opts)

    keymap('i', '<C-c>', '<Esc>', opts)

    -- <Cmd> mappings technically don't need <silent>
    keymap({'n', 'v'}, 'gD', "<Cmd>call VSCodeNotify('editor.action.peekDeclaration')<CR>", opts)
    keymap({'n', 'v'}, 'gd', "<Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>", opts)
    keymap({'n', 'v'}, 'gr', "<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>", opts)
    keymap({'n', 'v'}, 'gh', "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>", opts)
    keymap({'n', 'v'}, 'go', "<Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>", opts)

    keymap('n', '<leader>r', "<Cmd>call VSCodeNotify('editor.action.rename')<CR>", opts)

    HOME = os.getenv("HOME")
     
    vim.opt.mouse = 'a'
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.wrap = false

    vim.opt.scrolloff = 3
    vim.opt.sidescrolloff = 5

    vim.opt.wildmenu = true
    vim.opt.splitright = true

    -- swap file
    vim.opt.swapfile = false
end

init_all()
