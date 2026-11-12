-- LSP 配置
-- Neovim 0.11+ 用内置的 vim.lsp.config / vim.lsp.enable；
-- nvim-lspconfig 只作为 mason-lspconfig 的依赖，提供各 server 的默认 cmd / filetypes / root_markers。

-- 诊断显示（0.11 起 virtual_text 默认开启，这里只是调样式）
vim.diagnostic.config({
    virtual_text = { spacing = 2, prefix = '●' },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = true },
})

-- bashls：npm 全局安装，mason 不管它，所以 cmd 写死并手动 enable
vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh', 'zsh' },
    -- 非 git 目录里的单文件脚本也能挂上（root_dir 为 nil 时按单文件处理）
    root_markers = { '.git', '.shellcheckrc', '.editorconfig' },
    settings = {
        bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
        },
    },
})
vim.lsp.enable('bashls')

-- clangd：系统安装，手动 enable；cmd / filetypes / root_markers 由 nvim-lspconfig 提供
vim.lsp.enable('clangd')

-- 下面三个由 mason-lspconfig 自动 enable（见 lua/plugins/mason-lspconfig.lua），
-- 这里只覆盖 settings，不要再写 vim.lsp.enable，否则同一个 server 会被启用两次
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                checkThirdParty = false,
                -- 让 lua_ls 认识 vim.* 的 API
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { maxLineLength = 100 },
            },
        },
    },
})

vim.lsp.config('jsonls', {
    settings = {
        json = { validate = { enable = true } },
    },
})

-- LSP 快捷键：只补 Neovim 默认映射没覆盖的部分
-- 0.11 起内置已有 grn / gra / grr / gri / gO / K / gd，
-- 千万不要再映射 gr，那会把整个 gr* 前缀吃掉
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[N]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
        map('<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, '[F]ormat buffer')
    end,
})

-- 诊断跳转
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = '上一个诊断' })

vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = '下一个诊断' })
