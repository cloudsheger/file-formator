# Git Repository Scripts

This repository contains useful scripts for managing Git repositories. It includes the following scripts:

- `bootstrap.sh`: A bootstrap script to automate the execution of other scripts.
- `ztp_filename_updator.sh`: A script for renaming files in a Git repository with a '_MIGRATE' suffix.
- `remove_last_commit.sh`: A script for removing the last commit from each branch in a local Git repository.

## How to Run the Bootstrap Script

The bootstrap script automates the execution of other scripts. To run the bootstrap script, follow these steps:

1. Clone this repository to your local machine:

   ```shell
   git clone <repository_url>
2. Navigate to the repository directory:
```shell
cd git-repo-scripts

3. Make sure you have Git installed on your machine. If not, please install Git.
4. Run the bootstrap script:
./bootstrap.sh
5. The script will present you with options to choose from.

Update Script: ztp_filename_updator.sh
The ztp_filename_updator.sh script is used to rename files in a Git repository with a '_MIGRATE' suffix. This script is helpful when you need to update multiple filenames in bulk. It renames files both in the root directory and its subdirectories.

To use the ztp_filename_updator.sh script, follow these steps:

1. Ensure you have cloned the repository and navigated to the repository directory.

2. Run the bootstrap script:
```
./bootstrap.sh
```
3. Choose option 1 for updating filenames.

4. Provide the URL of the Git repository when prompted.

5. The script will execute and rename the files as per the defined rules.


Remove Commit Script: remove_last_commit.sh
The remove_last_commit.sh script allows you to remove the last commit from each branch in a local Git repository. This can be useful when you need to undo the most recent commits across multiple branches.

To use the remove_last_commit.sh script, follow these steps:

1. Ensure you have cloned the repository and navigated to the repository directory.

2. Run the bootstrap script:
```shell 
./bootstrap.sh
3. Choose option 2 to remove the last commit.

4. Provide the path to the local Git repository when prompted.

5. The script will execute and remove the last commit from each branch in the repository.


Feel free to copy and use the above template in your README.md file.

