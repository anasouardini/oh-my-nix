#!/bin/bash
set -eux

# Argument check
if [ $# -lt 1 ]; then
    echo "Usage: $0 <profile-name> [<stage>]"
    echo "Available profiles: desktop."
    exit 1
fi

# picking the target device
## tools
printGreen() {
  printf '\033[1;32m> %s\033[0m\n' "$@" >&2 # bold Green
}
printRed() {
  printf '\033[1;31m> %s\033[0m\n' "$@" >&2 # bold Red
}

printGreen "\nPick a device:"
# lsblk -no name,label,size,serial,model | awk '{print NR, ") ", $0}'
lsblk -no name,label,size,serial,model

echo ""
read -p 'Enter Device Name: /dev/' deviceName
# chosenDevice=$(lsblk -dno name,label,size,serial,model | sed -n ${deviceName}p | awk '{print "/dev/" $1}')
chosenDevice=$(lsblk -dno name,label,size,serial,model | grep ${deviceName} | awk '{print "/dev/" $1}')
if [[ -z $chosenDevice ]]; then
  printRed "The name you've entered doesn't exist"
  exit 0
fi

echo ""
echo "Are you sure you want to format the device ${chosenDevice}? (y/N)"
read -p "[n] : " isContinue
if [[ ! $isContinue = "y" ]]; then
  exit 0
fi

# installing NixOS

PROFILE="$1"
STAGE="${2:-minimal}"
REPO_URL="https://github.com/anasouardini/oh-my-nix"
DEST_DIR="$HOME/oh-my-nix"

# Clone the repo if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    git clone "$REPO_URL" "$DEST_DIR"
fi

cd "$DEST_DIR"

# Ensure the profile exists
if [ ! -d "$PROFILE" ]; then
    echo "Profile '$PROFILE' not found in $DEST_DIR"
    exit 1
fi

# Run disko and nixos-install directly, skipping the flake wrapper
TARGET_DEVICE_NAME="$chosenDevice" nix run github:nix-community/disko -- --mode disko "./$PROFILE/modules/disko.nix"

# Install NixOS with the specified profile (flake)
nixos-install --flake "./$PROFILE#$STAGE" --no-root-password --impure
