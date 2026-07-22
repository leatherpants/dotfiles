return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },

  {
    'mks-h/treesitter-autoinstall.nvim',
    opts = {},
  }
}
