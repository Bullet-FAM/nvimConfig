-- buffer 标签栏：bufferline.nvim
-- 注意：setup 必须放在 opts/config 里，不能直接写在 spec 表里当元素，
-- 否则 lazy 解析 spec 时就会立刻 require("bufferline")（那时插件还没加载 -> 报错）。
return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
        options = {
            mode = 'buffers',
            offsets = {
                { filetype = 'NvimTree', text = 'Explorer', highlight = 'Directory', separator = true },
            },
            numbers = 'ordinal',
            diagnostics = 'nvim_lsp',
            show_buffer_close_icons = true,
            show_close_icon = false,
            separator_style = 'slant',
        },
    },
    keys = {
        { '<leader>bl', '<cmd>BufferLineCycleNext<cr>', desc = 'Buffer: 下一个' },
        { '<leader>bh', '<cmd>BufferLineCyclePrev<cr>', desc = 'Buffer: 上一个' },
        { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Buffer: 关闭当前' },
        { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Buffer: 关闭其它' },
    },
}
