export DOTFILES_DIR="$HOME/.dotfiles"
test -e "$HOME/.colorsrc" && source "$HOME/.colorsrc"
test -e "$DOTFILES_DIR/.bashrc" && source "$DOTFILES_DIR/.bashrc"
test -e "$DOTFILES_DIR/.secretsrc" && source "$DOTFILES_DIR/.secretsrc"

export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/opt/libpq/bin:$PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

export PATH=$PATH:"$HOME/source/solano/bin:"
export PATH="$PATH:$HOME/.dajoku-cli/bin"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:$HOME/Code/onboarding/bin"
export PATH="/usr/local/opt/openssl/bin:$PATH"

export GHO_DOCKER_ENV=true
export FIREFOX_TESTS_PATH='/Applications/Firefox.app/Contents/MacOS/firefox-bin'

export GHO_DOCKER_ENV=true
export GREENHOUSE_DIR="~/code/greenhouse"
export DAJOKU_CLI_DIR="~/code/dajoku_cli"
export DAJOKU_API_DIR="~/code/dajoku_api"

export EDITOR='subl -w'
export PGHOST=localhost
export BUNDLER_EDITOR='subl'

# aws credentials are stored at ~/.aws/credentials
# use via aws-vault exec support <my command> 
export AWS_PROFILE="support"
export AWS_REGION='us-east-1'
aws-vault-use() {
  unset AWS_VAULT
  eval $(aws-vault exec --assume-role-ttl=1h --session-ttl=12h "$@" -- env \
    | awk '/^AWS/ { print "export " $1 }')
}

alias aws-sup='aws-vault-use support'

export AWS_VAULT_BACKEND=file

export RACK_TIMEOUT=120
export UNICORN_TIMEOUT=1000
 
alias grnho_unicorn='grnho && WEB_CONCURRENCY=1 WEB_TIMEOUT=5000 rails s'
alias sidekiq_gho='grnho && bundle exec sidekiq -q default -q periodic -q data_migration -q solr_sidekiq_worker -q hard_delete -q new_hires -q emails'
alias webpack_server="grnho && yarn run webpack-dev-server"
alias docker_psql="grnho && script/docker-compose.sh run postgres psql -h postgres -U postgres -d development"

alias dj='BUNDLE_GEMFILE=~/Code/dajoku-cli/Gemfile bundle exec ruby -I ~/Code/dajoku-cli/lib ~/Code/dajoku-cli/bin/dajoku'
alias dj-api='cd ~/Code/dajoku-api'
alias dj-backend='cd ~/Code/dajoku-backend-status'
alias dj-cli='cd ~/Code/dajoku-cli'
alias dj-deploy-local='dj-login && dj deploy -s local -e local --no-follow'
alias dj-le="dj-api && local/exec $1"
alias dj-rails="dj-api && local/exec rails $1"
alias dj-status='dj-backend && dajoku component list -s local -e local --live'

function dj-sample {
  command=$1;
  shift;

  dj "$command" -s local -a dajoku-sample-app "$@"
}
function dj-login {
  if [ "$1" == "dev-staging" ];
  then
    dj-api && dajoku auth login -s dev-staging
  else
    dj-api && dajoku auth login -s local --duo-otp skip
  fi
}

# Pass in PR URL
function dj-integration-test {
  dajoku auth check -s dev-staging;
  bin/pipeline test $1;
}

alias grnh='cd ~/Code/greenhouse/'
alias grnho='cd ~/Code/onboarding/ && aws-sup'
alias testdb='RAILS_ENV=test bundle exec rake -t db:test:load'
alias local_migrate='rake db:local:migrate db:seed data:migrate && testdb'
alias delayed_jobs='grnho && rake jobs:work'
alias rake='bundle exec rake'
alias rspec='bundle exec rspec'
alias testlog='tail -f log/test.log'
alias clearlogs='rake log:clear' 

# Remember for this to work, you need to comment out `Constraints::DomainConstraint.new(AppSettings.general.app_domain)` in routes file
alias gho_ngrok='cd && ngrok http http://localhost-gho.greenhouse.io:3000 -subdomain=wuta'
alias dajoku_pipeline_start="grnho && dajoku pipeline start --user=$DAJOKU_USER --jenkins-user=$JENKINS_USER --jenkins-github-token=$JENKINS_GITHUB_TOKEN"
alias dajoku_update_cli='cd $HOME/.dajoku-cli/dajoku/src/dajoku_cli && git checkout master && git pull && curl -L https://s3.amazonaws.com/grnhse-vpc-assets/dajoku-cli/install.sh | bash && cd -'
function dajoku_login {
  if [ "$1" == "prod" ];
  then
    grnho && dajoku auth login -s prod
  else
    grnho && dajoku auth login
  fi 
} 

function dajoku_console {
  if [ "$1" == "prod" ];
  then
    grnho && dajoku run bundle exec rails c -s prod -e prod
  elif [ "$1" == "staging" ];
  then
    grnho && dajoku run bundle exec rails c -s prod -e staging
  else
    grnho && dajoku run bundle exec rails c -e $1
  fi 
}

alias ..='cd ..'
alias la='ls -a'

alias gcof='git co `(git br | fzf)`'

bundle_install() { bundle _1.17.3_ install; script/rails_5/bundle _1.17.3_ install; }

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='\n\[\033[32m\][\h \w]\[\033[00m\]$(parse_git_branch)\n\$ '

alias pboard_reset="ps aux | grep pboard | grep -v grep | awk '{ print $2 }' | xargs kill"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/adam/google-cloud-sdk/path.bash.inc' ]; then . '/Users/adam/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/adam/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/adam/google-cloud-sdk/completion.bash.inc'; fi
ssh-add -K
