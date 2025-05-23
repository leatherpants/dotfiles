return {

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
      },
      vim.keymap.set('n', 'gqf', vim.lsp.buf.format, { desc = "Format current buffer" })
    },
  },

}
