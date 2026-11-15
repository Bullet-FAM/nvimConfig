-- 基础选项
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- 分屏
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true
-- 仅在存在图形/终端剪贴板时启用；SSH、无显示环境下不设置，避免 yank 报错
if vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY then
    vim.opt.clipboard = "unnamedplus"
end

vim.opt.showmode = false

-- 搜索：用 ripgrep 驱动 :grep / :lgrep，结果进 quickfix
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --glob=!.git/*"
vim.opt.grepformat = "%f:%l:%c:%m"
