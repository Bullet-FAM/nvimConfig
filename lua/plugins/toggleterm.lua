-- 终端：toggleterm.nvim
-- 同一组键负责开/关；open_mapping 必须关掉，
-- 否则默认的 <C-\> 会和 t 模式里的 <C-\><C-n>（退出终端模式）冲突
return {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec' },
    keys = {
        { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = '终端: 开关' },
        { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = '终端: 浮动' },
        { '<leader>th', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', desc = '终端: 底部' },
        { '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', desc = '终端: 右侧' },
    },
    opts = {
        size = 15,
        direction = 'float',
        start_in_insert = true,
        shade_terminals = true,
        open_mapping = false,
        float_opts = { border = 'rounded' },
    },
}
