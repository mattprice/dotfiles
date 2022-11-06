# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
### ZSH SETTINGS ###
export EDITOR="code -w"
export CLICOLOR=1

# History File
HISTFILE=~/.zsh_history
HISTSIZE=1000 # Lines of history to keep in memory for current session
SAVEHIST=1000 # Number of history entries to save to disk
setopt append_history # Append to file so windows don't overwite each other
setopt hist_ignore_dups # Don't save lines if they duplicate the previous line
setopt hist_ignore_space # Don't save lines that are prefixed with a space
setopt hist_reduce_blanks # Remove unnecessary blanks from commands
setopt inc_append_history # Immediately append to the history file
setopt share_history # Share history across terminal windows

### ZSH PLUGINS ###
export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, at:main, as:theme
zplug 'zsh-users/zsh-autosuggestions', from:github
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

zplug load

### BAT SETTINGS ###
export BAT_THEME="TwoDark"

### KEY BINDINGS ###
case $TERM in (xterm*)
  bindkey '\e[H' beginning-of-line  # Home (xterm)
  bindkey '\e[F' end-of-line        # End (xterm)
esac
bindkey '\e[1~' beginning-of-line   # Home
bindkey '\e[4~' end-of-line         # End
bindkey '\e[3~' delete-char         # Delete
bindkey '\e[5~' insert-last-word    # Page Up
bindkey '\e[6~' end-of-history      # Page Down
bindkey '\e[2~' redisplay           # Insert
bindkey '^[[1;9C' forward-word      # Alt + Right
bindkey '^[[1;9D' backward-word     # Alt + Left

### ALIASES ###
## General Aliases
alias cx="chmod +x"
alias ip="curl -L http://icanhazip.com/"
alias rm_dsstore="find . -name '*.DS_Store' -type f -delete" # Recursively delete .DS_Store files
alias sha1="openssl dgst -sha1"
alias sha256="openssl dgst -sha256"
alias trim='mogrify -trim' # Trim whitespace around images
alias youtube='youtube-dl -f mp4/flv -o "%(title)s.%(ext)s" --recode-video mp4' # 37/38/22/18

if [[ $(uname -s) == 'Darwin' ]]; then
  alias lx="ls -lAhGp"
else
  alias lx="ls --color=always -lAhGp"
  alias open="xdg-open"
fi

# Git Aliases
# TODO: I should probably turn these into a git config…
alias gb="git branch"
alias gc="git checkout"
alias gd="git difftool"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp="git pull --rebase=merges --autostash"
alias gs="git status"

if command -v fork > /dev/null; then
  alias gt="fork ."
elif command -v github > /dev/null; then
  alias gt="github ."
elif command -v gitg > /dev/null; then
  alias gt="gitg --commit < /dev/null &> /dev/null &"
fi

# CD to the path of the frontmost Finder window
# http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
alias cdk="cd ~/Desktop/"
alias cdd="cd ~/Downloads/"
function cdf() {
  target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
  if [ "$target" != "" ]; then
    cd "$target" || exit;
  else
    cd "${HOME}/Desktop/" || exit;
  fi
}

# Merge two images into one, side-by-side
function merge() {
  montage -background transparent -geometry +4+0 "$@" montage.png
  trim montage.png
}

# Open, edit, or delete the Tmuxinator project for the current folder
# https://mattprice.me/2018/quickly-open-tmuxinator-project/
function mux() {
  project=$(pwd | xargs basename)

  if [ "$*" = "" ]; then
    tmuxinator start "$project"
  elif [ "$*" = "edit" ]; then
    tmuxinator edit "$project"
  elif [ "$*" = "delete" ]; then
    tmuxinator delete "$project"
  else
    # Let unknown commands fall-through
    tmuxinator "$*"
  fi
}

# Grab 10 evenly spaced images from the inputted video file
# https://stackoverflow.com/a/24563686
function screengrab() {
  `ffmpeg -i $* -vf fps=1/$(echo 'scale=6;' $(ffprobe -loglevel quiet -of 'compact=nokey=1:print_section=0' -show_format_entry duration $*) ' / 20' | bc) -vframes 20 -qscale:v 2 thumbnail-%d.png`
}

# Output a list of TODO comments found under the current directory
# https://mattprice.me/2014/printing-todo-comments-with-ack/
function todo() {
  ack -i \
      -o \
      --group \
      --color \
      --sort-files "\b(TODO|FIX(ME)?|OPTIMIZE|BUG)(\(\w+\))?: (.*)" \
      --ignore-dir={.git,.next,build,node_modules,vendor,Pods} \
      --ignore-file=is:.eslintcache \
      | perl -pe "s/:/\t/" \
      | perl -pe "s/\t(\w+)(\(\w+\))?:(.*)/\t\$1:\$3 \$2/"
}

# Search for a project and quickly open it
function wo() {
  project_dir="${HOME}/.config/projects"

  if [ "$*" = "add" ]; then
    ln -s "$(pwd)" "${project_dir}/$(pwd | xargs -0 basename)"
  elif [ "$*" = "delete" ]; then
    rm "${project_dir}/$(pwd | xargs -0 basename)"
  elif [ "$*" = "list" ]; then
    stat -f "%N -> %Y" "${project_dir}"/* | sed "s:${project_dir}/::"
  else
    project_matches=$(ls "${project_dir}/" | grep "$*")
    num_results=$(echo "${project_matches}" | grep -vc ^$)

    if (( num_results < 1 )); then
      echo "Could not find any projects matching that name."
      return 1
    fi

    if (( num_results > 1 )); then
      project=$(echo "${project_matches}" | fzy)
      cd -P "${project_dir}/${project}" || exit
      return 0
    fi

    cd -P "${project_dir}/${project_matches}" || exit
  fi
}

if [[ -f "${HOME}/.zshrc_local" ]]; then
  source "${HOME}/.zshrc_local"
fi

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
