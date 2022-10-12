--
--bootstrapping packer on any install
--
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  
  -- caching for fast load times
  use 'lewis6991/impatient.nvim'
  
  -- auto save changes
  use 'pocco81/auto-save.nvim'

  --buffer and status line
  use{'nvim-lualine/lualine.nvim', 
      requires = { 'kyazdani42/nvim-web-devicons' }}
  
  --decorates indention levels
  use 'lukas-reineke/indent-blankline.nvim'
  
  -- fuzzy finder
  use{'nvim-telescope/telescope.nvim', 
      branch   = '0.1.x', 
      requires = { 'nvim-lua/plenary.nvim' }}

  -- use 'ggandor/leap.nvim'        --other motion plugin
  -- use 'phaazon/hop.nvim'         --motion plugin
  -- use 'numToStr/Comment.nvim'    --comment plugin 

  -- color schemes
  --use 'arcticicestudio/nord-vim'
  use 'shaunsingh/nord.nvim'
  --use 'cocopon/iceberg.vim'
  --use 'jacoborus/tender.vim'
  use 'marko-cerovac/material.nvim'
  use 'mhartington/oceanic-next'
  --use 'bluz71/vim-nightfly-guicolors'
  use 'rebelot/kanagawa.nvim'

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
 
