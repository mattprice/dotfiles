# Do not go where the path may lead, go instead where there is
# no path and leave a trail. — Ralph Waldo Emerson
export PATH=/usr/local/bin:/usr/local/sbin:$PATH    # Homebrew

# These are here so apps such as Tower and Anvil have access to Node/Ruby
# TODO: I don't think this works anymore…
eval "$(nodenv init -)"
eval "$(rbenv init -)"

# Set up the Golang environment
if [[ $(uname -s) == 'Darwin' ]]; then
   export GOPATH="${HOME}/Code/Go"
   export GOBIN="${GOPATH}/bin"
   export PATH="${GOBIN}:${PATH}"
fi

# Google Cloud SDK
source "$HOME/Code/google-cloud-sdk/path.zsh.inc"

# Disable global profiles, which overwrite our PATH
setopt no_global_rcs
