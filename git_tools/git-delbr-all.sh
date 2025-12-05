#!/usr/bin/env bash

##### XXXXXXX REVIEWWWW CLAUDEEE
#  set -e
#
#  # Check if branch name provided
#  if [[ -z "$1" ]]; then
#      echo "Usage: git-delbr-all <branch-name>" >&2
#      exit 1
#  fi
#
#  BRANCH="$1"
#
#  # Check if local branch exists
#  if ! git rev-parse --verify "$BRANCH" >/dev/null 2>&1; then
#      echo "Error: Local branch '$BRANCH' does not exist" >&2
#      exit 1
#  fi
#
#  # Check if currently on the branch to be deleted
#  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
#  if [[ "$CURRENT_BRANCH" == "$BRANCH" ]]; then
#      echo "Error: Cannot delete currently checked out branch '$BRANCH'" >&2
#      echo "Switch to another branch first: git checkout main" >&2
#      exit 1
#  fi
#
#  # Check if remote branch exists
#  REMOTE_EXISTS=false
#  if git ls-remote --exit-code --heads origin "$BRANCH" >/dev/null 2>&1; then
#      REMOTE_EXISTS=true
#  fi
#
#  # Show warning
#  echo "WARNING: This will delete:"
#  echo "  - Local branch: $BRANCH"
#  if [[ "$REMOTE_EXISTS" == "true" ]]; then
#      echo "  - Remote branch: origin/$BRANCH"
#  else
#      echo "  - Remote branch: (does not exist)"
#  fi
#  echo ""
#  read -p "Are you sure? (y/N): " -n 1 -r
#  echo ""
#
#  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
#      echo "Aborted." >&2
#      exit 1
#  fi
#
#  # Delete local branch
#  echo "Deleting local branch '$BRANCH'..."
#  git branch -D "$BRANCH"
#
#  # Delete remote branch if it exists
#  if [[ "$REMOTE_EXISTS" == "true" ]]; then
#      echo "Deleting remote branch 'origin/$BRANCH'..."
#      git push origin --delete "$BRANCH"
#  else
#      echo "Remote branch does not exist, skipping..."
#  fi
#
#  echo "Done!"
