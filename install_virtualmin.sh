#!/bin/bash

# Function to run commands and check for errors
run_command() {
    "$@"
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Error occurred. Exiting."
        exit $exit_code
    fi
}

# Step 1: Download Virtualmin Install Script
clear
echo "Step 1: Downloading Virtualmin Install Script..."
wget https://software.virtualmin.com/gpl/scripts/virtualmin-install.sh

# Step 2: Run the Install Script and Configure Virtualmin
clear
echo "Step 2: Running the Install Script and Configuring Virtualmin..."
echo "y" | run_command sudo sh virtualmin-install.sh

# Step 3: Enable sury/php repository
clear
echo "Step 3: Enabling sury/php repository..."
run_command sudo apt-get -y install apt-transport-https lsb-release ca-certificates curl
run_command sudo curl -sSL -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
run_command sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/sury-debian-php-$(lsb_release -sc).list'
run_command sudo apt-get update

# Step 4: Install additional PHP packages
clear
echo "Step 4: Installing additional PHP packages..."
echo "y" | run_command sudo apt-get install php8.1-{cgi,cli,fpm,pdo,gd,mbstring,mysqlnd,opcache,xml,zip}

# Step 5: Installation complete
clear
echo "Step 5: Virtualmin and PHP packages have been installed successfully."
