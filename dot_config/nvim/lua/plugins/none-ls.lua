return {
  "nvimtools/none-ls.nvim",
  opts = function()
    local null_ls = require("null-ls")


    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      },
    })
  end
}
