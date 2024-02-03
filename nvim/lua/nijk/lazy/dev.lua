local M = {}

M.colorizer = {
  -- Color hightlighter
  "norcalli/nvim-colorizer.lua",
  name = "colorizer",
  opts = {},
}

M.gitsigns = {
  "lewis6991/gitsigns.nvim",
  opts = {},
}

M.golang = {
  "fatih/vim-go",
  build = ':GoUpdateBinaries'
}

return {
  M.colorizer,
  M.gitsigns,
  M.golang
}
