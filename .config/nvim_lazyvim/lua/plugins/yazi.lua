return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "_", "<CMD>Yazi cwd<CR>", desc = "Open the file manager in nvim's working directory" },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "~",
      },
    },
  },
}
