# Login shell setup — runs after /etc/zprofile (path_helper), so Homebrew stays ahead of system paths.

for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x "$brew_bin" ]]; then
    eval "$("$brew_bin" shellenv zsh)"
    break
  fi
done
unset brew_bin

# OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
