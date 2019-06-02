#!/bin/bash
set -euo pipefail

echo "hostname? "
read hostname
echo

# adapted from https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
# adapted from https://github.com/mathiasbynens/dotfiles/blob/master/.macos


# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'


# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "$hostname"
sudo scutil --set HostName "$hostname"
sudo scutil --set LocalHostName "$hostname"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set highlight color to a nicer color
defaults write NSGlobalDomain AppleHighlightColor -string "0.964700 0.576500 0.868900"

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# System Preferences > General > Click in the scrollbar to: Jump to the spot that's clicked
defaults write -globalDomain "AppleScrollerPagingBehavior" -bool true

# System Preferences > Dock > Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool true

# System Preferences > Dock > Automatically hide and show the Dock (duration)
defaults write com.apple.dock autohide-time-modifier -float 0.5

# System Preferences > Dock > Automatically hide and show the Dock (delay)
defaults write com.apple.dock autohide-delay -float 0

# System Preferences > Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 35
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5

# System Preferences > Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.preference.trackpad ForceClickSavedState -bool true

# System Preferences > Siri
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.Siri VoiceTriggerUserEnabled -bool false
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool false

# System Preferences > Spotlight
defaults write com.apple.Spotlight orderedItems -array \
  '{ enabled = 0; name = APPLICATIONS; }' \
  '{ enabled = 0; name = "MENU_SPOTLIGHT_SUGGESTIONS"; }' \
  '{ enabled = 0; name = "MENU_CONVERSION"; }' \
  '{ enabled = 0; name = "MENU_EXPRESSION"; }' \
  '{ enabled = 0; name = "MENU_DEFINITION"; }' \
  '{ enabled = 0; name = "SYSTEM_PREFS"; }' \
  '{ enabled = 0; name = DOCUMENTS; }' \
  '{ enabled = 0; name = DIRECTORIES; }' \
  '{ enabled = 0; name = PRESENTATIONS; }' \
  '{ enabled = 0; name = SPREADSHEETS; }' \
  '{ enabled = 0; name = PDF; }' \
  '{ enabled = 0; name = MESSAGES; }' \
  '{ enabled = 0; name = CONTACT; }' \
  '{ enabled = 0; name = "EVENT_TODO"; }' \
  '{ enabled = 0; name = IMAGES; }' \
  '{ enabled = 0; name = BOOKMARKS; }' \
  '{ enabled = 0; name = MUSIC; }' \
  '{ enabled = 0; name = MOVIES; }' \
  '{ enabled = 0; name = FONTS; }' \
  '{ enabled = 0; name = "MENU_OTHER"; }'

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Change shell to zsh
if [[ $SHELL != "/bin/zsh" ]]; then
  chsh -s /bin/zsh
fi
defaults write com.apple.Terminal Shell -string /bin/zsh

# Show Battery percent use
defaults write com.apple.menuextra.battery ShowPercent -string YES

# Touchbar (remove Siri, add Lock)
defaults write com.apple.ControlStrip FullCustomized -array \
  "com.apple.system.group.brightness" \
  "com.apple.system.mission-control" \
  "com.apple.system.launchpad" \
  "com.apple.system.group.keyboard-brightness" \
  "com.apple.system.group.media" \
  "com.apple.system.screen-lock" \
  "com.apple.system.group.volume"
defaults write com.apple.ControlStrip MiniCustomized -array \
  "com.apple.system.screen-lock" \
  "com.apple.system.brightness" \
  "com.apple.system.volume" \
  "com.apple.system.mute"

# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done
