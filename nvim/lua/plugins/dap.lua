return {
    {
        'mfussenegger/nvim-dap',
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio'
        },
    },
    {
        'leoluz/nvim-dap-go',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },
}
