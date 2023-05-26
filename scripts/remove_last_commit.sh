#!/bin/bash

# Help function
function display_help {
  echo "Usage: ./remove_last_commit.sh <repository_path>"
  echo "This script removes the last commit from each branch in a local Git repository."
  echo
  echo "Arguments:"
  echo "  <repository_path>  Path to the local Git repository"
}

# Remove the last commit from each branch
function remove_last_commit_from_branches {
  # Get the list of branches
  local branches=$(git branch | cut -c 3-)

  # Initialize branch count
  local branch_count=0

  # Iterate over each branch
  for branch in $branches; do
    echo "Processing branch: $branch"

    # Checkout the branch
    git checkout "$branch"

    # Check if there are commits to remove
    if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
      echo "No commits found in branch: $branch"
      continue
    fi

    # Move HEAD to the previous commit
    git reset --hard HEAD~1

    # Force push the changes to the remote repository
    git push --force

    # Increment the branch count
    ((branch_count++))
  done

  # Print the number of branches processed
  echo "Number of branches processed: $branch_count"
}

# Main script execution
function main {
  # Check if repository path is provided
  if [[ -z $1 || $1 == "-h" || $1 == "--help" ]]; then
    display_help
    exit 0
  fi

  # Extract repository path
  local repository_path=$1
  local repository_name=$(basename "$repository_path")

  # Check if repository directory exists
  if [[ ! -d $repository_path ]]; then
    echo "Repository directory not found: $repository_path"
    exit 1
  fi

  # Move to the repository directory
  cd "$repository_path" || { echo "Failed to change directory."; exit 1; }

  echo "Removing the last commit from each branch in repository: $repository_name"

  # Remove the last commit from each branch
  remove_last_commit_from_branches

  echo "Last commit removed from each branch successfully."
}

# Run the script
main "$@"