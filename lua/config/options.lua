-- 基础选项
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- 仅在存在图形/终端剪贴板时启用；SSH、无显示环境下不设置，避免 yank 报错
if vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY then
  vim.opt.clipboard = 'unnamedplus'
end

-- 运行时自带插件：停止操作后自动清除搜索高亮
vim.cmd('packadd! nohlsearch')
