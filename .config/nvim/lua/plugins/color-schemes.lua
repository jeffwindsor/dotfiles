return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
      -- colorscheme = "ayu-mirage",
      -- colorscheme = "tender",
    },
  },

  -- FAVORITE THEMES
  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparency
      -- transparent = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },

      -- visibility
      on_highlights = function(hl, c)
        -- increase visibility of window separators (horz & vert)
        hl.WinSeparator = { bold = true, fg = c.cyan }
        -- increase visibility of line numbers
        hl.CursorLineNr = { bold = true, fg = c.orange }
        hl.LineNr = { fg = c.comment }
        hl.LineNrAbove = { fg = c.comment }
        hl.LineNrBelow = { fg = c.comment }
      end,
    },
  },
  { "jacoborus/tender.vim" },
  { "shaunsingh/nord.nvim" },
  { "Shatur/neovim-ayu" },
  { "marko-cerovac/material.nvim" },

  -- { "rebelot/kanagawa.nvim" },
  -- { "loctvl842/monokai-pro.nvim" },
  -- { "kepano/flexoki-neovim" },
  -- { "samharju/synthweave.nvim" },
  -- { "AlexvZyl/nordic.nvim" },
  -- { "Daiki48/sakurajima.nvim" },
  -- { "NTBBloodbath/doom-one.nvim" },
  -- { "bluz71/vim-nightfly-colors" },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "navarasu/onedark.nvim" },
  -- { "0xstepit/flow.nvim" },
  -- { "rmehri01/onenord.nvim" },
  -- { "sainnhe/everforest" },
  -- { "savq/melange-nvim" },
  -- { "maxmx03/fluoromachine.nvim" },
}
