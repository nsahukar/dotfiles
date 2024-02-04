local M = {}

-- M.opts = {
--   style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--   transparent = true, -- Enable this to disable setting the background color
-- }
--
-- M.config = function(_, opts)
--   require("tokyonight").setup(opts)
--
--   -- Load the colorscheme
--   vim.cmd('colorscheme tokyonight')
--
--   -- Minor color adjustments (irrespective of colorscheme)
--   vim.cmd('hi Normal guibg=#101010 guifg=#BDCBD3')
--   vim.cmd('hi CursorLine guibg=#101216')
--   vim.cmd('hi Pmenu guibg=#242424 guifg=#AFA89D')
--   vim.cmd('hi PmenuSel guibg=#302028 ctermbg=48 guifg=#F0A0C0 ctermfg=48 gui=NONE cterm=NONE')
--   vim.cmd('hi Visual guibg=#2A2E46 ctermbg=48 gui=NONE cterm=NONE')
--   vim.cmd('hi Search guibg=#302028 ctermbg=48 guifg=#F0A0C0 ctermfg=48')
--   -- guibg color is same as the background color of theme
--   vim.cmd('hi IncSearch guifg=#ffffff ctermfg=15 guibg=#16161e ctermbg=0')
--
--   -- Following color adjustments are specific to 'tender' coloscheme
--   -- but could be used with other colorschemes as well if it suits
--   -- the colorscheme...
--   vim.cmd('hi Identifier guifg=#B48EAD')
--   vim.cmd('hi Statement guifg=#5e81ac')
--   -- vim.cmd('hi Type guifg=#73cef4')
--   -- vim.cmd('hi Type guifg=#81d4fa')
--   vim.cmd('hi Type guifg=#90caf9')
--   -- vim.cmd('hi String guifg=#A3BE8C')
--   vim.cmd('hi String guifg=#81c784')
--   vim.cmd('hi Number guifg=#ffc24b')
--   vim.cmd('hi Operator guifg=#BF616A')
-- end

-- M.tokyonight = {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 999,
--   opts = M.opts,
--   config = M.config,
-- }

M.opts = {
  dim_inactive_windows = true,
  extend_background_behind_borders = true,
  styles = {
    transparency = true,
  },
  highlight_groups = {
    -- Minor color adjustments
    Normal = { bg = "#0B0A0F", fg = "#4A4E69" },
    CursorLine = { bg = "#0F0F16" },
    Visual = { bg = "#1A1A26" },
    TelescopeNormal = { bg = "#0D0C12" },
    TelescopePromptNormal = { bg = "#0B0A0F" },
    String = { fg = "#5A5A9A" },
    Comment = { fg = "#3E3A42" },
  }
}

M.config = function (_, opts)
  require("rose-pine").setup(opts)
  -- Load the colorscheme
  vim.cmd('colorscheme rose-pine')
end

M.rose_pine = {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = M.opts,
  config = M.config,
}

M.devicons = {
  "nvim-tree/nvim-web-devicons",
  name = "devicons",
  lazy = false,
}

return {
  M.devicons,
  M.rose_pine,
}
