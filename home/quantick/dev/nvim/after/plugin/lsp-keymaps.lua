vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-lsp-keymaps', { clear = true }),
  callback = function(event)
    local builtin = require 'telescope.builtin'
    local opts = function(desc)
      return { buffer = event.buf, desc = 'LSP: ' .. desc }
    end

    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts('[G]oto [D]efinition'))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('[G]oto [D]eclaration'))
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts('[G]oto [R]eferences'))
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts('[G]oto [I]mplementation'))
    vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, opts('[G]oto [T]ype Definition'))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('Hover Documentation'))
  end,
})
