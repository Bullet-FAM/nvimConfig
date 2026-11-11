-- 补全引擎：blink.cmp
-- 你 clone 下来的是 main 分支（v2 架构），v2 还依赖单独的 saghen/blink.lib，
-- 直接跑会报 "blink.cmp v2 requires saghen/blink.lib"。
-- 这里固定 v1 稳定版：lazy 会把这份 clone checkout 到 v1.10.0，自包含、开箱即用。
return {
  'saghen/blink.cmp',
  version = 'v1.*',
  event = 'InsertEnter',
  opts = {
    -- 默认会从 GitHub Releases 下载预编译 fuzzy 二进制（不需要 cargo）
    -- 下载失败会静默回退 Lua 实现，功能一样、只是大项目里稍慢
    fuzzy = { implementation = 'prefer_rust' },

    keymap = {
      preset = 'default', -- 默认 C-n/C-p 选择、C-y 确认
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
    },

    sources = {
      default = { 'lsp', 'path', 'buffer', 'snippets' },
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300 },
      menu = { border = 'rounded' },
    },

    appearance = { nerd_font_variant = 'mono' },
  },
}
