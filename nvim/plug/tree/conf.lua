require'nvim-tree'.setup()

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
