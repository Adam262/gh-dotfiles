### Overview
Dotfiles for setting up a new Mac running 10.15+   

### Setup
* `git clone` this repo into your home directory
* From anywhere, run `~/.dotfiles/main`.

The install script will:

* install the Homebrew package manager
* install the Xcode CLI
* create symlinks in your `$HOME` directory for several config files. Make sure you do not already have these files in your `$HOME` directory - the script will raise an error when trying to write link.
  
  ** `.editorconfig`
  ** `.gitconfig`
  ** `.gitignore`
  ** `.zshrc`

* Open a new terminal tab or `source ~/.zshrc`

### Installed Formulae, Casks and Mac App Store Applications
* See Brewfile
