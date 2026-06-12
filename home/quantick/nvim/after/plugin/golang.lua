-- gopls is installed by Nix, so Neovim only needs to enable the LSP client.
if vim.fn.executable 'gopls' == 1 then
  vim.lsp.config('gopls', {
    settings = {
      gopls = {
        analyses = {
          shadow = true,
          unusedparams = true,
        },
        gofumpt = true,
        staticcheck = true,
      },
    },
  })

  vim.lsp.enable 'gopls'
else
  vim.notify('gopls not found in PATH; rebuild the NixOS configuration', vim.log.levels.WARN)
end
