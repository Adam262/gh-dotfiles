export DOTFILES_DIR="$HOME/.dotfiles"
test -e "$DOTFILES_DIR/.awsrc" && source "$DOTFILES_DIR/.awsrc"
test -e "$DOTFILES_DIR/.secretsrc" && source "$DOTFILES_DIR/.secretsrc"

test -e "$HOME/.autojump/etc/profile.d/autojump.sh"  && source "$HOME/.autojump/etc/profile.d/autojump.sh"

# Uncomment for Greenhouse utils
# source gh_utils/.greenhouse

for util in $(ls -a "$DOTFILES_DIR/utils"); do
  source "$DOTFILES_DIR/utils/$util"
done

ulimit -n 10240

DISABLE_UNTRACKED_FILES_DIRTY="true"
unsetopt correct_all correct
setopt autocd autopushd
setopt NO_CASE_GLOB

bindkey '^u' backward-kill-line

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
unsetopt share_history
unsetopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

export ZSH_CACHE_DIR=$HOME/.oh-my-zsh/cache
mkdir -p $ZSH_CACHE_DIR/completions

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

source /usr/local/opt/antidote/share/antidote/antidote.zsh
source <(antidote init)

antidote bundle <<EOBUNDLES
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  
  # Bundle OMZ plugins using annotations
  ohmyzsh/ohmyzsh path:plugins/magic-enter

  # Bundle with a git URL
  https://github.com/zsh-users/zsh-history-substring-search
  
  ohmyzsh/ohmyzsh path:plugins/command-not-found
  ohmyzsh/ohmyzsh path:plugins/docker
  ohmyzsh/ohmyzsh path:plugins/history
  ohmyzsh/ohmyzsh path:plugins/git
  ohmyzsh/ohmyzsh path:plugins/kubectl

  # Custom ASDF plugin, see https://github.com/kiurchv/asdf.plugin.zsh
  ohmyzsh/ohmyzsh path:plugins/asdf
EOBUNDLES

export GOPRIVATE=github.com/grnhse

export PATH="$PATH:$HOME/bin"
export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.dajoku-cli/bin"
export PATH="$PATH:$HOME/Code/dajoku-api/bin"
export PATH="$PATH:$HOME/Code/dajoku_cli/bin"
export PATH="$PATH:$HOME/Code/infrastructure/bin"
export PATH="$PATH:$HOME/Code/onboarding/bin"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

export EDITOR='code -w'
export BUNDLER_EDITOR='code -w'
export KUBE_EDITOR='subl -w'

export RACK_TIMEOUT=120
export UNICORN_TIMEOUT=1000

alias be='bundle exec'
alias source_zsh='source ~/.zshrc'

alias la='ls -a'
alias pboard_reset="ps aux | grep pboard | grep -v grep | awk '{ print $2 }' | xargs kill"

alias dj='BUNDLE_GEMFILE=~/Code/dajoku_cli/Gemfile bundle exec ruby -I ~/Code/dajoku_cli/lib ~/Code/dajoku_cli/bin/dajoku'
alias le="local/exec $1"

function ngrok-localhost {
  cd && ngrok http "http://localhost:$1" -subdomain=wuta
}

eval "$(kubectl completion zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
. "$(pack completion --shell zsh)"
. <(stern --completion=zsh)

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

export GNUBINS="$(find /usr/local/opt -type d -follow -name gnubin -print)";

for bindir in ${GNUBINS[@]}; do
  export PATH=$bindir:$PATH;
done;

function source-zsh {
  source "$HOME/.zshrc"
}
