### Overview
Dotfiles for setting up a new Mac running 10.15+

### Setup
* `git clone` this repo into your home directory
* From anywhere, run `~/.dotfiles/main`.

The install script will:

* install the Homebrew package manager
* install the Xcode CLI
* create symlinks to the below config files. The script will overwrite any existing files or symlinks in the listed directory.

  ** `$HOME/.editorconfig         -> .dotfiles/.editorconfig`
  ** `$HOME/.gitconfig            -> .dotfiles/.gitconfig`
  ** `$HOME/.gitignore            -> .dotfiles/.gitignore`
  ** `$HOME/.zshrc                -> .dotfiles/.zshrc`
  ** `$HOME/.config/starship.toml -> .dotfiles/starship.toml`

* Open a new terminal tab or `source ~/.zshrc`

### Installed Formulae, Casks and Mac App Store Applications
* See Brewfile

### To Do

* Generate `.gitconfig` via script so my creds are not hard coded
* Allow multiple Brewfiles with a common ancestor
* Prompt to generate or lookup SSH config
* Add /etc/timezone
