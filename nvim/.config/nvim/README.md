# Neovim Configuration

## Structure

### init.lua 

top loader of files and global configuration

### lua/

* mappings.lua - global key maps
* options.lua  - global options
* plugins.lua  - packer config with a list of loaded plugins

### plugins/

* One file per plugin needing config for good modularization. 
  * The files in this directory are auto loaded.   
  * This could have all been done with packer and startup functions.

