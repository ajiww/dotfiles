plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Enable colors
autoload -U colors && colors

# Prompt with decorations: username@host in green, cwd in blue, git branch in yellow
setopt prompt_subst
PROMPT='%F{green}%n@%m%f %F{blue}%~%f $(git_prompt_info)%# '

# Git branch info function
git_prompt_info() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    echo "%F{yellow}($branch)%f"
  fi
}

# Enable command auto-correction
setopt correct

# Enable history search with arrow keys
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Enable completion with colors
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Useful options
setopt autocd              # type directory name to cd into it
setopt extended_glob       # advanced globbing
setopt hist_ignore_dups    # don’t record duplicate commands
setopt share_history       # share history across sessions

# Aliases with color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Number of commands to save in memory and file
HISTSIZE=10000
SAVEHIST=10000
# Ensure the history file is used
HISTFILE=~/.zsh_history
# Append to history instead of overwriting
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

export EMACSDIR="$HOME/.config/emacs"

# Syntax highlighting, need manual installation:
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
# then put it at ~/.zshrc before ZSH_HIGHLIGHT_STYLES
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Costumize highlight unmatched quotes or parentheses
ZSH_HIGHLIGHT_STYLES[command]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=brightblue'
ZSH_HIGHLIGHT_STYLES[comment]='fg=brightblack,italic'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=white,bg=red,bold'
ZSH_HIGHLIGHT_STYLES[operator]='fg=brightmagenta'
ZSH_HIGHLIGHT_STYLES[integer]='fg=brightgreen'
ZSH_HIGHLIGHT_STYLES[float]='fg=brightgreen'
ZSH_HIGHLIGHT_STYLES[single-quote]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quote]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[back-quote]='fg=cyan'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
