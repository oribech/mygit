#!/bin/bash

# Script to recreate the state at c2 on top of c4

# Temporary branch name
TEMP_BRANCH="temp_c2"
# New branch name to recreate the state at c2
NEW_BRANCH="new_branch"

# Function to checkout temporary branch at c2
checkout_temp_c2() {
    echo "# Checking out a temporary branch at c2"
    echo "# c1 -- c2 (HEAD, temp_c2)"
    git checkout -b $TEMP_BRANCH c2
}

# Function to checkout a new branch from master
checkout_new_branch() {
    echo "# Checking out a new branch from master (HEAD at c4)"
    echo "# c1 -- c2 -- c3 -- c4 (HEAD, new_branch)"
    git checkout master
    git checkout -b $NEW_BRANCH
}

# Function to apply state from c2 to the new branch
apply_state_from_c2() {
    echo "# Applying state from c2 to the new branch"
    echo "# Working directory now reflects c2"
    git checkout $TEMP_BRANCH -- .
}

# Function to commit changes and recreate state at c2
commit_changes() {
    echo "# Committing changes to recreate state at c2 on top of c4"
    echo "# c1 -- c2 -- c3 -- c4 -- c2' (HEAD, new_branch)"
    git add .
    git commit -m "Recreating the state at c2"
}

# Function to merge the new branch back to master
merge_back_to_master() {
    echo "# Merging the new branch back to master"
    echo "# c1 -- c2 -- c3 -- c4 -- c2' (HEAD, master)"
    git checkout master
    git merge $NEW_BRANCH
}

# Function to delete temporary branches
clean() {
    echo "# Cleaning up temporary branches"
    git branch -D $TEMP_BRANCH
    git branch -D $NEW_BRANCH
}

# Main function to recreate state at c2
recreate_state_at_c2() {
    checkout_temp_c2
    checkout_new_branch
    apply_state_from_c2
    commit_changes
    merge_back_to_master
}

# Call main function
recreate_state_at_c2
# Optionally, call clean
# clean
