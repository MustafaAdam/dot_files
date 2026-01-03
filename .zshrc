# ===============================
# Basics
# ===============================

export EDITOR=vim
export VISUAL=vim
export PAGER=less

setopt autocd
setopt correct
setopt interactivecomments

# ===============================
# History (critical)
# ===============================

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt sharehistory
setopt histignoredups
setopt histignorealldups
setopt histreduceblanks

# ===============================
# Completion (very important)
# ===============================

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# In ~/.zshrc
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

# Bind arrow keys to search history from current prefix
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
# ===============================
# Prompt (clean, informative)
# ===============================

autoload -Uz colors && colors
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f %# '

# ===============================
# Embedded / Toolchain Paths
# ===============================

# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$PATH:/usr/local/bin"

# Arduino CLI
# export PATH="$PATH:$HOME/bin"

# ARM toolchain (adjust if needed)
# export PATH="$PATH:/opt/gcc-arm-none-eabi/bin"

# ===============================
# Git (keep it simple)
# ===============================

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias vim='nvim'

# ===============================
# Embedded aliases
# ===============================

alias m='make'
alias mb='make build'
alias mf='make flash'
alias mu='make upload'
alias mm='make monitor'
alias mc='make clean'

alias ardb='arduino-cli board list'
alias ardc='arduino-cli compile'
alias ardu='arduino-cli upload'

# New project from template (newarduino project_name)
newarduino() {
    local name="${1:-arduino-project}"
    [[ -e "$name" ]] && { echo "❌ $name already exists"; return 1; }
    cp -r ~/arduino-template "$name"
}

# ===============================
# General aliases
# ===============================

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'

# ===============================
# Safety
# ===============================

setopt noclobber
setopt notify

# ===============================
# Oh My Zsh
# ===============================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
