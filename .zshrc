# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH

export GOROOT=/opt/homebrew/Cellar/go/1.17.8/libexec/

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Credentials

## for irc-downloader
export USERNAME=$(cat .secret/GITHUB_USERNAME)
export TOKEN=$(cat .secret/GITHUB_TOKEN)

export GITHUB_USERNAME=$(cat .secret/GITHUB_USERNAME)
export GITHUB_TOKEN=$(cat .secret/GITHUB_TOKEN)

export ARTIFACTORY_PASSWORD=$(cat .secret/ARTIFACTORY_PASSWORD)
export ARTIFACTORY_USERNAME=$(cat .secret/ARTIFACTORY_USERNAME)

export ICHABOD_CONTENTFUL_SPACEID=$(cat .secret/ICHABOD_CONTENTFUL_SPACEID)
export ICHABOD_CONTENTFUL_ACCESSTOKEN=$(cat .secret/ICHABOD_CONTENTFUL_ACCESSTOKEN)
export ICHABOD_CONTENTFUL_ENVIRONMENTID=dev

# Aliases

alias sbt="DOCKER_BUILDKIT=0 sbt"
alias issues="~/issues.sh"
alias tqw="tq \#work"
alias present="cscreen -x 1920 -y 1080"
alias nopresent="cscreen -x 3440 -y 1440"
alias fetch-k8s="rally-kubectl -e defaultaccess-rally-dev -t"

# todoist aliases
alias td='todoist --color list --filter '\''(overdue | today) & !#Work'\'
alias tw="todoist --color list --filter '(overdue | today) & #Work'"
alias ti="todoist --color list --filter '(overdue | today) & #IRC Bot'"
alias tc="todoist close"
alias t=todoist

# github aliases
alias gh-prs="gh search prs --review-requested=casmith --state=open --draft=false"

# todoist quick add
tq() { todoist q "$*" }

# additional git aliases
alias git-parent='git show-branch | sed "s/].*//"| grep "\*" | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed "s/^.*\[//"'

function rally_date {
  date -r $(($1 * 86400))
}

pullrequest() {
  desc="$*"
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  parent_branch=$(git-parent)
  jira_id=$(echo "$current_branch" | grep -Eo "[A-Z0-9]{1,10}-?[A-Z0-9]+-\d+")
  repobase=$(basename $(git config --get remote.origin.url))
  repo=${repobase%.*}

  gh pr create --body "[$jira_id](https://jira.rallyhealth.com/browse/$jira_id)

@AudaxHealthInc/best-hats" --title "[$jira_id] $desc"
}


# parse the current git branch for a JIRA ID
get_jira_id() {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  jira_id=$(echo "$current_branch" | grep -Eo "[A-Z0-9]{1,10}-?[A-Z0-9]+-\d+")
  echo $jira_id
}

commit() {
  jira_id=$(get_jira_id)
  git commit -m "[${jira_id}] $*"
}

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

run-punchlock-tests () { run-robot-tests "${1}" 'punchclock-test' }
run-user-settings-tests() { run-robot-tests "${1}" 'engage-user-settings-test' }
run-challengesv2-tests() { run-robot-tests "${1}" 'challengesv2-test' }
run-missions-tests() { run-robot-tests "${1}" 'missions-test' '6.1.0' }

alias sbt-proxy="sbt -Dhttp.proxyHost=127.0.0.1 -Dhttps.proxyHost=127.0.0.1 -Dhttp.proxyPort=8131 -Dhttps.proxyPort=8131"

alias prod-versions="curl https://ops-proxy.health-prod-1.rally-prod.com/deployment/versions 2>/dev/null | jq"
alias uat-versions="curl https://ops-proxy.health-uat-1.rally-prod.com/deployment/versions 2>/dev/null | jq"
tenant-versions() { curl https://ops-proxy.$1.rally-dev.com/deployment/versions 2>/dev/null | jq }


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh