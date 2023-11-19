#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' #no color

echo -e "${GREEN}+-------------------------+${NC}"
echo -e "${GREEN}|                         |${NC}"
echo -e "${GREEN}|    Setup starting...    |${NC}"
echo -e "${GREEN}|                         |${NC}"
echo -e "${GREEN}+-------------------------+${NC}"

echo -e "${GREEN}INFO: Installing curl...${NC}"
if ! which curl &> /dev/null; then
    try_install curl
else
    echo -e "${GREEN}INFO: curl is already installed.${NC}"
fi

echo -e "${GREEN}INFO: Installing vim plug...${NC}"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "${GREEN}INFO: Installing nvm & Node.js LTS...${NC}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install --lts

if [ $? -ne 0 ]; then
    echo -e "${RED}ERROR: nvm failed to install Node.js LTS.${NC}"
else
    DEFAULT_VERSION=`nvm version node`
    nvm alias default $DEFAULT_VERSION
    if [ $? -ne 0 ]; then
        echo -e "${RED}ERROR: Failed to set the default Node.js version.${NC}"
    fi

    if ! which node &> /dev/null; then
        echo -e "${RED}ERROR: Node.js was not installed.${NC}"
    else
        echo -e "${GREEN}INFO: Node.js LTS is installed.${NC}"
    fi
fi

echo -e "${GREEN}INFO: Checking if Vim is installed...${NC}"
if ! which vim &> /dev/null; then
    echo -e "${GREEN}INFO: Vim is not installed. Installing...${NC}"
    try_install vim
fi

echo -e "${GREEN}INFO: Installing Vim plugins...${NC}"
vim -E -s -c "PlugInstall" -c "qa"
echo -e "${GREEN}INFO: Vim plugins installation completed successfully.${NC}"

# if the system is Arch-based install chromium, telegram desktop, and yay if available.
if which pacman &> /dev/null; then
    echo -e "${GREEN}INFO: Detected Arch-based system. Installing Chromium...${NC}"
    try_install chromium

    echo -e "${GREEN}INFO: Installing Telegram Desktop...${NC}"
    try_install telegram-desktop

    if ! which yay &> /dev/null; then
        echo -e "${GREEN}INFO: yay package manager not found. Installing yay...${NC}"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
    else
        echo -e "${GREEN}INFO: yay is already installed.${NC}"
    fi

    if which yay &> /dev/null; then
        echo -e "${GREEN}INFO: Installing Visual Studio Code (VSCode)...${NC}"
        yay -S visual-studio-code-bin --noconfirm
    fi
fi

echo -e "${GREEN}+------------------------+${NC}"
echo -e "${GREEN}|                        |${NC}"
echo -e "${GREEN}|    Setup completed!    |${NC}"
echo -e "${GREEN}|                        |${NC}"
echo -e "${GREEN}+------------------------+${NC}"
