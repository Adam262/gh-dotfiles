DOTFILES_DIR = "${HOME}/.dotfiles"
DEBUG ?=  false

.PHONY: hello symlink brew_install

hello:
	@echo "Hello World"

all: symlink brew_install

symlink:
	@echo "Symlinking dotfiles to HOME and/or HOME/.config directories."

	ln -sfv "${DOTFILES_DIR}/.editorconfig" ~
	ln -sfv "${DOTFILES_DIR}/.gitconfig" ~
	ln -sfv "${DOTFILES_DIR}/.gitignore" ~
	ln -sfv "${DOTFILES_DIR}/.zshrc" ~
	ln -sfv "${DOTFILES_DIR}/.tool-versions" ~
	ln -sfv "${DOTFILES_DIR}/starship.toml" ~/.config/starship.toml

	mkdir -p ~/.config/sso-token-cli
	ln -sfv "${DOTFILES_DIR}/.gh-sso-config" ~/.config/sso-token-cli/config

brew_install:
	@echo "Installing brew packages"
	
  	DEBUG="${DEBUG}" "${DOTFILES_DIR}/scripts/brew_install"