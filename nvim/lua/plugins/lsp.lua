return {
    -- lsp + cmp + dap
    {
        'neovim/nvim-lspconfig',
        priority = 256,

    },
    {
        'williamboman/mason.nvim',
        priority = 128,
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
            ---@type string[]
            ensure_installed = {
                'lua_ls',
            },

            ---@type boolean
            automatic_installation = true,
        },
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'saadparwaiz1/cmp_luasnip',
        'f3fora/cmp-spell',
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local function mapkey_base(key, func, desc)
                vim.keymap.set(
                    'n',
                    key,
                    func,
                    {
                        noremap = true,
                        silent = true,
                        desc = desc,
                    }
                )
            end
            local function mapkey(key, func, desc)
                mapkey_base('leader' .. key, func, desc)
            end
            local dap = require('dap')
            mapkey('!s', dap.continue, 'Start debugg session')
            mapkey('!b', dap.toggle_breakpoint, 'Toggle break point')
            mapkey('!r', dap.repl.open, 'Open REPL')
            mapkey_base('<F9>', dap.continue, 'Step')
            mapkey_base('<F10>', dap.continue, 'Step Into')
            mapkey_base('<F11>', dap.continue, 'Step Out')
            mapkey_base('<F12>', dap.continue, 'Run')
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio'
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end

            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        config = true,
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        config = function()
            require('dap-python').setup("python3")
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        priority = 128,
        config = function()
            cmp = require('cmp')
            cmp.setup(
                {
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body)
                        end
                    },
                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-j>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-k>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources(
                        {
                            { name = 'nvim_lsp' },
                            { name = 'luasnip' },
                            { name = 'nvim_lsp_signature_help' },
                            {
                                name = 'spell',
                                option = {
                                    keep_all_entries = false,
                                    enable_in_context = function()
                                        return true
                                    end,
                                },
                            },
                        },
                        {
                            { name = 'buffer' },
                        }
                    ),
                }
            )
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
        ---@param opts TSConfig
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        event = { 'VeryLazy' },
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require('nvim-treesitter')`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require('lazy.core.loader').add_to_rtp(plugin)
            require('nvim-treesitter.query_predicates')
        end,
        opts_extend = { 'ensure_installed' },
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'diff',
                'go',
                'java',
                'json',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'regex',
                'toml',
                'vim',
                'vimdoc',
                'xml',
                'yaml',
            },
            sync_install = false,
            auto_install = true,
            modules = {},
            ignore_install = {},
            incremental_selection = { enabled = false },
            identation = { enabled = false },
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        },
    },
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
    },

    -- breadcrumbs
    {
        'SmiteshP/nvim-navic',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
    },
    {
        'utilyre/barbecue.nvim',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            --attach_navic = false,
            symbols = {
                separator = '󰿟',
            },
            kinds = {
                Array = '󰅪',
                Boolean = '',
                Class = '',
                Constant = '󰏿',
                Constructor = '',
                Enum = '',
                EnumMember = '',
                Event = '',
                Field = '',
                File = '',
                Function = '󰊕',
                Interface = '',
                Key = '󰌋',
                Method = '',
                Module = '',
                Null = '',
                Namespace = '',
                Number = '',
                Object = '',
                Operator = '',
                Package = '',
                Property = '',
                String = '',
                Struct = '󰙅',
                TypeParameter = '',
                Variable = '',
            },
        },
    },
}
