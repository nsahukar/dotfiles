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
				goto_definition = "gnd",
				list_method_definitions = "gmd",
				list_type_definitions = "gtd",
			}
		}
	}
}
