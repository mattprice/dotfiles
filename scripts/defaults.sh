#!/usr/bin/env bash

if [[ $(uname -s) != 'Darwin' ]]; then
  echo "^ Skipped because platform is not macOS."
  exit 0
fi

# Disable accented characters popup (enables key repeat)
defaults write -g ApplePressAndHoldEnabled -bool false

# Set key repeat speed (System Prefs -> Keyboard -> Keyboard)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Set trackpad tracking speed (System Prefs -> Trackpad -> Point & Click)
defaults write NSGlobalDomain com.apple.trackpad.scaling 0.875

# Enable Finder status bar (View -> Show Status Bar)
defaults write com.apple.finder ShowStatusBar -bool true

# Dim the Dock icon for apps that are hidden
defaults write com.apple.Dock showhidden -boolean yes

# Don’t automatically rearrange Spaces based on most recent use (System Prefs -> Mission Control)
defaults write com.apple.dock mru-spaces -bool false

# Don’t show recent applications in Dock (System Prefs -> Dock)
defaults write com.apple.dock show-recents -bool false

# Disable "Quick Note" hot corner (System Prefs -> Mission Control)
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

# Enable Safari's status bar (View -> Show Status Bar)
defaults write com.apple.Safari ShowOverlayStatusBar -bool true

# Set Safari's home page (Preferences -> General)
defaults write com.apple.Safari HomePage -string "https://duckduckgo.com/"

# Prevent Safari from opening files after downloading (Preferences -> General)
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable the Develop menu and the Web Inspector in Safari (Preferences -> Advanced)
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Skip code folding animation to speed up the Xcode refactoring interface
# https://twitter.com/dmartincy/status/1173289543124029440?s=20
defaults write com.apple.dt.Xcode CodeFoldingAnimationSpeed -int 0

# Don't write .DS_Store files to network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

echo "Please log out for settings to take effect."
