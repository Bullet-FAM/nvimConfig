-- LSP 安装与启用：mason + mason-lspconfig
--
-- 分工：
--   mason.nvim            下载/管理 server 的二进制（装到 ~/.local/share/nvim/mason/bin，
--                         并在 setup 时把该目录前置进 PATH）
--   mason-lspconfig.nvim  把「已由 mason 安装」的 server 通过 vim.lsp.enable() 自动接管
--                         （Neovim 0.11+ 原生机制，不再需要 require('lspconfig')）
--
-- 注意：automatic_enable 只管 mason 装的 server。
--       你用 npm 全局装的 bashls 不受它管，那份仍由 config/lsp.lua 手动启用。
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    -- mason-lspconfig >= 2.0 的硬性依赖（提供 server 名称映射与额外配置）
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- 首次启动自动安装（已装则跳过）。不需要就删掉这一行。
    ensure_installed = { "lua_ls" },
    -- true：mason 装好的 server 一律 vim.lsp.enable()
    -- 也可以用 { "lua_ls" } 只启用白名单，或 { exclude = { ... } } 排除
    automatic_enable = true,
  },
}
