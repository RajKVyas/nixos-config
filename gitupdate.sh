#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

echo "Changing to Git repository: $SCRIPT_DIR"
cd "$SCRIPT_DIR" || exit 1

echo "---"
echo "Current Git status:"
git status -s # Short status
echo "---"

echo "Adding all changes to staging area..."
git add .
echo "---"

# Check if there are any actual changes staged for commit
if git diff-index --quiet --cached HEAD --; then
    echo "No changes staged for commit. Working tree is clean or changes not added."
    echo "Git update script finished."
    exit 0
fi

COMMIT_MESSAGE=""
# If a message is passed as the first argument to the script, use it
if [ -n "$1" ]; then
    COMMIT_MESSAGE="$1"
else
    # Otherwise, prompt for one
    read -p "Enter commit message: " COMMIT_MESSAGE
fi

if [ -z "$COMMIT_MESSAGE" ]; then
    echo "Commit message cannot be empty. Aborting."
    # Unstage changes if commit is aborted to avoid accidental commit later
    git reset
    exit 1
fi

echo "---"
echo "Committing with message: '$COMMIT_MESSAGE'"
git commit -m "$COMMIT_MESSAGE"
echo "Commit successful."
echo "---"

read -p "Push changes to remote? (y/N): " push_choice
case "$push_choice" in
  y|Y )
    echo "Pushing to remote..."
    # Assumes your remote is configured (e.g., 'origin')
    # and you want to push the current branch.
    # You might want to be more specific, e.g., git push origin main
    git push
    echo "Push successful."
    ;;
  * )
    echo "Push skipped."
    ;;
esac
echo "---"
echo "Git update script finished."
