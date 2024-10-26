### Overview

Dotfiles for setting up a new Mac running 10.15+

### Setup

`git clone` this repo into your home directory. From `~/.dotfiles` directory, run any of the following `make` targets. The default `make` runs all of them.

`make brew_install`

This target will:

* install the Homebrew package manager
* install the Xcode CLI
* install Brew formulae, casks and Mac app store applications from `Brewfile`.

`make symlink`

This target will create symlinks to the below config files:

* `$HOME/.editorconfig         -> .dotfiles/.editorconfig`
* `$HOME/.gitconfig            -> .dotfiles/.gitconfig`
* `$HOME/.gitignore            -> .dotfiles/.gitignore`
* `$HOME/.tool-versions        -> .dotfiles/.tool-versions`
* `$HOME/.zshrc                -> .dotfiles/.zshrc`
* `$HOME/.config/starship.toml -> .dotfiles/starship.toml`

Note that the target will overwrite any existing files or symlinks in the listed directory.
