-- mason的桥
return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        ensure_installed = { "lua_ls", "pylsp", "jsonls", "cssls", "html", "ts_ls", "emmet_language_server" },
        -- 只自动启用列表里的 server；写 true 会把所有 mason 装过的 server 都启用
        automatic_enable = { "lua_ls", "pylsp", "jsonls", "cssls", "html", "ts_ls", "emmet_language_server" },
    },
}
