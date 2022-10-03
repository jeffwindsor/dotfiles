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
  -- self reference to plugin manager
  use 'wbthomason/packer.nvim'
  
  -- tools
  use 'pocco81/auto-save.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch   = 'v2.x',
    requires = { 
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
   	}
  }
  use {
    'nvim-telescope/telescope.nvim', 
	  branch   = '0.1.x',
	  requires = { 'nvim-lua/plenary.nvim' }
	}
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- color schemes
  use 'arcticicestudio/nord-vim'
  use 'cocopon/iceberg.vim'
  use 'jacoborus/tender.vim'
  use 'rakr/vim-one'
  use 'sainnhe/everforest'
  use 'joshdick/onedark.vim'

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

