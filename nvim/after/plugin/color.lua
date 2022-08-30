vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transpatent_sidebar = true

vim.cmd('colorscheme tokyonight')

-- Minor color adjustments (irrespective of colorscheme)
vim.cmd('hi Normal guibg=#101010 guifg=#BDCBD3')
vim.cmd('hi CursorLine guibg=#101216')
vim.cmd('hi Pmenu guibg=#242424 guifg=#AFA89D')
vim.cmd('hi PmenuSel guibg=#302028 ctermbg=48 guifg=#F0A0C0 ctermfg=48 gui=NONE cterm=NONE')
vim.cmd('hi Visual guibg=#2A2E46 ctermbg=48 gui=NONE cterm=NONE')
vim.cmd('hi Search guibg=#302028 ctermbg=48 guifg=#F0A0C0 ctermfg=48')
-- guibg color is same as the background color of theme
vim.cmd('hi IncSearch guifg=#ffffff ctermfg=15 guibg=#16161e ctermbg=0')

-- Following color adjustments are specific to 'tender' coloscheme
-- but could be used with other colorschemes as well if it suits
-- the colorscheme...
vim.cmd('hi Identifier guifg=#B48EAD')
vim.cmd('hi Statement guifg=#5e81ac')
-- vim.cmd('hi Type guifg=#73cef4')
-- vim.cmd('hi Type guifg=#81d4fa')
vim.cmd('hi Type guifg=#90caf9')
-- vim.cmd('hi String guifg=#A3BE8C')
vim.cmd('hi String guifg=#81c784')
vim.cmd('hi Number guifg=#ffc24b')
vim.cmd('hi Operator guifg=#BF616A')
