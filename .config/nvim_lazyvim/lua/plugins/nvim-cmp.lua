return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- turn off snippets
      opts.completion = { autocomplete = false }
    end,
  },
}
