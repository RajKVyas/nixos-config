#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

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

# Get all configured remote names
REMOTE_NAMES=($(git remote | sort -u))

if [ ${#REMOTE_NAMES[@]} -eq 0 ]; then
    echo "No remotes configured. Skipping push."
else
    echo "Configured remotes: ${REMOTE_NAMES[*]}"
    read -p "Push changes to all configured remotes? (y/N): " push_all_choice
    if [[ "$push_all_choice" =~ ^[Yy]$ ]]; then
        CURRENT_BRANCH=$(git symbolic-ref --short HEAD) # Get current branch name
        TAGS_EXIST=$(git tag -l | wc -l)

        echo "Current branch is '$CURRENT_BRANCH'."
        echo "---"

        for remote_name in "${REMOTE_NAMES[@]}"; do
            echo "Pushing branch '$CURRENT_BRANCH' to remote '$remote_name'..."
            git push "$remote_name" "$CURRENT_BRANCH"
            echo "Push of branch '$CURRENT_BRANCH' to '$remote_name' successful."

            if [ "$TAGS_EXIST" -gt 0 ]; then
                echo "Pushing all tags to remote '$remote_name'..."
                git push --tags "$remote_name"
                echo "Push of tags to '$remote_name' successful."
            else
                echo "No tags to push for remote '$remote_name'."
            fi
            echo "---"
        done
    else
        echo "Push skipped."
    fi
fi

echo "Git update script finished."
