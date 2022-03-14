require('telescope').setup{
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
	}
}

-- To get fzf loaded and working with telescope, call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd> lua require('telescope.builtin').find_files()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd> lua require('telescope.builtin').buffers()<CR>", opts)
