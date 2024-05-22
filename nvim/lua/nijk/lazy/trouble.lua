local M = {}

M.config = function ()
  local trouble = require("trouble")
  trouble.setup()

  local nnoremap = require("nijk.keymap").nnoremap
  nnoremap("<M-0>", function() trouble.toggle("document_diagnostics") end)
  nnoremap("<M-q>", function() trouble.toggle("quickfix") end)
  nnoremap("<M-l>", function() trouble.toggle("loclist") end)
  -- THE FOLLOWING IS NOW WORKING AND ALWAYS THROWS AN ERROR!
  -- nnoremap("[d", function()
  --   trouble.toggle("document_diagnostics")
  --   trouble.next({skip_groups = true, jump = true})
  -- end)
  -- nnoremap("]d", function()
  --   trouble.toggle("document_diagnostics")
  --   trouble.previous({skip_groups = true, jump = true})
  -- end)
end

M.trouble = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = M.config,
}

return M.trouble
