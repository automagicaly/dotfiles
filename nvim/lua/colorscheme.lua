vim.g.termguicolors = true
vim.g.background = 'dark'
vim.g.syntax = 'off'
vim.cmd.colorscheme('gruvbox')
local hl_group = 'MatchParen'
local hl = vim.api.nvim_get_hl_by_name(hl_group, true)
hl['bold'] = true
hl['underline'] = true
vim.api.nvim_set_hl(0, hl_group, hl)

-- Treesitter
local treesiter = require('nvim-treesitter.configs')
treesiter.setup {
    ensure_installed = { 'python', 'lua' },
    sync_install = false,
    auto_install = true,
    modules = {},
    ignore_install = {},
    incremental_selection = { enabled = false},
    identation = { enabled = false},
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
