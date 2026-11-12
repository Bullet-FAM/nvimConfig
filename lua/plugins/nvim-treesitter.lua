-- 语法高亮：nvim-treesitter（main 分支，新 API）
-- 注意：main 分支已经删掉了 nvim-treesitter.configs，只剩下：
--   require('nvim-treesitter').setup { install_dir = ... }
--   require('nvim-treesitter').install { 'bash', 'lua', ... }
-- 高亮也不再由插件的 highlight 模块开启，而是靠 FileType autocmd 调 vim.treesitter.start()
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    -- 高亮依赖 FileType autocmd，必须尽早加载；VeryLazy 会错过第一个 buffer
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup()

        -- 打开文件时启动 treesitter 高亮（parser 没装时 pcall 静默跳过）
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('ts-highlight', { clear = true }),
            callback = function(ev)
                pcall(vim.treesitter.start, ev.buf)
            end,
        })
    end,
}
