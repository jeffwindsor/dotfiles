--====================================
--bootstrap packer install
--====================================
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
  -- plugin manager
  use 'wbthomason/packer.nvim'
  
  -- caching for fast load times
  use 'lewis6991/impatient.nvim'

  -- lanuage syntax
  use 'nvim-treesitter/nvim-treesitter'
  
  -- fuzzy finders and more
  use{
    'nvim-telescope/telescope.nvim',
    branch   = '0.1.x', 
    requires = { 
      'nvim-lua/plenary.nvim',                        -- helpers
      'nvim-telescope/telescope-file-browser.nvim',   -- extend telescope with file browser capability
    }
  }

  -- auto save on return to normal mode
  use 'pocco81/auto-save.nvim'

  -- vertical lines on indents
  use 'lukas-reineke/indent-blankline.nvim'
  
  -- motion plugin
  use 'ggandor/leap.nvim'
  
  -- lazygit in a centered popup
  use 'kdheepak/lazygit.nvim'
  
  -- display key bindings (like emacs)
  use 'folke/which-key.nvim'

  -- buffer and status line 
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 
      'kyazdani42/nvim-web-devicons'
    }
  }
  
  -- color schemes
  use 'shaunsingh/nord.nvim'
  use 'marko-cerovac/material.nvim'
  use 'mhartington/oceanic-next'
  use 'rebelot/kanagawa.nvim'

  --===========================
  if packer_bootstrap then require('packer').sync() end
end)
 
