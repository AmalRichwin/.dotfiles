# =====================================================================
# Modern CLI Replacements
# =====================================================================

# ── eza (modern ls) ──────────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias ls='eza --icons'
  alias la='eza -a --icons'
  alias ll='eza -la --icons --git'
  alias l='eza -l --icons'
  alias tree='eza --tree --icons'

  # reuse ls completions for eza (avoids defining a separate completion function)
  compdef eza=ls
fi

# ── fd (fast find) ───────────────────────────────────────────────────────────
if command -v fd &>/dev/null; then
  alias f='fd'
  alias ff='fd --type f'
  alias fd='fd --hidden --exclude .git'
fi

# ── ripgrep (fast grep) ──────────────────────────────────────────────────────
if command -v rg &>/dev/null; then
  alias rg='rg --color=auto --smart-case'
  alias rgi='rg --ignore-case'
  alias rgf='rg --files'
  alias rgl='rg --files-with-matches'
fi

# =====================================================================
# Core Utilities
# =====================================================================

alias cat='bat'
alias grep='rg --color=auto'
alias diff="diff --color=auto"
alias df="df -h"

# =====================================================================
# Navigation
# =====================================================================

alias -- -='cd -'

# =====================================================================
# Git project diagnostics (run before reading a new codebase)
# =====================================================================

if command -v git &>/dev/null; then

  # Top changed files — high churn = potential drag / blast radius
  git-churn() {
    local since="${1:-1 year ago}"
    git log --format=format: --name-only --since="$since" \
      | sort | uniq -c | sort -nr | head -20
  }

  # Contributors ranked by commits — watch for bus factor
  git-authors() {
    git shortlog -sn --no-merges "$@"
  }

  # Recent contributors — who is actually maintaining this now
  git-authors-recent() {
    git shortlog -sn --no-merges --since="${1:-6 months ago}"
  }

  # Bug hotspot files — commits mentioning fix/bug/broken
  git-bugspots() {
    git log -i -E --grep="fix|bug|broken" --name-only --format='' \
      | sort | uniq -c | sort -nr | head -20
  }

  # Commit velocity by month — accelerating, steady, or dying
  git-velocity() {
    git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
  }

  # Reverts / hotfixes — how often is the team firefighting
  git-firefight() {
    local since="${1:-1 year ago}"
    if command -v rg &>/dev/null; then
      git log --oneline --since="$since" | rg -i 'revert|hotfix|emergency|rollback'
    else
      git log --oneline --since="$since" | command grep -iE 'revert|hotfix|emergency|rollback'
    fi
  }

  # Run all diagnostics in one pass
  git-audit() {
    local since="${1:-1 year ago}"

    echo "== Top changed files (since $since) =="
    git-churn "$since"
    echo

    echo "== All contributors =="
    git-authors
    echo

    echo "== Contributors (last 6 months) =="
    git-authors-recent
    echo

    echo "== Bug hotspot files =="
    git-bugspots
    echo

    echo "== Commit velocity by month =="
    git-velocity
    echo

    echo "== Reverts / hotfixes (since $since) =="
    git-firefight "$since"
  }

  alias gchurn='git-churn'
  alias gauthors='git-authors'
  alias gauthorsr='git-authors-recent'
  alias gbugspots='git-bugspots'
  alias gvelocity='git-velocity'
  alias gfirefight='git-firefight'
  alias gaudit='git-audit'

fi
