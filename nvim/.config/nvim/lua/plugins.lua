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

  --===========================
  -- plugins
  --===========================
  use 'wbthomason/packer.nvim'                         -- plugin manager
  use 'nvim-treesitter/nvim-treesitter'                -- lanuage syntax
  use 'lewis6991/impatient.nvim'                       -- caching for fast load times
  use 'pocco81/auto-save.nvim'                         -- auto save on retuurn to normal mode
  use 'lukas-reineke/indent-blankline.nvim'            -- vertical lines on indents
  use 'ggandor/leap.nvim'                              -- motion plugin
  -- use 'numToStr/Comment.nvim'                          -- comments
  -- use 'nvim-telescope/telescope-project.nvim'          -- projects
  use 'kdheepak/lazygit.nvim'                          -- lazygit in a centered popup
  use{'nvim-lualine/lualine.nvim',                     -- buffer and status line 
      requires = { 
        'kyazdani42/nvim-web-devicons'                 -- pretty pictures
      }
    }
  use{'nvim-telescope/telescope.nvim',                 -- fuzzy finders and more 
      branch   = '0.1.x', 
      requires = { 
        'nvim-lua/plenary.nvim',                        -- helpers
        'nvim-telescope/telescope-file-browser.nvim',   -- extend telescope with file browser capability
      }
    }
  use 'folke/which-key.nvim'                            -- display key bindings (like emacs)
  
  --===========================
  -- color schemes
  --===========================
  use 'shaunsingh/nord.nvim'
  use 'marko-cerovac/material.nvim'
  use 'mhartington/oceanic-next'
  use 'rebelot/kanagawa.nvim'

  --===========================
  if packer_bootstrap then require('packer').sync() end
end)
 
