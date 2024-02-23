#!/bin/bash
title=$(cat << "EOF"
 .d8888b.                     .d888 d8b               .d8888b.  888                     888
d88P  Y88b                   d88P"  Y8P              d88P  Y88b 888                     888
888    888                   888                     Y88b.      888                     888
888         .d88b.  88888b.  888888 888  .d88b.       "Y888b.   888888  8888b.  888d888 888888 888  888 88888b.
888        d88""88b 888 "88b 888    888 d88P"88b         "Y88b. 888        "88b 888P"   888    888  888 888 "88b
888    888 888  888 888  888 888    888 888  888           "888 888    .d888888 888     888    888  888 888  888
Y88b  d88P Y88..88P 888  888 888    888 Y88b 888     Y88b  d88P Y88b.  888  888 888     Y88b.  Y88b 888 888 d88P
 "Y8888P"   "Y88P"  888  888 888    888  "Y88888      "Y8888P"   "Y888 "Y888888 888      "Y888  "Y88888 88888P"
                                             888                                                        888
                                        Y8b d88P                                                        888
                                         "Y88P"                                                         888

EOF
)

clear

if [ -x "$(command -v lolcat)" ]; then
  echo "$title" | lolcat
else
  echo "$title"
fi

set -e

# Check if Zsh is installed
if ! command -v zsh &>/dev/null; then
    echo "Zsh is not installed. Installing..."
    # Install Zsh
    sudo apt install -y zsh
    # Set Zsh as the default shell
    chsh -s "$(command -v zsh)"
else
    echo "Zsh is already installed."
fi

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing..."
    # Install Oh My Zsh (using curl)
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Check if Starship is installed
if ! command -v starship  &>/dev/null; then
    echo "Starship is not installed. Installing..."
    # Install Starship
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
  else
    echo "Starship is already installed."
fi

# Create config symlinks
echo "Creating zshrc symlink..."
ln -s $PWD/.zshrc ~/.zshrc
zsh -c "source ~/.zshrc"

echo "Creating tmux symlink..."
ln -s $PWD/.tmux.conf ~/.tmux.conf

echo "Creating starship symlink..."
ln -s $PWD/starship.toml ~/.config/starship.toml

echo "Startup complete!"

