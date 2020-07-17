if [[ $(uname -s) != 'Darwin' ]]; then
  echo "^ Skipped because platform is not macOS."
  exit 0
fi

# Disable accented characters popup (enables key repeat)
defaults write -g ApplePressAndHoldEnabled -bool false

# Set key repeat speed (System Prefs -> Keyboard -> Keyboard)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Enable Finder status bar (Finder -> View -> Show Status Bar)
defaults write com.apple.finder ShowStatusBar -bool true

# Disable font smoothing. Starting with Mojave, Apple change their font
# smoothing method, but it makes fonts look worse on non-Retina displays.
defaults -currentHost write -globalDomain AppleFontSmoothing -int 0

# Dim the Dock icon for apps that are hidden
defaults write com.apple.Dock showhidden -boolean yes

echo "Please log out for settings to take effect."
