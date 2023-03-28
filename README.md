### Overview

Dotfiles for setting up a new Mac running 10.15+

### Setup

`git clone` this repo into your home directory. From `~/.dotfiles` directory, run any of the following `make` targets. The default `make` runs all of them.

`make brew_install`

The install script will:

* install the Homebrew package manager
* install the Xcode CLI
* install Brew formulae, casks and Mac app store applications from `Brewfile`.

`make symlink`

The install script will:

* create symlinks to the below config files. The script will overwrite any existing files or symlinks in the listed directory. Note you will need to open a new terminal tab or `source ~/.zshrc`

  * `$HOME/.editorconfig         -> .dotfiles/.editorconfig`
  * `$HOME/.gitconfig            -> .dotfiles/.gitconfig`
  * `$HOME/.gitignore            -> .dotfiles/.gitignore`
  * `$HOME/.tool-versions        -> .dotfiles/.tool-versions`
  * `$HOME/.zshrc                -> .dotfiles/.zshrc`
  * `$HOME/.config/starship.toml -> .dotfiles/starship.toml`

### To Do

* Allow multiple Brewfiles with a common ancestor
* Prompt to generate or lookup SSH config
* Add /etc/timezone
