-- disable formatting for typescript and javascript
-- using prettier instead
-- vim.lsp.config('vtsls', {
--   settings = {
--     typescript = { format = { enabled = false } },
--     javascript = { format = { enabled = false } },
--   },
--   on_init = function(client)
--     if client.server_capabilities then
--       client.server_capabilities.documentFormattingProvider = false
--       client.server_capabilities.documentRangeFormattingProvider = false
--     end
--   end,
-- })

-- relative keymaps
vim.keymap.set('n', "grd", vim.diagnostic.open_float, { desc = 'vim.diagnostic.open_float()' })
vim.keymap.set("n", "grm", vim.lsp.buf.format, { desc = 'vim.lsp.buf.format()' })
