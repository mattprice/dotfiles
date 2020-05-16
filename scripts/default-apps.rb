#!/usr/bin/env ruby
# frozen_string_literal: true

# This script is based around a tool called Duti which is installed via Brew
# https://github.com/moretension/duti

if RUBY_PLATFORM !~ /darwin/
  puts '^ Skipped because platform is not macOS.'
  exit
end

DEFAULT_APPS = {
  "com.microsoft.VSCode": [
    "c",
    "cc",
    "css",
    "h",
    "js",
    "md",
    "php",
    "rb",
    "scss",
    "sh",
    "ts",
    "txt",
    "xml",
    "yaml",
    "yml"
  ]
}

DEFAULT_APPS.each do |app, exts|
  exts.each do |ext|
    system "duti -s #{app} #{ext} all"
  end
end
