-- ==================================================
-- Neovim core config (single-file setup)
-- ==================================================

-- ---------- Clipboard ----------
vim.opt.clipboard = "unnamedplus"

-- ---------- Indentation ----------
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ---------- Visual mode indentation ----------
vim.keymap.set("v", "<Tab>", ">gv", { silent = true, desc = "Indent right" })
vim.keymap.set("v", "<S-Tab>", "<gv", { silent = true, desc = "Indent left" })

