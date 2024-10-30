local function mapkey(mapping, func, desc)
    vim.keymap.set('n', '<leader>' .. mapping, func, { noremap = true, silent = true, desc = desc })
end

navic = require('nvim-navic')

vim.api.nvim_create_autocmd(
    'LspAttach',
    {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if client == nil then
                return
            end

            mapkey('d', vim.lsp.buf.definition, 'Go to definition')
            mapkey('D', vim.lsp.buf.declaration, 'Go to declaration')
            mapkey('h', vim.lsp.buf.hover, 'Hover')
            mapkey('i', vim.lsp.buf.implementation, 'Go to Implementation')
            mapkey('r', vim.lsp.buf.rename, 'Rename')
            mapkey('R', vim.lsp.buf.references, 'Find references')
            mapkey('s', vim.lsp.buf.signature_help, 'Signature help')
            mapkey('td', vim.lsp.buf.type_definition, 'Go to type definition')
            mapkey('e', vim.diagnostic.open_float, 'Show errors')
            mapkey('el', vim.diagnostic.setloclist, 'Show errors on location list')
            mapkey('en', vim.diagnostic.goto_next, 'Go to the next error')
            mapkey('ep', vim.diagnostic.goto_prev, 'Go to the previous error')

            -- Fromat on write
            if client.server_capabilities.documentFormattingProvider then
                mapkey('f', vim.lsp.buf.format, 'Formats document')
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = args.buf,
                    callback = function()
                        vim.lsp.buf.format({
                            bufnr = args.buf,
                            id = client.id,
                        })
                    end,
                })
            end

            -- highlight on cursor hover
            if client.server_capabilities.documentHighlightProvider then
                local hl_options = {
                    bold = true,
                    bg = 'LightGreen',
                }
                vim.api.nvim_set_hl(0, 'LspReferenceRead', hl_options)
                vim.api.nvim_set_hl(0, 'LspReferenceText', hl_options)
                vim.api.nvim_set_hl(0, 'LspReferenceWrite', hl_options)
                local augroup = vim.api.nvim_create_augroup('lsp_document_highlight', {})
                vim.api.nvim_clear_autocmds({
                    buffer = args.buf,
                    group = augroup,
                })
                vim.api.nvim_create_autocmd('CursorHold', {
                    callback = function()
                        vim.lsp.buf.document_highlight()
                    end
                })
                vim.api.nvim_create_autocmd('CursorMoved', {
                    callback = function()
                        vim.lsp.buf.clear_references()
                    end
                })
            end

            -- config breadcrumbs
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, args.buf)
            end

            -- removel lsp highlight
            client.server_capabilities.semanticTokensProvider = nil
        end,
    }
)
