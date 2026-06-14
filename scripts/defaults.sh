#!/usr/bin/env bash

if [[ $(uname -s) != 'Darwin' ]]; then
  echo "^ Skipped because platform is not macOS."
  exit 0
fi

# Disable accented characters popup (enables key repeat)
defaults write -g ApplePressAndHoldEnabled -bool false

# Swap Cmd+Shift+S to "Save As…", "Duplicate" to Cmd+Option+Shift+S
defaults write -g NSUserKeyEquivalents -dict-add "Duplicate" '@~$s' "Save As…" '@$s'

# Disable the language switcher popup
defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled 0

# Disable selecting next/previous input source (System Settings -> Keyboard -> Keyboard Shortcuts -> Input Sources)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><false/></dict>"

# Change "Show Spotlight search" to Option+Space (System Settings -> Keyboard -> Keyboard Shortcuts -> Spotlight)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key>
    <dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>524288</integer>
      </array>
    </dict>
  </dict>"

# Disable "Convert Text to Traditional Chinese" (System Settings -> Keyboard -> Keyboard Shortcuts -> Services -> Text)
defaults write pbs NSServicesStatus -dict-add \
  "com.apple.ChineseTextConverterService - Convert Text from Simplified to Traditional Chinese - convertTextToTraditionalChinese" "
  <dict>
    <key>enabled_context_menu</key><false/>
    <key>enabled_services_menu</key><false/>
    <key>presentation_modes</key>
    <dict>
      <key>ContextMenu</key><false/>
      <key>ServicesMenu</key><false/>
    </dict>
  </dict>"

# Disable "Convert Text to Simplified Chinese" (System Settings -> Keyboard -> Keyboard Shortcuts -> Services -> Text)
defaults write pbs NSServicesStatus -dict-add \
  "com.apple.ChineseTextConverterService - Convert Text from Traditional to Simplified Chinese - convertTextToSimplifiedChinese" "
  <dict>
    <key>enabled_context_menu</key><false/>
    <key>enabled_services_menu</key><false/>
    <key>presentation_modes</key>
    <dict>
      <key>ContextMenu</key><false/>
      <key>ServicesMenu</key><false/>
    </dict>
  </dict>"

# Enable zoom using scroll gesture with Ctrl modifier (System Settings -> Accessibility -> Zoom)
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -int 262144
# Use "continuously with pointer" panning mode
defaults write com.apple.universalaccess closeViewPanningMode -int 0

# Set key repeat speed (System Settings -> Keyboard -> Keyboard)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Set trackpad tracking speed (System Settings -> Trackpad -> Point & Click)
defaults write NSGlobalDomain com.apple.trackpad.scaling 0.875

# Enable Finder status bar (View -> Show Status Bar)
defaults write com.apple.finder ShowStatusBar -bool true

# Set the default Finder search scope to the current folder (Finder -> Settings -> Advanced)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Keep folders on top when sorting by name (Finder -> Settings -> Advanced)
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# Enable "Snap to Grid" for Desktop icons (Finder -> View -> Show View Options)
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Dim the Dock icon for apps that are hidden
defaults write com.apple.Dock showhidden -boolean yes

# Don't automatically rearrange Spaces based on most recent use (System Settings -> Desktop & Dock)
defaults write com.apple.dock mru-spaces -bool false

# Don't show recent applications in Dock (System Settings -> Desktop & Dock)
defaults write com.apple.dock show-recents -bool false

# Disable "Quick Note" hot corner (System Settings -> Desktop & Dock -> Hot Corners)
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

# Hide WiFi and Bluetooth from the menu bar (System Settings -> Menu Bar)
defaults -currentHost write com.apple.controlcenter WiFi -int 24
defaults -currentHost write com.apple.controlcenter Bluetooth -int 24

# Hide the date from the menu bar clock (System Settings -> Menu Bar -> Clock Options)
defaults write com.apple.menuextra.clock ShowDate -int 2

# Enable Safari's status bar (View -> Show Status Bar)
defaults write com.apple.Safari ShowOverlayStatusBar -bool true

# Set Safari's home page (Preferences -> General)
defaults write com.apple.Safari HomePage -string "https://kagi.com/"

# Prevent Safari from opening files after downloading (Preferences -> General)
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable the Develop menu and the Web Inspector in Safari (Preferences -> Advanced)
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Don't write .DS_Store files to network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

echo "Please log out for settings to take effect."
