return {
    "mason-org/mason.nvim",
    opts = {
        install_root_dir = vim.fn.stdpath("data") .. "/mason",
        PATH = "prepend",
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
        registries = { "github:mason-org/mason-registry" },
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
}
