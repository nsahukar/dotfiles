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

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- Edited file at ~/.local/share/nvim/plugged/nvim-treesitter-refactor/lua/nvim-treesitter-refactor/navigation.lua
-- to get this functionality
local tree_nav = require('nvim-treesitter-refactor.navigation')

-- Picker functions: 
-- List functions and methods
function _G.fnm(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Tree - functions and methods",
		finder = finders.new_table {
			-- The following function was added in the above mentioned file
      results = tree_nav.get_function_and_method_definitions(),
			entry_maker = function(entry)
				return {
					row = entry["lnum"],
					col = entry["col"],
					display = entry["text"] .. " " .. entry["type"],
					ordinal = entry["text"],
				}
			end
		},
    sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        print(vim.inspect(selection["row"]))
				
				vim.api.nvim_win_set_cursor(0, {selection["row"], selection["col"]})
        -- vim.api.nvim_put({ selection[1] }, "", false, true)
      end)
      return true
    end,
  }):find()
end

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd> lua require('telescope.builtin').find_files()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd> lua require('telescope.builtin').buffers()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd> lua fnm()<CR>", opts)
