export TERM=xterm-color

# If you come from bash you might have to change your $PATH.
export PATH=/opt/homebrew/bin:$HOME/bin:$HOME/.yarn/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/dave/.oh-my-zsh

export FZF_DEFAULT_OPTS='--height=70% --preview="cat {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='rg --files'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="dave"

bindkey "[D" backward-word
bindkey "[C" forward-word

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
# plugins=(
  # git
# )
# Plugins
plugins=(brew git node macos z zsh-syntax-highlighting docker docker-compose docker-machine)

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias docu="docker-compose up -d"
alias docd="docker-compose down"
alias pro='docker run --name prototype -dit -p 3000:3000 --rm -v "$PWD":/app node:14-alpine'
alias start='docker exec -it prototype sh'


function newdesign {
  readonly client=${1:?"Client is required"}
  readonly project=${2:?"Project is required"}

  mkdir -p clients/$client/{contracts,projects/$project/{assets/{from-client,old,reference,stock,icons,fonts},design/{sketch,figma},review,prototype}}
}

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh




# Was only using oh-my-zsh theme to change prompt.
# Instead, move it into this file so we have one
# less file to manage during set-up.
GIT_PROMPT_PREFIX="[git:"
GIT_PROMPT_SUFFIX="]%f"
GIT_PROMPT_DIRTY="%F{red}+"
GIT_PROMPT_CLEAN="%F{green}"

# Check for existence of git repo and return styled
# prompt based on status.
function git_prompt_info_exists() {
  BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null) || return
  STATUS=$([[ -n $(command git status --porcelain 2> /dev/null | tail -n1) ]] && echo $GIT_PROMPT_DIRTY || echo $GIT_PROMPT_CLEAN)
  echo "$STATUS$GIT_PROMPT_PREFIX$BRANCH$GIT_PROMPT_SUFFIX"
}

PROMPT='$(printf %40s |tr " " "_")
%F{cyan}%~%f $(git_prompt_info_exists)
%(?:%B%F{green}:%B%F{red})➜%f%b '
