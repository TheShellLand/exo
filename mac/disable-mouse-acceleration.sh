#!/bin/bash

set -xe

#defaults write .GlobalPreferences com.apple.mouse.scaling -1
defaults write NSGlobalDomain com.apple.mouse.linear -bool "false"
#defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"
