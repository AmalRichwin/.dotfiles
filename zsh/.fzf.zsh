# fzf — fuzzy finder (Ctrl+R history, Ctrl+T files, Alt+C cd)

if ! command -v fzf &>/dev/null; then
  return
fi

fzf_dir=""
if [[ -n "${HOMEBREW_PREFIX:-}" && -f "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" ]]; then
  fzf_dir="${HOMEBREW_PREFIX}/opt/fzf"
elif command -v brew &>/dev/null; then
  fzf_dir="$(brew --prefix fzf 2>/dev/null)"
fi

if [[ -n "$fzf_dir" && -f "$fzf_dir/shell/completion.zsh" ]]; then
  source "$fzf_dir/shell/completion.zsh"
  source "$fzf_dir/shell/key-bindings.zsh"
fi

# Use fd for file search when available
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
