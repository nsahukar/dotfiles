local M = {}

M.config = function ()
  local configs = require("nvim-treesitter.configs")
  configs.setup({
    -- A list of parser names, or "all"
    ensure_installed = {
      'lua',
      'go',
      'rust',
      'javascript',
      'typescript',
      'html',
      'css',
      'c', 'cpp',
      'dockerfile',
      'make',
      'yaml',
      'vim',
      'fish'
    },

    -- Install parsers synchronously
    -- (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    highlight = {
      enable = true,

      -- list of language(s) to disable
      disable = {}
    },

    indent = {
      enable = false
    },

    refactor = {
      highlight_definitions = {
        enable = true
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "<leader>r"
        }
      }
    },
  })
end

M.treesitter = {
  "nvim-treesitter/nvim-treesitter",
  name = "treesitter",
  build = ":TSUpdate",
  config = M.config,
}

M.treesitter_textobjects = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = "treesitter"
}

M.treesitter_refactor = {
  "nvim-treesitter/nvim-treesitter-refactor",
  dependencies = "treesitter"
}

return {
  M.treesitter,
  M.treesitter_textobjects,
  M.treesitter_refactor,
}
