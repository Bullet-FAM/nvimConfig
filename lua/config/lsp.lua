-- shell 脚本补全：bash-language-server（bashls）
-- Neovim 0.11+ 自带 vim.lsp.config / vim.lsp.enable，不需要 nvim-lspconfig
-- 安装（不是插件，是独立二进制）：npm i -g bash-language-server
vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  -- lspconfig 默认只挂 bash/sh，这里把 zsh 也加上（bashls 对 zsh 支持有限）
  filetypes = { 'bash', 'sh', 'zsh' },
  root_markers = { '.git' },
  settings = {
    bashIde = {
      globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
      -- 装了 shellcheck 后 bashls 会自动调用做 lint，不在 PATH 里才需要写死：
      -- shellcheckPath = '/usr/bin/shellcheck',
    },
  },
})
vim.lsp.enable('bashls')

-- LSP 快捷键
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('shell-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[N]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  end,
})
