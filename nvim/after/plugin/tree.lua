require('nvim-tree').setup({
  sort_by = "modification_time",
  view = {
    mappings = {
      list = {
        { key = "<Tab>", action = "" }
      }
    }
  }
})
