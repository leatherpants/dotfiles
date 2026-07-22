return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- python
        "pyright",
        "ruff",
        -- web
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "vtsls",
        "eslint-lsp",
        "prettier",
        -- lua
        "lua-language-server",
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  }
}
