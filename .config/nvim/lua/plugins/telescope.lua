return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
      defaults = {
        file_ignore_patterns = {}, -- Remove any ignored files
        hidden = true, -- Show hidden files
        follow = true, -- Follow symbolic links
      },
    })
    require("telescope").load_extension("ui-select")
  end,
}
