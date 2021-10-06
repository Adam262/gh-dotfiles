export DOTFILES_DIR="$HOME/.dotfiles"
test -e "$DOTFILES_DIR/.awsrc" && source "$DOTFILES_DIR/.awsrc"
test -e "$DOTFILES_DIR/.secretsrc" && source "$DOTFILES_DIR/.secretsrc"

test -e "$HOME/.autojump/etc/profile.d/autojump.sh"  && source "$HOME/.autojump/etc/profile.d/autojump.sh"

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

source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  command-not-found
  docker
  history
  git
  kubectl
  zsh-users/zsh-syntax-highlighting
  kiurchv/asdf.plugin.zsh
EOBUNDLES

# Tell Antigen that you're done.
antigen apply
autoload -U compinit && compinit -u

export GOPRIVATE=github.com/grnhse

export AWS_DEFAULT_PROFILE="dev.use1"
export AWS_SDK_LOAD_CONFIG=true

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

export EDITOR='subl -n -w'
export BUNDLER_EDITOR='subl -n -w'

export RACK_TIMEOUT=120
export UNICORN_TIMEOUT=1000

alias dj='BUNDLE_GEMFILE=~/Code/dajoku_cli/Gemfile bundle exec ruby -I ~/Code/dajoku_cli/lib ~/Code/dajoku_cli/bin/dajoku'
alias le="local/exec $1"

function ngrok-localhost {
  cd && ngrok http "http://localhost:$1" -subdomain=wuta
}

alias k='kubectl'
alias ka='kubectl -n argo'
alias kd='kubectl -n dajoku'
alias kc='kubectl config'
alias a='ASDF_ARGO_VERSION=2.12.3 argo -n argo'
alias an='ASDF_ARGO_VERSION=2.11.8 argo -n argo-next'
alias tf='terraform'
alias tfi='terraform init -backend-config=state.conf'
alias tf-dangerous-a='terraform apply plan.bin && rm -f plan.bin'
alias tfp='rm -f plan.bin && terraform plan -out=plan.bin | tee plan.txt'

alias prune-docker='docker system prune --volumes --all'

function prune-k8s () {
  local name_substring=$1
  local resource=${2:-"pod"}
  local namespace=${3:-"dajoku"}

  echo "namespace: $namespace"
  kubectl get $resource -n $namespace | grep $name_substring | grep -v Running | awk '{ print $1 }' | xargs -I % sh -c "kubectl -n $namespace delete $resource %"
}
function prune-branches () {
  local branch_name=$1

  git br | grep $branch_name | xargs -I % sh -c 'git br -D %'
}

alias be='bundle exec'
alias sozsh='source ~/.zshrc'
alias suzsh='subl ~/.zshrc'

function decode_k8s_secret() {
  local secret_name=$1
  local secret_key=${2:-"dajoku_auth_token"}
  local namespace=${3:-"dajoku"}

  kubectl -n $namespace get secrets $secret_name -o=jsonpath="{.data.$secret_key}" | base64 --decode;
}

# Argo Slack app lives at https://api.slack.com/apps/ADY90NC4Q/incoming-webhooks?success=1
# A common use of below is for base64 encoding a new Slack webhook into a K8s secret
function base64_encode_strip() {
  echo $1 | base64 -w0
}

# Sample usage
# kdebug --context prod.use1 --overrides "$(jq -n '.metadata.annotations["iam.amazonaws.com/role"] = "dajoku-api-greenhouse"')"
# kdebug --context dev.usw2 --overrides "$(jq -n '.metadata.annotations["iam.amazonaws.com/role"] = "dajoku-api-support"')"
# kdebug --context dev.usw2 --overrides "$(jq -n '.metadata.annotations["iam.amazonaws.com/role"] = "dajoku-api-support"')"

function kdebug () {
  kubectl run -n dajoku -it --rm --labels "consumer=adam,app=debug-tools" --generator run-pod/v1 --image gcr.io/gh-infra/debug-tools "kdebug-adam-$(openssl rand -hex 4)" "$@"
}

alias la='ls -a'
alias fzf-gco='git co `(git br | fzf)`'
alias pboard_reset="ps aux | grep pboard | grep -v grep | awk '{ print $2 }' | xargs kill"

function fzf-history() {
  history | fzf | awk '{print $1}'
}

function git-pr-create() {
  local branch branch_items card

  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  branch_items=($(echo $branch | tr "-" "\n"))
  card="${branch_items[1]}-${branch_items[2]}"

  gh pr create -t "$branch" -b "https://greenhouseio.atlassian.net/browse/$card" "$@"
}

eval "$(pipelinectl completion zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

if [[ -f "$HOME/.asdf/asdf.sh" ]] then
  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
fi
