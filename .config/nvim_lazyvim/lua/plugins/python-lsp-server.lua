-- pylsp.plugins.pycodestyle.enabled
require('lspconfig').pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false }, --  Disables style checks
        -- pyflakes = { enabled = false },    --  Disables warnings
        -- mccabe = { enabled = false },      --  Disables cyclomatic complexity checks
      }
    }
  },
})
