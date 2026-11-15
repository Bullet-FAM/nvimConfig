-- 快捷键
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('i', 'jj', '<ESC>')

-- 全项目搜索（只搜不改，结果进 quickfix；]q / [q 是内置的跳转键）
vim.keymap.set('n', '<leader>sg', function()
    local pattern = vim.fn.input('rg> ')
    if pattern == '' then
        return
    end
    vim.cmd('grep! ' .. vim.fn.shellescape(pattern))
    vim.cmd('copen')
end, { desc = '搜索: 全项目文本' })

vim.keymap.set('n', '<leader>sw', function()
    vim.cmd('grep! ' .. vim.fn.shellescape(vim.fn.expand('<cword>')))
    vim.cmd('copen')
end, { desc = '搜索: 光标下的词' })
