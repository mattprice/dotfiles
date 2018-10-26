# Do not go where the path may lead, go instead where there is
# no path and leave a trail. — Ralph Waldo Emerson
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"    # Homebrew
export PATH="${HOME}/.nodenv/bin:${PATH}"               # nodenv
export PATH="${HOME}/.rbenv/bin:${PATH}"                # rbenv

# These are here so scripts/apps have access to Node and Ruby.
# TODO: I don't think this works for apps anymore…
eval "$(nodenv init -)"
eval "$(rbenv init -)"

# Set up the Golang environment
if [[ $(uname -s) == 'Darwin' ]]; then
   export GOPATH="${HOME}/Code/Go"
   export GOBIN="${GOPATH}/bin"
   export PATH="${GOBIN}:${PATH}"
fi

# Google Cloud SDK
if [[ -d "${HOME}/Code/google-cloud-sdk/" ]]; then
    source "${HOME}/Code/google-cloud-sdk/path.zsh.inc"
fi

# Disable global profiles, which overwrite our PATH
setopt no_global_rcs
