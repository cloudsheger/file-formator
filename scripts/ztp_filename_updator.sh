#!/bin/bash

# Define color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

display_help() {
  echo -e "${RED}Usage: ./ztp_filename_updator <repository_url>${RESET}"
  echo "This script clones a Git repository and renames files with a '_MIGRATE' suffix in each branch and the root directory."
  echo
  echo -e "${RED}Arguments:${RESET}"
  echo "  <repository_url>  URL of the Git repository"
}

rename_files_in_directory() {
  echo -e "${GREEN}Renaming files in directory: $1${RESET}"

  local directory=$1

  # Move to the directory
  pushd "$directory" > /dev/null || return

  # Find all files in the directory and its subdirectories, excluding .git
  local files=()
  while IFS= read -r -d '' file; do
    files+=("$file")
  done < <(find . -type f -not -path './.git/*' -print0)

  # Iterate over each file
  for file in "${files[@]}"; do
    # Check if the file has an extension
    if [[ -f $file && "$file" == *.* ]]; then
      # Extract the base name and extension from the file name
      local base_name="${file%.*}"
      local extension="${file##*.}"

      # Create the new output file name
      local new_file_name="${base_name}_MIGRATE${extension}.txt"

      # Check if the file needs to be updated
      if [[ $file != $new_file_name ]]; then
        # Rename the file
        git mv "$file" "$new_file_name"

        # Increment the updated file count
        ((updated_file_count++))
      fi
    fi
  done

  # Move back to the previous directory
  popd > /dev/null || return
}

process_branches() {
  echo -e "${GREEN}Processing branches${RESET}"

  # Get the list of branches
  local branches=$(git branch -r | grep -v '\->')

  # Iterate over each branch
  for branch in $branches; do
    # Trim the branch name
    branch=$(echo "$branch" | sed 's/origin\///')

    # Checkout the branch
    git checkout "$branch"

    # Rename files in the root directory
    rename_files_in_directory "."

    # Commit the changes
    git commit -m "Convert file names for branch $branch"
  done
}

main() {
  # Check if repository URL is provided
  if [[ -z $1 || $1 == "-h" || $1 == "--help" ]]; then
    display_help
    exit 0
  fi

  # Extract repository name from URL
  local repository_url=$1
  local repository_name=$(basename "$repository_url" .git)

  # Check if repository already exists
  if [[ -d $repository_name ]]; then
    echo "Repository already exists: $repository_name"
    exit 1
  fi

  # Clone the Git repository
  git clone "$repository_url" || { echo "Failed to clone repository."; exit 1; }
  cd "$repository_name" || { echo "Failed to change directory."; exit 1; }

  # Variable to store the count of updated files
  local updated_file_count=0

  # Process each branch
  process_branches

  echo "Number of files updated: $updated_file_count"
}

# Run the script
main "$@"
