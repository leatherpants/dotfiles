return {
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        ["_"] = {},
      },
      format_on_save = {
        timeout_ms = 500,
      },
    },
    keys = {
      { "<leader>m", function() require("conform").format({ async = true }) end, desc = "Format with conform" },
    },
  },
}
