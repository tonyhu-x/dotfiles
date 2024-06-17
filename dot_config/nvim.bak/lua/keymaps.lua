local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('', '`', '\'', opts)
keymap('', '\'', '`', opts)
keymap('', '<C-s>', ':w<CR>', opts)

keymap('i', '<C-c>', '<Esc>', opts)

keymap('t', '<C-c>', '<C-\\><C-n>', opts)
keymap('t', '<C-\\><C-c>', '<C-c>', opts)

-- window management
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- telescope
keymap('n', '<leader>f', require('telescope.builtin').live_grep, vim.tbl_extend('error', opts, { desc = 'Telescope: live grep' }))
keymap('n', '<leader>b', require('telescope.builtin').buffers, vim.tbl_extend('error', opts, { desc = 'Telescope: open buffers' }))
keymap('n', '<C-p>', require('telescope.builtin').find_files, vim.tbl_extend('error', opts, { desc = 'Telescope: find files' }))

-- comment
keymap('n', '<leader>cc', function()
    return vim.v.count == 0
        and '<Plug>(comment_toggle_linewise_current)'
        or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true })

keymap('x', '<leader>c', '<Plug>(comment_toggle_linewise_visual)')

-- nvim-tree
local tree = require('nvim-tree.api')
keymap('n', '<leader>e', tree.tree.toggle, opts)
keymap('n', '<leader>E', function()
    tree.tree.find_file({ open = true, focus = true })
end, opts)

-- unused keymap for netrw
-- keymap('', '<leader>e', ':e %:p:h<CR>', opts) -- explore directory of current buffer
