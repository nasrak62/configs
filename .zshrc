# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
export PATH="/usr/share/code/bin:$PATH"
export PATH="/Users/saar.zaidfunden/Library/Python/3.8/bin:$PATH"
export PATH="/Users/saar.zaidfunden/node-space/node-space/target/debug/node-space:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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
plugins=( git zsh-syntax-highlighting zsh-autosuggestions)

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/saar.zaidfunden/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/saar.zaidfunden/Documents/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/saar.zaidfunden/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/saar.zaidfunden/Documents/google-cloud-sdk/completion.zsh.inc'; fi


export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

alias py="python3"
alias dc="docker-compose"
alias dcub="docker-compose up --build"
alias dcu="docker-compose up"
alias gclogin="gcloud auth login"
alias czshrc="nvim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias brew86="arch -x86_64 /usr/local/bin/brew"
alias pyenv86="arch -x86_64 pyenv"
alias gi-can_deploy="sh ~/scripts/can_deploy.sh"
alias calculate_offset="sh ~/scripts/calculate_offset_per_min.sh"
alias gi-black="py ~/scripts/current_black.py"
alias kube="py ~/scripts/kube.py"
alias gcprn="py ~/scripts/update_google_cred.py"
alias class-to-file="py ~/scripts/class_to_file_name.py"
alias sync_env="py ~/scripts/dotenv_sync.py"
alias remove-kubctl-config="rm ~/.kube/config.lock"
alias localsql="docker-ti apps-infra-mysql"
alias python="python3"
alias pip="pip3"
alias developer_tools="/Users/saar.zaidfunden/dev/pipl/apps/developer-tools/developer_tools/target/debug/developer_tools"
alias developer_tools2="/Users/saar.zaidfunden/dev/pipl/apps/developer-tools/scripts/developer_tools"
alias node-space="/Users/saar.zaidfunden/node-space/node-space/target/debug/node-space"


manage () {
  py manage.py $@
}

kill-webpack() {
  kill -9 $(ps -A | grep webpack | awk '{print $1}')
}

start-colima (){
  colima start --profile test -a aarch64 --mount-type=9p \
    --cpu 4 --memory 4 --disk 100
}

docker-ti () {
  docker exec -ti $1 bash
}


docker-search () {
  docker ps | grep $1 
}

gi-phf () {
  git push -f origin $1
}

gi-ph () {
  git push origin $1
}

gi-plm () {
  git pull origin master
}

gi-plma () {
  git pull origin main
}

gi-rst () {
  git reset HEAD~
}

gi-bn () {
  echo $(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
}

gi-phn () {
  local branch_name=$(gi-bn)
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  NC='\033[0m'
  echo "Is That Your Branch Name: ${RED}$branch_name${NC} ? (${GREEN}y${NC}/${RED}n${NC})"
  read answer
  
  if [[ "$answer" == "y" ]]; then
    echo "Pushing PR to $branch_name"
    gi-ph $branch_name
  elif [[ "$answer" == "n" ]]; then
    echo "Abort Pushing PR!"
  else
    echo "Bad Answer Try Again!"
  fi
}

gi-phnf () {
  local branch_name=$(gi-bn)
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  NC='\033[0m'
  echo "Is That Your Branch Name: ${RED}$branch_name${NC} ? (${GREEN}y${NC}/${RED}n${NC})"
  read answer
  
  if [[ "$answer" == "y" ]]; then
    echo "Force Pushing PR to $branch_name"
    gi-phf $branch_name
  elif [[ "$answer" == "n" ]]; then
    echo "Abort Pushing PR!"
  else
    echo "Bad Answer Try Again!"
  fi
}

gi-pc () {
  local branch_name=$(gi-bn)
  
  git pull origin $branch_name
}

gi-so () {
  local branch_name=$(gi-bn)
  
  git branch --set-upstream-to origin/$branch_name $branch_name
}

gi-som () {
  local branch_name=$(gi-bn)
  
  git branch --set-upstream-to origin/master $branch_name
}

gi-soma () {
  local branch_name=$(gi-bn)

  git branch --set-upstream-to origin/main $branch_name
}

pp-cd () {
  cd ~/dev/pipl/$1
}

pp-search () {
  ls ~/dev/pipl/ | grep $1 -i
}

pp-code () {
  code ~/dev/pipl/$1
}

cscript () {
  code ~/scripts
}

source ~/.piplrc

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH="`gem environment gemdir`/bin:$PATH"
fi


export PATH="/opt/homebrew/opt/swift/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:/usr/local/opt/icu4c/sbin:$PATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/icu4c/lib/pkgconfig"

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PYENV_ROOT="$HOME/.pyenv"

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="~/.local/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export C_INCLUDE_PATH=/opt/homebrew/Cellar/librdkafka/1.9.2/include
export LIBRARY_PATH=/opt/homebrew/Cellar/librdkafka/1.9.2/lib
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export BUILDKIT_PROGRESS=plain
export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
export CLOUDSDK_AUTH_REDIRECT_PORT=9090

