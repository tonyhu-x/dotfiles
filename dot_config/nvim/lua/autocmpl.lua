local cmp = require('cmp')

require('cmp_luasnip_choice').setup {
    auto_open = true
}

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item()
                else
                  cmp.confirm()
            end
            else
                fallback()
            end
        end, {"i","s","c",}
        ),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip_choice' },
        },
        {
            { name = 'buffer' },
        }
    ),
}

-- cmp.setup.filetype("tex", {
--     sources = {
--         { name = 'vimtex' },
--     },
-- })

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {
            { name = 'path' },
        },
        {
            { name = 'cmdline' },
        }
    ),
})
