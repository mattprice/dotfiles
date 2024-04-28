# Do not go where the path may lead, go instead where there is
# no path and leave a trail. — Ralph Waldo Emerson
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}" # Homebrew x86
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}" # Homebrew ARM
export PATH="$HOME/.local/share/mise/shims:$PATH" # Mise

if [[ -f "${HOME}/.zshenv_local" ]]; then
  source "${HOME}/.zshenv_local"
fi

# Ubuntu: Stop compinit from being run twice, since our zshrc already runs it
export skip_global_compinit=1

# macOS: Disable global profiles, which overwrite our PATH
setopt no_global_rcs
