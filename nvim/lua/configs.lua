-- Column
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.colorcolumn = 100

-- General
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.guicursor = ''
vim.o.cursorline = true
vim.g.mapleader = ' '

-- Netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1

-- Tabs / Ident
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.autoindent = true

-- Notifications
vim.notify = require('notify')
