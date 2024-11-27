return {
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "d",
              desc = "Dotfiles",
              action = ":lua Snacks.dashboard.pick('files', {cwd = $DOTFILES})",
            },
            {
              icon = "󱄅 ",
              key = "x",
              desc = "NixOs Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = $DOTFILES_NIX})",
            },
            {
              icon = " ",
              key = "c",
              desc = "Nvim Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
          

    ░░░░░░░    ░░░░░░░         ░░░░░░░░░░░░░░░░░░              ░░░░░░░░         
  ░░░░░░░░░░  ░░░░░░░░░░     ░░░░░░░░░░░░░░░░░░░░░░     ░░░░░░░░░░░░░░░░░░░░░░  
 ░░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░    ░░░░░░░░░░░░░░░░░░░░░░  
░░░░░░░    ░░░░    ░░░░░░░ ░░░░░░░    ░░░░    ░░░░░░░ ░░░░░░░    ░░░░    ░░░░░░░
░░░░░░░    ░░░░    ░░░░░░░ ░░░░░░░    ░░░░    ░░░░░░░ ░░░░░░░    ░░░░    ░░░░░░░
  ░░░░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░
    ░░░░░░░░░░░░░░░░░░       ░░░░░░░░░░░░░░░░░░░░░░     ░░░░░░░░░░░░░░░░░░░░░░  
      ░░░░░░░░░░░░░░            ░░░░░░░░░░░░░░░░        ░░░░░░░░░░░░░░░░░░░░░░  
        ░░░░░░░░░░              ░░░░  ░░░░  ░░░░        ░░░░░░░░░░░░░░░░░░░░░░  
          ░░░░░░                ░░░░  ░░░░  ░░░░         ░░░░░░░░░░░░░░░░░░░░   
]],
        },
      },
    },
  },
}

--           header = [[
--           ░░░░░░░░
--       ░░░░░░░░░░░░░░░░
--     ░░░░░░░░░░░░░░░░░░░░
--   ░░░░░░    ░░░░░░░░    ░░
--   ░░░░        ░░░░
--   ░░░░    ▒▒▒▒░░░░    ▒▒▒▒
-- ░░░░░░    ▒▒▒▒░░░░    ▒▒▒▒░░
-- ░░░░░░░░    ░░░░░░░░    ░░░░
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- ░░░░  ░░░░░░    ░░░░░░  ░░░░
-- ░░      ░░░░    ░░░░      ░░
-- ]],
