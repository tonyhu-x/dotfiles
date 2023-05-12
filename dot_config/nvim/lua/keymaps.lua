local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = ' '

keymap('', '`', '\'', opts)
keymap('', '\'', '`', opts)
keymap('', '<C-s>', ':w<CR>', opts)
keymap('', '<leader>e', ':e %:p:h<CR>', opts) -- explore directory of current buffer

keymap('i', '<C-c>', '<Esc>', opts)

-- telescope
keymap('n', '<leader>f', require('telescope.builtin').live_grep, vim.tbl_extend('error', opts, { desc = 'Live grep' }))
keymap('n', '<leader>b', require('telescope.builtin').buffers, vim.tbl_extend('error', opts, { desc = 'Open buffers' }))
keymap('n', '<leader>t', require('telescope.builtin').treesitter, vim.tbl_extend('error', opts, { desc = 'Treesitter' }))

-- comment
keymap('n', '<leader>cc', function()
    return vim.v.count == 0
        and '<Plug>(comment_toggle_linewise_current)'
        or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true })

keymap('x', '<leader>c', '<Plug>(comment_toggle_linewise_visual)')
