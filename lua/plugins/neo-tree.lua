return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- 你已经有了
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "文件树: 开关" },
        { "<leader>o", "<cmd>Neotree focus<cr>", desc = "文件树: 聚焦" },
    },
    opts = {
        filesystem = {
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        window = {
            width = 30,
        },
    },
}
