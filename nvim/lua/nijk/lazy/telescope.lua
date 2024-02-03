local M = {}

M.opts = {
  defaults = {
  	-- layout_strategy = 'center',
  	layout_config = {
  		width = 0.48,
  		height = 0.36,
  		prompt_position = "top",
  		preview_cutoff = 10000,
  	},
  
  	selection_strategy = "reset",
  	sorting_strategy = "descending",
  	scroll_strategy = "cycle",
  	color_devicons = true,
  
  	file_ignore_patterns = {
  		"node_modules", "build/"
  	}
  },
  pickers = {
  	find_files = {
  		theme = "dropdown",
  		layout_config = {
  			preview_cutoff = 10000,
  		},
  	},
  	buffers = {
  		theme = "dropdown",
  		layout_config = {
  			preview_cutoff = 10000,
  		},
  	},
  },
  extensions = {
  	fzf = {
  		fuzzy = true, 					 					-- false will only do exact matching
  		override_generic_sorter = true, 	-- override the generic sorter
  		override_file_sorter = true, 	 		-- override the file sorter
  		case_mode = "smart_case", 		 		-- or "ignore_case" or "respect_case"
  										 									-- the default case_mode is "smart_case"
  	}
  },
}

M.keybindings = function()
  local builtin = require('telescope.builtin')
  local nnoremap = require('nijk.keymap').nnoremap
  nnoremap('<leader>ff', builtin.find_files)
  nnoremap('<leader>fb', builtin.buffers)
  nnoremap('<leader>h', builtin.help_tags)
end

M.find_files = function(cwd)
  if string.len(cwd) == 0 then
    vim.cmd('Telescope find_files')
  else
    vim.cmd('Telescope find_files cwd=' .. cwd)
  end
end

M.usercommands = function()
  -- Files: using telescope to find files in any given directory
  -- <args>
  --  - cwd: current working directory (optional)
  vim.api.nvim_create_user_command('Files', function(tbl)
    M.find_files(tbl.args)
  end, {
    nargs = '?',
    complete = 'dir'
  })
end

M.config = function(_, opts)
  local telescope = require('telescope')
  telescope.setup(opts)
  -- To get fzf loaded and working with telescope, call
  -- load_extension, somewhere after setup function.
  telescope.load_extension('fzf')

  -- Key bindings
  M.keybindings()
  -- User command(s)
  M.usercommands()
end

M.telescope = {
  -- Telesecope (Extendable fuzzy finder)
  "nvim-telescope/telescope.nvim",
  tag = '0.1.5',
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  opts = M.opts,
  config = M.config,
}

M.telescope_ext_fzf = {
  -- FZF extension - telescope
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make clean && make"
}

return { M.telescope, M.telescope_ext_fzf }
