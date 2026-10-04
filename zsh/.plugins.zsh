# zsh plugins — install with Homebrew where noted

# brew install zsh-autosuggestions
autosuggestions=""
if [[ -n "${HOMEBREW_PREFIX:-}" && -f "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  autosuggestions="${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif command -v brew &>/dev/null; then
  autosuggestions="$(brew --prefix zsh-autosuggestions 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

[[ -n "$autosuggestions" && -f "$autosuggestions" ]] && source "$autosuggestions"

# brew install zsh-syntax-highlighting
syntax_highlighting=""
if [[ -n "${HOMEBREW_PREFIX:-}" && -f "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  syntax_highlighting="${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif command -v brew &>/dev/null; then
  syntax_highlighting="$(brew --prefix zsh-syntax-highlighting 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

[[ -n "$syntax_highlighting" && -f "$syntax_highlighting" ]] && source "$syntax_highlighting"

# installed by bin/bootstrap (git clone into ~/.local/share/zsh-claudecode-completion)
# Loaded after compinit, so register _claude directly instead of relying on fpath scanning.
claude_completion="$HOME/.local/share/zsh-claudecode-completion"
if [[ -f "$claude_completion/_claude" ]]; then
  fpath=("$claude_completion" $fpath)
  autoload -Uz _claude
  compdef _claude claude
fi

# brew install zsh-vi-mode
# Starship must init after vi-mode (see zvm_after_init) to avoid zle-keymap-select recursion.
ZVM_INIT_MODE=sourcing

zvm_after_init() {
  [[ -f "$HOME/.prompt.zsh" ]] && source "$HOME/.prompt.zsh"
}

vi_mode=""
if [[ -n "${HOMEBREW_PREFIX:-}" && -f "${HOMEBREW_PREFIX}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]]; then
  vi_mode="${HOMEBREW_PREFIX}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
elif command -v brew &>/dev/null; then
  vi_mode="$(brew --prefix zsh-vi-mode 2>/dev/null)/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi

[[ -n "$vi_mode" && -f "$vi_mode" ]] && source "$vi_mode"

# Starship when vi-mode is not installed (otherwise zvm_after_init loads it)
if [[ -z "$vi_mode" || ! -f "$vi_mode" ]]; then
  [[ -f "$HOME/.prompt.zsh" ]] && source "$HOME/.prompt.zsh"
fi
