# Run Fastfetch
if [[ -o interactive ]]; then
    fastfetch 
fi

# Set zinit home
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
#zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
#zinit snippet OMZP::kubectx
zinit snippet OMZP::oc
#zinit snippet OMZP::argocd
zinit snippet OMZP::podman
zinit snippet OMZP::command-not-found

autoload -U compinit && compinit

zinit cdreplay -q

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/alecci.toml)"

# Keybindings
bindkey -e
bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=auto $realpath'

# Aliases
alias vi='nvim'
alias ls='ls --color=auto'
#alias ll='ls --color=auto -lh'
alias ll="eza --color always -l --git -g --header --icons --group-directories-first"
alias fm="yazi"
alias pbcopy="wl-copy"
alias pbpaste="wl-paste"

#FZF_DEFAULT_OPTS "--preview 'bat --color=always {}'"
#FZF_DEFAULT_COMMAND "fd --type f"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval ". /home/dev/.ilab-complete.zsh"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/bin:$HOME/.local/bin:$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then . "$HOME/.config/fabric/fabric-bootstrap.inc"; fi
