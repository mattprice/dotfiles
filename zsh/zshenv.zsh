# Do not go where the path may lead, go instead where there is
# no path and leave a trail. — Ralph Waldo Emerson
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}" # Homebrew
export PATH="/opt/homebrew/bin:${PATH}" # Homebrew
export PATH="${HOME}/.rd/bin:${PATH}" # Rancher Desktop

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

# Disable global profiles, which overwrite our PATH
setopt no_global_rcs
