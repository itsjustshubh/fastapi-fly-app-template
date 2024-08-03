#!/bin/bash

# Function to install a package
install_package() {
  package=$1
  echo "Installing $package using pip..."
  pip install $package

  echo "Adding $package using Poetry..."
  poetry add $package
}

# Function to uninstall a package
uninstall_package() {
  package=$1
  echo "Uninstalling $package using pip..."
  pip uninstall -y $package

  echo "Removing $package using Poetry..."
  poetry remove $package
}

# Check if the first argument is "install" or "uninstall"
if [ "$1" == "install" ]; then
  install_package $2
elif [ "$1" == "uninstall" ]; then
  uninstall_package $2
else
  echo "Usage: ./manage_packages.sh [install|uninstall] package_name"
  exit 1
fi
