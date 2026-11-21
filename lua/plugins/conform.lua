-- 格式化：conform.nvim
-- 这里只负责“用什么格式化”，LSP 继续负责语言分析；
-- 没有配置 formatter 的文件类型会回退到 LSP 格式化（lsp_format = 'fallback'）
return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format({ async = true, lsp_format = 'fallback' })
            end,
            mode = { 'n', 'v' }, -- 普通模式整篇 / 可视模式选区
            desc = '格式化',
        },
    },
    opts = {
        formatters_by_ft = {
            sh = { 'shfmt' },
            bash = { 'shfmt' },
            zsh = { 'shfmt' },
            lua = { 'stylua' },
            -- python 故意不列出：走 lsp_format = 'fallback'，
            -- 由 pylsp（内部自带 autopep8 / black / yapf）处理。
            -- 以后装了 ruff 再换成 python = { 'ruff_format' } 即可。
            rust = { 'rustfmt' },
            c = { 'clang-format' },
            cpp = { 'clang-format' },
            json = { 'jq' },
            jsonc = { 'prettier' },
            yaml = { 'prettier' },
            toml = { 'taplo' },
            markdown = { 'prettier' },
            html = { 'prettier' },
            css = { 'prettier' },
            scss = { 'prettier' },
            less = { 'prettier' },
        },
        formatters = {
            -- 全局约定是 4 空格缩进，把两个默认不吃这套的 formatter 对齐
            shfmt = {
                prepend_args = { '-i', '4', '-ci' },
            },
            stylua = {
                -- stylua 默认是 Tab，必须显式改成空格
                prepend_args = { '--indent-type', 'Spaces', '--indent-width', '4' },
            },
            -- 项目里有 .clang-format 就听项目的，没有才用 4 空格兜底
            ['clang-format'] = {
                args = function(self, ctx)
                    local style = '-style=file'
                    local found = vim.fs.find(
                        { '.clang-format', '_clang-format' },
                        { path = ctx.dirname, upward = true }
                    )[1]
                    if not found then
                        style = '-style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 100}'
                    end
                    return { '-assume-filename', ctx.filename, style }
                end,
            },
        },
        default_format_opts = {
            lsp_format = 'fallback',
            timeout_ms = 1000,
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_format = 'fallback',
        },
    },
}
