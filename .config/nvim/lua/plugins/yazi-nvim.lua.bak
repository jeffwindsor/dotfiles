return {
  -- TRYING OUT
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = false,
    keys = {
      -- 👇 in this section, choose your own keymappings!
      -- {
      --   "-",
      --   function()
      --     require("yazi").yazi()
      --   end,
      --   desc = "Open the file manager",
      -- },
      {
        -- Open in the current working directory
        "-",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager in nvim's working directory",
      },
    },
    opts = {
      open_for_directories = true,
    },
  },
}
