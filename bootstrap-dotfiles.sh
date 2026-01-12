#!/bin/bash

# Clone the repository as a bare repo
git clone --bare git@github.com:mlavaert/dotfiles.git "$HOME/.cfg"

# Define a function to interact with the repo
function config {
   /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}

# Create a backup directory for conflicting files
mkdir -p .config-backup

# Try to checkout
if config checkout; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  # Move conflicting files to backup
  config checkout 2>&1 | grep -E "^[[:space:]]+" | awk '{print $1}' | while read -r file; do
      # Ensure backup directory exists (handles subdirectories like .config/nvim/)
      if [ -e "$file" ]; then
          mkdir -p ".config-backup/$(dirname "$file")"
          mv "$file" ".config-backup/$file"
          echo "Backed up $file"
      fi
  done
  
  # Try checkout again
  config checkout
fi;

# Configure the local repo to hide untracked files
config config --local status.showUntrackedFiles no

echo "Dotfiles installation complete."
