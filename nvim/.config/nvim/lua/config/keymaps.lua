vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
