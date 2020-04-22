#!/usr/bin/env ruby
# frozen_string_literal: true

PLIST_BUDDY = 'sudo /usr/libexec/PlistBuddy'
VOLUME_CONFIG = '/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist'

# Read the existing blacklist so we don't add duplicates.
# This is a hacky way of parsing the output from PlistBuddy, but it works.
blacklist = `#{PLIST_BUDDY} -c 'Print Exclusions' #{VOLUME_CONFIG}`
blacklist = blacklist.split("\n")[1...-1].each(&:strip!)

CODE_DIR = File.expand_path('~/Code')
Dir.glob("#{CODE_DIR}/**/node_modules").each do |dir|
  # Skip nested node_modules folders. They just make the list messier.
  next unless dir.scan(/node_modules/).length == 1

  # Skip folders that are already on the blacklist.
  # This will happen automatically if you open and close the Spotlight
  # preference pane, but you probably don't do that much.
  next if blacklist.include? dir

  puts "Adding #{dir}..."
  system "#{PLIST_BUDDY} -c \"Add Exclusions: string #{dir}\" #{VOLUME_CONFIG}"
end

# Restart the Spotlight service for everything to take effect.
system 'sudo launchctl stop com.apple.metadata.mds'
system 'sudo launchctl start com.apple.metadata.mds'
