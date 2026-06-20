# Environment — loaded for every zsh session (interactive and non-interactive)

[[ -f "$HOME/.exports" ]] && source "$HOME/.exports"

# ── Node (nvm) ───────────────────────────────────────────────────────────────
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# ── Local overrides (uv, cargo, etc.) ────────────────────────────────────────
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
