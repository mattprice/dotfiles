# Do not go where the path may lead, go instead where there is
# no path and leave a trail. — Ralph Waldo Emerson
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}" # Homebrew

# Node
export PATH="${HOME}/.nodenv/bin:${PATH}"
eval "$(nodenv init -)"

# Ruby
export PATH="${HOME}/.rbenv/bin:${PATH}"
eval "$(rbenv init -)"

# Go
export GOPATH="${HOME}/Code/Go"
export GOBIN="${GOPATH}/bin"
export PATH="${GOBIN}:${PATH}"

# Google Cloud SDK
if [[ -d "${HOME}/Code/google-cloud-sdk/" ]]; then
  source "${HOME}/Code/google-cloud-sdk/path.zsh.inc"
fi

# Disable global profiles, which overwrite our PATH
setopt no_global_rcs
