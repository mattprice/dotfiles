# Disable accented characters popup (enables key repeat)
defaults write -g ApplePressAndHoldEnabled -bool false

# Set key repeat speed (System Prefs -> Keyboard -> Keyboard)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Enable Finder status bar (Finder -> View -> Show Status Bar)
defaults write com.apple.finder ShowStatusBar -bool true

# Enable subpixel antialiasing. Starting with Mojave, Apple disables it
# by default, but that makes fonts look awful on non-Retina displays.
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

echo "Please log out for settings to take effect."
