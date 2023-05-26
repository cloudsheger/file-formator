#!/bin/bash

# Function to check if Git is installed
function check_git {
  if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git before running this script."
    exit 1
  fi
}

# Function to check if the main script exists
function check_main_script {
  if [[ ! -f "ztp_filename_updator.sh" ]]; then
    echo "Main script 'ztp_filename_updator.sh' not found. Make sure the script is present in the current directory."
    exit 1
  fi
}

# Function to execute the ztp_filename_updator script
function execute_ztp_filename_updator {
  local repository_url=$1
  chmod +x ztp_filename_updator.sh

  # Measure script execution time
  start_time=$(date +%s)
  ./ztp_filename_updator.sh "$repository_url"
  end_time=$(date +%s)

  # Calculate script execution time
  execution_time=$((end_time - start_time))
  echo "Script execution time: $execution_time seconds"
}

# Function to execute the remove_last_commit script
function execute_remove_last_commit {
  local repository_path=$1
  chmod +x remove_last_commit.sh

  # Measure script execution time
  start_time=$(date +%s)
  ./remove_last_commit.sh "$repository_path"
  end_time=$(date +%s)

  # Calculate script execution time
  execution_time=$((end_time - start_time))
  echo "Script execution time: $execution_time seconds"
}

# Check if Git is installed
check_git

# Check if the main script exists
check_main_script

# Prompt for script choice
echo "Choose the action:"
echo "1. Run ztp_filename_updator script"
echo "2. Run remove_last_commit script"
echo "3. Abort"

read -r choice

case $choice in
  1)
    # Prompt for repository URL
    echo "Enter the repository URL:"
    read -r repository_url

    # Execute the ztp_filename_updator script
    execute_ztp_filename_updator "$repository_url"
    ;;
  2)
    # Prompt for repository path
    echo "Enter the repository path:"
    read -r repository_path

    # Execute the remove_last_commit script
    execute_remove_last_commit "$repository_path"
    ;;
  3)
    # Abort
    echo "Aborted."
    exit 0
    ;;
  *)
    echo "Invalid choice. Aborted."
    exit 1
    ;;
esac
