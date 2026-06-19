# Environment — loaded for every zsh session (interactive and non-interactive)

# ── Editors (git, crontab, visudo, etc.) ────────────────────────────────────
export EDITOR='nvim'
export VISUAL='nvim'
export GIT_EDITOR='nvim'
export SUDO_EDITOR='nvim'

# ── GPG ──────────────────────────────────────────────────────────────────────
export GPG_TTY=$(tty)

# ── PATH ─────────────────────────────────────────────────────────────────────
# User bins first, then system paths, then optional extras
export PATH="$HOME/.local/bin:$HOME/.dotfiles/bin:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"

# ── Node (nvm) ───────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# ── Local overrides (uv, cargo, etc.) ────────────────────────────────────────
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
