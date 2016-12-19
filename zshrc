# Path to your oh-my-zsh installation.
export ZSH=/Users/civisemployee/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history-substring-search bundler osx rake ruby)

# User configuration
# Moved to .zshenv

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vgi='vagrant init'
alias vgu="vagrant up; vagrant ssh -c 'docker-compose up -d'"
alias vgh="vagrant halt"
alias vgsuv="vagrant suspend"
alias vgrei="vagrant resume"
alias vgr="vagrant reload"
alias vgd="vagrant destroy"
alias vgst="vagrant status"
alias vgs="vagrant ssh"
alias rb="vagrant ssh -c 'bundle'"
alias rs="vagrant ssh -c 'DISABLE_SPRING=1 bundle exec rails server -b 0.0.0.0'"
alias rw="vagrant ssh -c 'bundle exec rake jobs:work'"
alias rc="vagrant ssh -c 'bundle exec rails console'"
alias rd="vagrant ssh -c 'docker-compose up -d'"
docker_compose_exec() {
    vagrant ssh -c 'docker exec -it $(docker-compose ps | grep '"'$1'"' | head -n 1 | awk '\''{print $1}'\'') '"$*[2,-1]"
}
alias vgmd="docker_compose_exec mysql mysqldump console_development > ~/dbbackups/console_dev_`gdate +%s%N`.sql"
alias rdb="vgmd && vagrant ssh -c 'bundle; bundle exec rake db:migrate'"
alias gcod="git checkout -- db/schema.rb"
unalias rspec
rspec () { vagrant ssh -c "bundle exec rspec --format documentation --order default --fail-fast $*" }
alias hgrep='history | egrep -i'
alias beep="echo -e '\a'"
alias ll="ls -lah"
alias jd='[ 0 = 0 ] && echo -e '\''good\a'\'' || echo -e '\''bad\a'\'''
alias bcf='bundle; bundle clean --force'

# Add syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias Emacs
alias emacs="/usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.13/Emacs.app/Contents/MacOS/Emacs"

eval "$(rbenv init -)"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# History substring search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Commenting these out because they increase load times
# export NVM_DIR="/Users/civisemployee/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

PROMPT='${ret_status} %D %* %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
