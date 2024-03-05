#!/bin/bash

# Function to print the home directory
print_home_directory() {
    echo "Home directory:"
    awk -F: '{print $6}' /etc/passwd
}

# Function to list all usernames
list_usernames() {
    echo "Usernames:"
    awk -F: '{print $1}' /etc/passwd
}

# Function to count the number of users
count_users() {
    echo "Number of users:"
    awk -F: 'END {print NR}' /etc/passwd
}

# Function to find the home directory of a specific user
find_home_directory() {
    read -p "Enter username: " username
    echo "Home directory of user $username:"
    awk -v user="$username" -F: '$1 == user {print $6}' /etc/passwd
}

# Function to list users with specific UID range
list_users_by_uid_range() {
    read -p "Enter UID range (e.g. 1000-1010): " uid_range
    min_uid=$(echo "$uid_range" | cut -d '-' -f1)
    max_uid=$(echo "$uid_range" | cut -d '-' -f2)
    echo "Users with UID in range $uid_range:"
    awk -v min="$min_uid" -v max="$max_uid" -F: '$3 >= min && $3 <= max {print $1}' /etc/passwd
}

# Function to find users with standard shells
find_users_with_standard_shells() {
    echo "Users with standard shells (/bin/bash or /bin/sh):"
    awk -F: '$NF ~ /\/bin\/(bash|sh)$/ {print $1}' /etc/passwd
}

# Function to replace "/" with "\" in the entire /etc/passwd file and redirect to a new file
replace_slash_with_backslash() {
    echo "Replacing '/' with '\' in /etc/passwd..."
    sed 's/\//\\/g' /etc/passwd > /etc/passwd_modified
    echo "Content replaced and saved in /etc/passwd_modified"
}

# Function to print the private IP
print_private_ip() {
    echo "Private IP:"
    hostname -I | awk '{print $1}'
}

# Function to print the public IP
print_public_ip() {
    echo "Public IP:"
    echo "Public IP: Not available"
}

# Function to switch to the john user
switch_to_john_user() {
    
    if su -s /bin/bash john -c "echo 'Switching to john user...'"; then
        echo "Switched to john user successfully."
    else
        echo "Failed to switch to john user."
    fi
}


# Main function
main() {
    print_home_directory
    echo ""
    list_usernames
    echo ""
    count_users
    echo ""
    find_home_directory
    echo ""
    list_users_by_uid_range
    echo ""
    find_users_with_standard_shells
    echo ""
    replace_slash_with_backslash
    echo ""
    print_private_ip
    echo ""
    print_public_ip
    echo ""
    switch_to_john_user
    echo ""
    print_home_directory
    
}

# Check if script is executed with appropriate privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root." >&2
    exit 1
fi

# Execute main function
main
