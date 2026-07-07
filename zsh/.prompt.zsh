# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Starship prompt — init once (re-sourcing causes zle-keymap-select recursion with vi-mode)
if command -v starship &>/dev/null; then
  whence -w prompt_starship_precmd &>/dev/null || eval "$(starship init zsh)"
fi
