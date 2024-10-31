DOTFILES_DIR = "${HOME}/.dotfiles"
DEBUG ?=  false

.PHONY: hello symlink brew_install asdf_install krew_install

all: symlink brew_install asdf_install krew_install

hello:
	@echo "Hello World"

symlink:
	@echo "\nSymlinking dotfiles to HOME and/or HOME/.config directories."

	@ln -sfv "${DOTFILES_DIR}/.asdfrc" ~
	@ln -sfv "${DOTFILES_DIR}/.editorconfig" ~
	@ln -sfv "${DOTFILES_DIR}/.gitconfig" ~
	@ln -sfv "${DOTFILES_DIR}/.gitignore" ~
	@ln -sfv "${DOTFILES_DIR}/.tool-versions" ~
	@ln -sfv "${DOTFILES_DIR}/.zshrc" ~
	@mkdir -p ~/.zfunc
	@ln -sfv "${DOTFILES_DIR}/.zfunc/poetry" ~/.zfunc
	@ln -sfv "${DOTFILES_DIR}/starship.toml" ~/.config/starship.toml

brew_install:
	@echo "Installing brew packages"
	DEBUG=${DEBUG} "${DOTFILES_DIR}/scripts/brew_install"

asdf_install:
	@echo "Installing asdf plugins and packages"
	DEBUG=${DEBUG} "${DOTFILES_DIR}/scripts/asdf_install"

krew_install:
	@echo "Installing krew plugins"
	DEBUG=${DEBUG} kubectl krew install < "${DOTFILES_DIR}/krew-plugins.txt"
