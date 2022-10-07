# Neovim Configuration

## Structure

### init.lua 

top loader of files and global configuration

### lua/

* mappings.lua - global key maps
* options.lua  - global options
* packages.lua - packer config and plugin list

### plugins/

The files in this directory are auto loaded.   
I create one file per plugin, in which I stow the plugins config.  
Note: This could have all been done in the packages.lua startup function, 
but I think this method better modularizes the configs.

