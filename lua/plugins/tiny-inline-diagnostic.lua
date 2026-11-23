-- 诊断显示：tiny-inline-diagnostic.nvim
-- 它接管行内诊断的渲染，所以 lua/config/lsp.lua 里已经把 virtual_text 关掉，
-- 否则两套渲染会重叠
return {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = {
        options = {
            -- 多条诊断分层显示，而不是挤在同一行
            multilines = { enabled = true },
            -- 显示来源（clangd / rust_analyzer 等）
            show_source = { enabled = true },
            -- 超宽消息折行（默认就是 wrap，写出来是为了以后不被默认值变化影响）
            overflow = { mode = 'wrap' },
        },
    },
}
