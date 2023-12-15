-- Packer Bootloader
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Auto sync plugins
local packer_au_group = 'packer_user_config'
vim.api.nvim_create_augroup(packer_au_group, {clear = true})
vim.api.nvim_create_autocmd(
    {'BufWritePost'},
    {
        group = packer_au_group,
        command = 'source <afile> | PackerSync',
        pattern = 'plugins.lua',
    }
)

-- Plugins being used
return require('packer').startup(function(use)
    -- package manager
    use { 'wbthomason/packer.nvim' }

    -- color scheme
    use { 'ellisonleao/gruvbox.nvim' }
    use { 'jacoborus/tender.vim' }
    use {
        "loctvl842/monokai-pro.nvim",
        config = function()
            require("monokai-pro").setup()
        end
    }

    -- LSP / Auto completion / Treesitter / Snippts / Spell check
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',
        'f3fora/cmp-spell',
        'hrsh7th/cmp-nvim-lsp-signature-help',
    }
    use {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- DAP
    use 'mfussenegger/nvim-dap'

    -- winbar (breadcrumbs)
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    }
    use 'nvim-tree/nvim-web-devicons'
    use {
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        --after = "nvim-web-devicons",
        config = function()
            require("barbecue").setup({
                --attach_navic = false,
                symbols = {
                    separator = "/",
                },
                kinds = {
                    Array = "*",
                    Boolean = "*",
                    Class = "*",
                    Constant = "*",
                    Constructor = "*",
                    Enum = "*",
                    EnumMember = "*",
                    Event = "*",
                    Field = "*",
                    File = " ",
                    Function = "",
                    Interface = "*",
                    Key = "*",
                    Namespace = " ",
                    Method = "",
                    Module = "*",
                    Null = "*",
                    Number = "*",
                    Object = "*",
                    Operator = "*",
                    Package = "*",
                    Property = "*",
                    String = "*",
                    Struct = "*",
                    TypeParameter = "*",
                    Variable = "*",
                },
            })
        end,
    }

    -- Idententation lines
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end,
    }

    -- notifications
    use 'rcarriga/nvim-notify'

    -- force sync on first intallation of package manager
    if Packer_bootstrap then
        require('packer').sync()
    end
end)
