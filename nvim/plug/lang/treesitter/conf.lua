-- local tree_nav = require('nvim-treesitter-refactor.navigation')

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	refactor = {
		highlight_definitions = { enable = true },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "<leader>r"
			}
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "god",
				list_definitions = "ld",
				list_function_and_method_definitions = "lfd",
				list_type_definitions = "ltd",
			}
		}
	}
}
