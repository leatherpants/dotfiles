return {

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = function ()
      vim.lsp.enable('djlsp')
    end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",

        "hyprls",

        "html",
        "cssls",

        "ts_ls",
        "jsonls",

        "pyright",
      },
      vim.keymap.set('n', 'gqf', vim.lsp.buf.format, { desc = "Format current buffer" })
    },
  },

}
