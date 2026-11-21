-- LSP 配置
-- Neovim 0.11+ 用内置的 vim.lsp.config / vim.lsp.enable；
-- nvim-lspconfig 只作为 mason-lspconfig 的依赖，提供各 server 的默认 cmd / filetypes / root_markers。

-- 诊断显示（0.11 起 virtual_text 默认开启，这里只是调样式）
vim.diagnostic.config({
    virtual_text = { spacing = 2, prefix = "●" },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = true },
})

-- bashls：npm 全局安装，mason 不管它，所以 cmd 写死并手动 enable
vim.lsp.config("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh", "zsh" },
    -- 非 git 目录里的单文件脚本也能挂上（root_dir 为 nil 时按单文件处理）
    root_markers = { ".git", ".shellcheckrc", ".editorconfig" },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
        },
    },
})
vim.lsp.enable("bashls")

-- clangd：系统安装，手动 enable；cmd / filetypes / root_markers 由 nvim-lspconfig 提供
vim.lsp.enable("clangd")

-- 下面三个由 mason-lspconfig 自动 enable（见 lua/plugins/mason-lspconfig.lua），
-- 这里只覆盖 settings，不要再写 vim.lsp.enable，否则同一个 server 会被启用两次
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                checkThirdParty = false,
                -- 让 lua_ls 认识 vim.* 的 API
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config("pylsp", {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { maxLineLength = 100 },
            },
        },
    },
})

vim.lsp.config("jsonls", {
    settings = {
        json = {
            validate = { enable = true },
            -- package.json 的字段补全 / 校验来自 SchemaStore（需联网，jsonls 会缓存）
            schemas = {
                {
                    fileMatch = { "package.json" },
                    url = "https://json.schemastore.org/package.json",
                },
            },
        },
    },
})

-- lua/config/lsp.lua 追加
vim.lsp.config("ts_ls", {
    settings = {
        typescript = {
            inlayHints = {
                parameterNames = { enabled = "literals" },
                variableTypes = { enabled = false },
            },
        },
        javascript = {
            inlayHints = {
                parameterNames = { enabled = "literals" },
            },
        },
    },
})
-- LSP 快捷键：只补 Neovim 默认映射没覆盖的部分
-- 0.11 起内置已有 grn / gra / grr / gri / gO / K / gd，
-- 千万不要再映射 gr，那会把整个 gr* 前缀吃掉
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
        -- 格式化统一交给 conform.nvim（见 lua/plugins/conform.lua）。
        -- 不要在这里再映射 <leader>f：buffer-local 映射会盖掉 conform 的全局键。
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    end,
})

-- 诊断跳转
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "上一个诊断" })

vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "下一个诊断" })

-- CSS / SCSS / LESS：mason 装的 css-lsp
-- 注意 cssls 只有在 snippetSupport 开启时才给补全，blink 在启动时已经注入，不用额外处理
vim.lsp.config("cssls", {
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
})
-- enable 交给 mason-lspconfig 的 automatic_enable，这里不要再写 vim.lsp.enable('cssls')

-- HTML：mason 装的 html-lsp，内置 css / javascript 内嵌语言支持
vim.lsp.config("html", {
    settings = {
        html = {
            suggest = { html5 = true },
        },
    },
})
-- enable 交给 mason-lspconfig 的 automatic_enable，这里不要再写 vim.lsp.enable('html')

-- ESLint：只做 lint / 规则修复，格式化仍归 conform + prettier
-- 依赖 mason 的 eslint-lsp 包（提供 vscode-eslint-language-server）
vim.lsp.config("eslint", {
    settings = {
        -- 从被打开文件所在目录去找 eslint 配置，monorepo 下更准确
        workingDirectory = { mode = "location" },
    },
})
vim.lsp.enable("eslint")

-- Rust：mason 安装的 rust-analyzer
-- 格式化交给 conform 的 rustfmt（见 lua/plugins/conform.lua）
vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            -- 全部 feature 参与分析，条件编译分支里的补全才完整
            cargo = { allFeatures = true },
            -- 保存时用 clippy 检查（工具链里已有 cargo-clippy）
            check = { command = "clippy" },
            inlayHints = { bindingModeHints = { enable = false } },
        },
    },
})
vim.lsp.enable("rust_analyzer")

-- TOML：mason 安装的 taplo
-- schema 校验/补全走 SchemaStore，关联规则可以在项目里用 .taplo.toml 覆盖
vim.lsp.config("taplo", {
    settings = {
        evenBetterToml = {
            schema = { enabled = true },
        },
    },
})
vim.lsp.enable("taplo")
