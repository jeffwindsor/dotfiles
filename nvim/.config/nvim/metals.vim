augroup lsp
  au!
  au FileType scala,sbt lua require("metals").initialize_or_attach({})
augroup end

