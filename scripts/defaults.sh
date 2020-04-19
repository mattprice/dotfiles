# Disable accented characters popup (enables key repeat)
defaults write -g ApplePressAndHoldEnabled -bool false

# Set key repeat speed (System Prefs -> Keyboard -> Keyboard)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Enable Finder status bar (Finder -> View -> Show Status Bar)
defaults write com.apple.finder ShowStatusBar -bool true

echo "Please log out for settings to take effect."
