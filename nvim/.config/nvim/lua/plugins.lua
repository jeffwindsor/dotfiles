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

  use 'wbthomason/packer.nvim'                         -- plugin manager
  use 'nvim-treesitter/nvim-treesitter'                -- syntax
  use 'lewis6991/impatient.nvim'                       -- caching for fast load times
  use 'pocco81/auto-save.nvim'                         -- auto save
  use 'lukas-reineke/indent-blankline.nvim'            -- vertical lines on indents
  -- use 'ggandor/leap.nvim'                              -- motion plugin
  -- use 'numToStr/Comment.nvim'                          -- comments
  -- use 'nvim-telescope/telescope-project.nvim'          -- projects
  use 'kdheepak/lazygit.nvim'                          -- lazygit in a centered popup
  use{'nvim-lualine/lualine.nvim',                     -- buffer and status line 
      requires = { 
        'kyazdani42/nvim-web-devicons'                 -- pretty pictures
      }
    }
  use{'nvim-telescope/telescope.nvim',                 -- fuzzy finder and mores 
      branch   = '0.1.x', 
      requires = { 
        'nvim-lua/plenary.nvim',                        -- helpers
        'nvim-telescope/telescope-file-browser.nvim',   -- add file browser capability
      }
    }
  --===========================
  use 'shaunsingh/nord.nvim'                            -- color scheme
  use 'marko-cerovac/material.nvim'                     -- color scheme
  use 'mhartington/oceanic-next'                        -- color scheme
  use 'rebelot/kanagawa.nvim'                           -- color scheme

  --===========================
  if packer_bootstrap then require('packer').sync() end
end)
 
