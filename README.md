### Overview
Dotfiles for setting up a new Mac running 10.15+   

### Setup
* `git clone` this repo into your home directory
* From anywhere, run `~/.dotfiles/main`.

The install script will:

* install the Homebrew package manager
* install the Xcode CLI
* create symlinks in your `$HOME` directory for the below config files. The script will overwrite any existing files or symlinks in your `$HOME` directory.
  
  ** `.editorconfig`
  ** `.gitconfig`
  ** `.gitignore`
  ** `.zshrc`

* Open a new terminal tab or `source ~/.zshrc`

### Installed Formulae, Casks and Mac App Store Applications
* See Brewfile

### To Do

* Generate `.gitconfig` via script so my creds are not hard coded
* Allow multiple Brewfiles with a common ancestor
* Prompt to generate or lookup SSH config
