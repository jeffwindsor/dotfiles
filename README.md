![Dotfiles](dotfiles.png)

## The Configuration (Dot) Files

Configuration files in (\*)NIX systems usually start with a 'dot'.  Examples include directories and files like: ~/.config,  ~/.zshrc and ~/.gitconfig. These files can exist all over your drive but are usually found in your home directory `~/` and in the [XDG_CONFIG_HOME](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) which is by convention usually `~/.config`.

## Keeping a history of changes

This portion is optional, but recommended so that you easily tag, comment and find past historical changes.  This repository uses [git](https://git-scm.com/), as such it utilises a central location for all my current configurations. These central files are linked to the home directory structure using a local dotfile management strategy discussed below.

## Backing Up the files and sharing with multiple machines

This repository uses github to keep a copy of my configuration and associated git repository, in a centrally accessable location for sharing between machines.

## Local dotfile manangement strategy

Given the configuration files are centrally located for backup, sharing and keeping a change history, the last step is to project these files into the home directory for actual use on a machine.


Multiple methods have been devised to backup, share, and keep change history of these files.
This repository uses the program [gnu-stow](https://www.gnu.org/software/stow/) for linking files from the repo to the system, and [git](https://git-scm.com/) for history and of system storage. If that is not to your liking you can find alternative [tools](https://github.com/webpro/awesome-dotfiles#tools) and [articles](https://github.com/webpro/awesome-dotfiles#articles) to accomplish the same ends.

## Organization

The dotfiles are packaged into "configuration" folders, such as the below neovim configuration.

<pre>
~/.dotfiles/nvim/.config
├── nvim
│  ├── autosave.vim
│  ├── fzf.vim
│  ├── init.vim
│  ├── nerd-tree.vim
│  └── vim-sneak.vim
└── zsh
   └── nvim
</pre>

When a configuration folder is "added" to the current system, stow will link the highest file/folder appropriate  

<pre>
~/.config
├── nvim -> ../.dotfiles/nvim/.config/nvim
└── zsh
   └── nvim -> ../../.dotfiles/nvim/.config/zsh/nvim
</pre>

## Automation

There are three script files that help automate linking the dotfile configuration folder content to the users home directory:

* add {dotfile-configuration-folder} - links a single configuration folder to the system
* remove {dotfile-configuration-folder} - removes a single configuration folder from the system
* config {machine-configuration-folder} - removes and re-adds a list of configuration folders, automating a complete machine configuration
    
A machine configuration folder is a normal dot file folder plus

* a text file with a list of configurations to apply, located at **{machine-configuration-folder}/.local/stows/machine**
* folder name prefixed with "machine-" (convention not required)

Most of the time I use add or remove to test configurations and config to setup a new machine or refresh my configuration once new content is pulled. 

## Other Dotfile Resources

* [Getting Started With Dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
* [The best way to store your dotfiles: A bare Git repository ](https://www.atlassian.com/git/tutorials/dotfiles)
* [Managing Your Dotfiles](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/)
* [Awesome Dot files](https://github.com/webpro/awesome-dotfiles)
