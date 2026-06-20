
# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

# fzf (must load after compinit)
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# zoxide
eval "$(zoxide init zsh)"

# Shared aliases (bash/zsh)
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# zsh-only: reuse ls completions for eza
if command -v eza &>/dev/null; then
  compdef eza=ls
fi

# plugins (must load after compinit; vi-mode should be last)
[[ -f "$HOME/.plugins.zsh" ]] && source "$HOME/.plugins.zsh"

# Open the current command in your $EDITOR (e.g., neovim)
# Press Ctrl+X followed by Ctrl+E to trigger
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Expand history expressions (!!, !$, etc.) on space
bindkey ' ' magic-space

# Machine-local overrides (tool installs, secrets, etc.)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
