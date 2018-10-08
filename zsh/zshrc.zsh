### ZSH SETTINGS ###
export EDITOR="code -w"

# History File
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt histignoredups # Don't save lines if they're a dupe of the previous line
setopt histreduceblanks # Remove unnecessary blanks from commands

### ZSH PLUGINS ###
export ZPLUG_HOME=/usr/local/opt/zplug
source "${ZPLUG_HOME}/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme
zplug 'zsh-users/zsh-autosuggestions', from:github
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# if ! zplug check; then
#   zplug install
# fi
zplug load

# Google Cloud SDK Autocompletion
source "${HOME}/Code/google-cloud-sdk/completion.zsh.inc"

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
alias ip="curl -L http://icanhazip.com/"
alias lx="ls -lAhGp"
alias rm_dsstore="find . -name '*.DS_Store' -type f -delete" # Recursively delete .DS_Store files
alias sha1="openssl dgst -sha1"
alias sha256="openssl dgst -sha256"
alias trim='mogrify -trim' # Trim whitespace around images
alias youtube='youtube-dl -f mp4/flv -o "%(title)s.%(ext)s" --recode-video mp4' # 37/38/22/18

# Development Aliases
alias cx="chmod +x"
alias srv="php -S localhost:8080" # Start a PHP server in the current directory
alias zp="${EDITOR} ~/.zshrc; source ~/.zshrc"

# Git Aliases
# TODO: I should probably turn these into a git config…
alias gb="git branch"
alias gc="git checkout"
alias gd="git difftool"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp="git pull --rebase=preserve --autostash"
alias gs="git status"
alias gt="gittower ."

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
# https://github.com/tmuxinator/tmuxinator
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
      --ignore-dir={.git,node_modules,vendor,Pods} \
      | perl -pe "s/:/\t/" \
      | perl -pe "s/\t(\w+)(\(\w+\))?:(.*)/\t\$1:\$3 \$2/"
}

# Search for a project and quickly open it
function wo() {
  # Get a list of all possible projects
  # We grep against the basename so "matt" doesn't catch "/Users/mattprice/"
  project_list=$(mdfind -0 'kMDItemUserTags == Projects' | xargs -0 basename | grep -i "$@")
  num_results=$(echo "${project_list}" | grep -vc ^$)

  if (( num_results < 1 )); then
    echo "Could not find any projects matching that name."
    return 1
  fi

  if (( num_results > 1 )); then
    project=$(mdfind 'kMDItemUserTags == Projects' | grep -e "/$(echo ${project_list} | choose )\$")
    cd "${project}" || exit
    return 0
  fi

  project=$(mdfind 'kMDItemUserTags == Projects' | grep -e "/${project_list}\$")
  cd "${project}" || exit
}
