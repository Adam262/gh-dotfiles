### Overview

Dotfiles for provisioning my coding environment on MacOS

### Setup

`git clone` this repo into your home directory. From `~/.dotfiles` directory, run any of the following `make` targets. The default `make` runs all of them.

#### make symlink

This target will create symlinks to the below config files:

* `$HOME/.editorconfig         -> .dotfiles/.editorconfig`
* `$HOME/.gitconfig            -> .dotfiles/.gitconfig`
* `$HOME/.gitignore            -> .dotfiles/.gitignore`
* `$HOME/.tool-versions        -> .dotfiles/.tool-versions`
* `$HOME/.zshrc                -> .dotfiles/.zshrc`
* `$HOME/.config/starship.toml -> .dotfiles/starship.toml`

Note that the target will overwrite any existing files or symlinks in the listed directory.

#### make brew_install

This target will install:

* the Homebrew package manager
* the Xcode CLI
* Brew formulae and Mac app store applications from `Brewfile`.

#### make asdf_install

This target will install:

* the `asdf` package manager
* all packages listed here in `.tool-versions` (along with their required plugins)

#### make krew_install

This target will install the `krew` plugins listed here in `krew-plugins.txt`
