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
    })
    require("telescope").load_extension("ui-select")
  end,
}
