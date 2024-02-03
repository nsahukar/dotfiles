local M = {}

M.opts = {}

M.surround = {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  opts = M.opts,
}

return M.surround
