local M = {}

M.opts = {
  settings = {
    -- any time the ui menu is closed then we will save the state
    -- back to the backing list, not to the fs.
    save_on_toggle = true,

    -- any time ui menu is closed then the state of the list will
    -- be synced back to the fs
    sync_on_ui_close = false,
  },
}

M.config = function (_, opts)
  local harpoon = require("harpoon")
  harpoon:setup(opts)

  local nnoremap = require('nijk.keymap').nnoremap
  nnoremap("<leader>a", function () harpoon:list():append() end)
  nnoremap("<M-Tab>", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  nnoremap("<M-1>", function () harpoon:list():select(1) end)
  nnoremap("<M-2>", function () harpoon:list():select(2) end)
  nnoremap("<M-3>", function () harpoon:list():select(3) end)
  nnoremap("<M-4>", function () harpoon:list():select(4) end)
  nnoremap("<C-S-P>", function () harpoon:list():prev() end)
  nnoremap("<C-S-N>", function () harpoon:list():next() end)

end

M.harpoon = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = M.opts,
  config = M.config,
}

return M.harpoon
