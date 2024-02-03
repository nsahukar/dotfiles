local nnoremap = require('nijk.keymap').nnoremap

local M = {}

M.on_attach = function(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- BEGIN_DEFAULT_ON_ATTACH
  nnoremap( '<C-]>', api.tree.change_root_to_node,          opts('CD'))
  nnoremap( '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
  nnoremap( '<C-k>', api.node.show_info_popup,              opts('Info'))
  nnoremap( '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
  nnoremap( '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
  nnoremap( '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
  nnoremap( '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
  nnoremap( '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
  nnoremap( '<CR>',  api.node.open.edit,                    opts('Open'))
  nnoremap( '<Tab>', api.node.open.preview,                 opts('Open Preview'))
  nnoremap( '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
  nnoremap( '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
  nnoremap( '.',     api.node.run.cmd,                      opts('Run Command'))
  nnoremap( '-',     api.tree.change_root_to_parent,        opts('Up'))
  nnoremap( 'a',     api.fs.create,                         opts('Create'))
  nnoremap( 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
  nnoremap( 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
  nnoremap( 'c',     api.fs.copy.node,                      opts('Copy'))
  nnoremap( 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
  nnoremap( '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
  nnoremap( ']c',    api.node.navigate.git.next,            opts('Next Git'))
  nnoremap( 'd',     api.fs.remove,                         opts('Delete'))
  nnoremap( 'D',     api.fs.trash,                          opts('Trash'))
  nnoremap( 'E',     api.tree.expand_all,                   opts('Expand All'))
  nnoremap( 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
  nnoremap( ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
  nnoremap( '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
  nnoremap( 'F',     api.live_filter.clear,                 opts('Clean Filter'))
  nnoremap( 'f',     api.live_filter.start,                 opts('Filter'))
  nnoremap( 'g?',    api.tree.toggle_help,                  opts('Help'))
  nnoremap( 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
  nnoremap( 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
  nnoremap( 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
  nnoremap( 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
  nnoremap( 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
  nnoremap( 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
  nnoremap( 'o',     api.node.open.edit,                    opts('Open'))
  nnoremap( 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
  nnoremap( 'p',     api.fs.paste,                          opts('Paste'))
  nnoremap( 'P',     api.node.navigate.parent,              opts('Parent Directory'))
  nnoremap( 'q',     api.tree.close,                        opts('Close'))
  nnoremap( 'r',     api.fs.rename,                         opts('Rename'))
  nnoremap( 'R',     api.tree.reload,                       opts('Refresh'))
  nnoremap( 's',     api.node.run.system,                   opts('Run System'))
  nnoremap( 'S',     api.tree.search_node,                  opts('Search'))
  nnoremap( 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
  nnoremap( 'W',     api.tree.collapse_all,                 opts('Collapse'))
  nnoremap( 'x',     api.fs.cut,                            opts('Cut'))
  nnoremap( 'y',     api.fs.copy.filename,                  opts('Copy Name'))
  nnoremap( 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
  nnoremap( '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  nnoremap( '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  -- END_DEFAULT_ON_ATTACH
end

M.opts = {
  on_attach = M.on_attach,
}

M.keybindings = function()
  nnoremap('<leader>e', ':NvimTreeToggle<CR>')
end

M.config = function(_, opts)
  require('nvim-tree').setup(opts)
  M.keybindings()
end

M.tree = {
  -- File explorer - nvim-tree
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  priority = 998,
  dependencies = { "devicons" },
  opts = M.opts,
  config = M.config,
}

return M.tree
