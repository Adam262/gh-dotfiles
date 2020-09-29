export DOTFILES_DIR="$HOME/.dotfiles"
test -e "$DOTFILES_DIR/.awsrc" && source "$DOTFILES_DIR/.awsrc"
test -e "$DOTFILES_DIR/.secretsrc" && source "$DOTFILES_DIR/.secretsrc"
test -e "$DOTFILES_DIR/.releases" && source "$DOTFILES_DIR/.releases"

test -e "$HOME/.autojump/etc/profile.d/autojump.sh"  && source "$HOME/.autojump/etc/profile.d/autojump.sh"
test -e "$HOME/.asdf/asdf.sh" && source "$HOME/.asdf/asdf.sh"
test -e "$HOME/.asdf/completions/asdf.bash" && source "$HOME/.asdf/completions/asdf.bash"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

DISABLE_UNTRACKED_FILES_DIRTY="true"
unsetopt correct_all
setopt autocd autopushd
setopt NO_CASE_GLOB

bindkey '^u' backward-kill-line

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
unsetopt share_history
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  # command-not-found
  # docker
  # history
  # git
  # kubectl
	# zsh-users/zsh-syntax-highlighting
EOBUNDLES

# Tell Antigen that you're done.
antigen apply
autoload -U compinit && compinit -u

export GOPATH=$HOME/go
export GOPRIVATE=github.com/grnhse
export PATH="$PATH:${GOPATH//://bin:}/bin"

export PATH="$PATH:$HOME/.dajoku-cli/bin"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:$HOME/Code/onboarding/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/Code/infrastructure/bin"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/opt/libpq/bin:$PATH"

export EDITOR='subl -w'
export BUNDLER_EDITOR='subl'

export RACK_TIMEOUT=120
export UNICORN_TIMEOUT=1000
 
alias dj='BUNDLE_GEMFILE=~/Code/dajoku_cli/Gemfile bundle exec ruby -I ~/Code/dajoku_cli/lib ~/Code/dajoku_cli/bin/dajoku'
alias le="local/exec $1"

dal() {
  dajoku auth login -s "$1" -r "$2"
}

dal-local() {
  dajoku auth login -s local --duo-otp skip
}

dajoku_auth() { 
  dal-local
  dal dev use1
  dal dev usw2
  dal prod use1
  dal prod usw2
}
 
# Pass in PR URL
function dj-integration-test {
  dajoku auth check -s dev-staging;
  bin/pipeline test $1;
}
function ngrok-localhost {
  cd && ngrok http "http://localhost:$1" -subdomain=wuta
}

alias k='kubectl'
alias ka='kubectl -n argo'
alias kd='kubectl -n dajoku'
alias kc='kubectl config'
alias a='argo -n argo'
alias tf='terraform'
alias tf-dangerous-a='terraform apply plan.bin && rm -f plan.bin'
alias tfi='terraform init -backend-config=state.conf -upgrade'
alias tfp='rm -f plan.bin && terraform plan -out=plan.bin | tee plan.txt'

alias docker-prune='docker system prune --volumes --all'

alias be='bundle exec'
alias sozsh='source ~/.zshrc'
alias suzsh='subl ~/.zshrc'

function decode_k8s_secret() {
  local secret_name=$1
  local secret_key=${2:-"dajoku_auth_token"}
  local namespace=${3:-"dajoku"}

  kubectl -n $namespace get secrets $secret_name -o=jsonpath="{.data.$secret_key}" | base64 --decode;
}

# do not add trailing new line to input + do not wrap output
encode_base64() {
  printf -- "$1" | base64 -w 0
}

alias la='ls -a'
alias gcof='git co `(git br | fzf)`'
alias pboard_reset="ps aux | grep pboard | grep -v grep | awk '{ print $2 }' | xargs kill"

eval "$(pipelinectl completion zsh)"
eval "$(starship init zsh)"

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
