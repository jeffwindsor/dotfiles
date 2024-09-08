return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.header = {
        "",
        "",
        "          ░░░░░░░░          ",
        "      ░░░░░░░░░░░░░░░░      ",
        "    ░░░░░░░░░░░░░░░░░░░░    ",
        "  ░░░░░░    ░░░░░░░░    ░░  ",
        "  ░░░░        ░░░░          ",
        "  ░░░░    ▒▒▒▒░░░░    ▒▒▒▒  ",
        "░░░░░░    ▒▒▒▒░░░░    ▒▒▒▒░░",
        "░░░░░░░░    ░░░░░░░░    ░░░░",
        "░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
        "░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
        "░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
        "░░░░  ░░░░░░    ░░░░░░  ░░░░",
        "░░      ░░░░    ░░░░      ░░",
        "",
        "",
        "neovim",
        "",
      }
      opts.config.center = {
        { action = "lua LazyVim.pick()()", desc = " Find File", icon = " ", key = "f" },
        { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
        { action = 'lua LazyVim.pick("oldfiles")()', desc = " Recent Files", icon = " ", key = "r" },
        { action = 'lua LazyVim.pick("live_grep")()', desc = " Find Text", icon = " ", key = "g" },
        { action = "lua LazyVim.pick.config_files()()", desc = " Config", icon = " ", key = "c" },
        {
          action = function()
            vim.api.nvim_input("<cmd>Telescope find_files find_command=yadm,list,-a<cr>")
          end,
          desc = " Dotfiles",
          icon = " ",
          key = "d",
        },
        { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
        { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
        {
          action = function()
            vim.api.nvim_input("<cmd>qa<cr>")
          end,
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }

      -- Clean up the presentation of the dashboard items
      for _, button in ipairs(opts.config.center) do
        -- expand width of descriptions
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        -- Show only key, no [ ]
        button.key_format = "  %s"
      end
    end,
  },
}

-- '"=^)',
-- "",
-- "MOTTAINI ❀ waste nothing",
-- "ZAZEN ☸ sitting meditation",
-- "OUBAITORY ❀ do not compare yourself to others",
-- "IKIGAI ☸ a reason for being, a sense of purpose",
-- "SHIKATA GA NAI ❀ let go of what you cannot change",
-- "SHU-HA-RI ☸ three stage to aquiring true knowledge",
-- "KAIZEN ❀ always seek to improve all areas of your life",
-- "WABI SABI ☸ acceptance and appreciation for imperfection",
-- "GAMAN ❀ enduring the seemingly unbearable, with patience and dignity",
-- "MONO NO AWARE ☸ awareness of the impermanent/transient nature of things",
