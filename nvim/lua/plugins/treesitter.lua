local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    print('update treesitter')
    vim.cmd('TSUpdate')
  end
end

vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

vim.pack.add({'https://github.com/nvim-treesitter/nvim-treesitter.git'})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'rust', 'wgsl' },
  auto_install = true,
  highlight = {
    enable = true
  }
})
