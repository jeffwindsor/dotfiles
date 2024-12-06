return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "_", "<CMD>Yazi cwd<CR>", desc = "Open the file manager in nvim's working directory" },
    },
    opts = {
      floating_window_scaling_factor = 1.0,
      keymaps = {
        show_help = "~",
      },
    },
  },
}
