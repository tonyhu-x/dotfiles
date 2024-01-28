require('neodev').setup()
require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local tsbuiltin = require('telescope.builtin')

local keymap = vim.keymap.set

local add_desc = function(opts, desc)
    return vim.tbl_extend('error', opts, { desc = desc})
end

lspconfig.pyright.setup {
    capabilities = cmp_capabilities
}
lspconfig.lua_ls.setup {
    capabilities = cmp_capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    }
}
lspconfig.typst_lsp.setup {
    root_dir = function() return vim.fn.getcwd() end,
    settings = {
        exportPdf = "never",
    }
}
lspconfig.tsserver.setup {}
lspconfig.texlab.setup {
    capabilities = cmp_capabilities,
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, noremap = true, silent = true }
        keymap('n', 'go', tsbuiltin.lsp_document_symbols, add_desc(opts, 'Telescope: document symbols'))
        keymap('n', 'gD', vim.lsp.buf.declaration, opts)
        keymap('n', 'gd', tsbuiltin.lsp_definitions, add_desc(opts, 'Telescope: go to definition'))
        keymap('n', 'gr', tsbuiltin.lsp_references, add_desc(opts, 'Telescope: references'))
        keymap('n', 'gh', vim.lsp.buf.hover, opts)
        keymap('n', '<leader>r', vim.lsp.buf.rename, opts)
        keymap({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        keymap('n', '<leader>F', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
