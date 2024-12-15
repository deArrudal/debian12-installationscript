#!/bin/bash

# setup.sh - Debian 12 Installation & Configuration Automation Script
# How to use this script:
# 1.Save the Script:
#    setup.sh
# 2.Make It Executable:
#    chmod +x setup.sh
# 3.Run the Script as SUDO:
#    sudo ./setup.sh

# Function to print status messages
echo_status() {
    echo -e "\e[1;32m[STATUS]\e[0m $1"
}

LOG_FILE="setup.log"
exec > >(tee -a $LOG_FILE) 2>&1

# Ask user for configuration method
read -p "Enter the path to your setup.conf file (or press Enter for default): " CONFIG_PATH
CONFIG_PATH="${CONFIG_PATH:-setup.conf}"
if [[ -f "$CONFIG_PATH" ]]; then
    echo_status "Loading configuration from $CONFIG_PATH"
    source "$CONFIG_PATH"
else
    echo -e "\e[1;31m[ERROR]\e[0m Configuration file not found! Exiting."
    exit 1
fi

echo_status "Starting Debian 12 setup automation..."

echo_status "Updating and upgrading the system"
sudo apt update && sudo apt upgrade -y || { echo -e "\e[1;31m[ERROR]\e[0m Failed to update/upgrade the system."; exit 1; }

# Ensure necessary tools are installed
echo_status "Installing essential tools (wget, gdebi-core)"
sudo apt install -y wget gdebi-core || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install essential tools."; exit 1; }

# Install SSH server
if [[ -z "$INSTALL_SSH_SERVER" || "$INSTALL_SSH_SERVER" == "true" ]]; then
	message "Installing SSH Server..."
	sudo apt install -y openssh-server || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install SSH server."; exit 1; } 
fi

# Install UFW Firewall
if [[ -z "$INSTALL_UFW" || "$INSTALL_UFW" == "true" ]]; then
	echo_status "Installing UFW firewall"
	sudo apt install -y ufw || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install UFW."; exit 1; }
fi

# Install XFCE4
if [[ -z "$INSTALL_XFCE4" || "$INSTALL_XFCE4" == "true" ]]; then
    echo_status "Installing XFCE4"
    sudo apt install -y xfce4 xfce4-goodies || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install XFCE4."; exit 1; }
fi

# Install Login Screen Settings
if [[ -z "$INSTALL_LIGHTDM" || "$INSTALL_LIGHTDM" == "true" ]]; then
    echo_status "Installing LightDM GTK Greeter Settings"
    sudo apt install -y lightdm-gtk-greeter-settings || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install LightDM GTK Greeter Settings."; exit 1; }
fi

# Install Timeshift
if [[ -z "$INSTALL_TIMESHIFT" || "$INSTALL_TIMESHIFT" == "true" ]]; then
    echo_status "Installing Timeshift"
    sudo apt install -y timeshift || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Timeshift."; exit 1; }
fi

# Install Network Manager
if [[ -z "$INSTALL_NETWORK_MANAGER" || "$INSTALL_NETWORK_MANAGER" == "true" ]]; then
    echo_status "Installing Network Manager"
    sudo apt install -y network-manager-gnome || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Network Manager."; exit 1; }
fi

# Install Python and PIP if not already installed
if [[ -z "$INSTALL_PYTHON" || "$INSTALL_PYTHON" == "true" ]]; then
    echo_status "Installing Python and PIP"
    sudo apt install -y python3-pip || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Python and PIP."; exit 1; }
fi

# Install GCC and G++ for C/C++
if [[ -z "$INSTALL_C_CPP" || "$INSTALL_C_CPP" == "true" ]]; then
    echo_status "Installing GCC and G++"
    sudo apt install -y gcc g++ || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install GCC and G++."; exit 1; }
fi

# Install Java (Amazon Corretto)
if [[ -z "$INSTALL_JAVA" || "$INSTALL_JAVA" == "true" ]]; then
    echo_status "Installing Java (Amazon Corretto)"
    if ! sudo apt-key list | grep -q Corretto; then
        sudo wget -O - https://apt.corretto.aws/corretto.key | sudo gpg --dearmor -o /usr/share/keyrings/corretto-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | sudo tee /etc/apt/sources.list.d/corretto.list
        sudo apt update
    fi
    sudo apt install -y java-21-amazon-corretto-jdk || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Java (Amazon Corretto)."; exit 1; }
fi

# Install Maven
if [[ -z "$INSTALL_MAVEN" || "$INSTALL_MAVEN" == "true" ]]; then
    echo_status "Installing Maven"
    sudo apt install -y maven || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Maven."; exit 1; }
fi

# Install Node.js and npm
if [[ -z "$INSTALL_NODEJS" || "$INSTALL_NODEJS" == "true" ]]; then
    echo_status "Installing Node.js and npm"
    sudo apt install -y nodejs npm || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install NodeJs and NPM."; exit 1; }
fi

# Install VSCode
if [[ -z "$INSTALL_VSCODE" || "$INSTALL_VSCODE" == "true" ]]; then
    echo_status "Installing Visual Studio Code"
    sudo apt install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    rm -f packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt update && sudo apt install -y code || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install VSCode."; exit 1; }
fi

# Install and configure MySQL
if [[ -z "$INSTALL_MYSQL" || "$INSTALL_MYSQL" == "true" ]]; then
    echo_status "Installing and configuring MySQL"
    wget https://dev.mysql.com/get/mysql-apt-config_0.8.33-1_all.deb -P /tmp/
    sudo dpkg -i /tmp/mysql-apt-config_0.8.33-1_all.deb
    sudo apt update
	sudo apt install -y mysql-server || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install MySQL."; exit 1; }
    sudo mysql_secure_installation
fi

# Install DBeaver
if [[ -z "$INSTALL_DBEAVER" || "$INSTALL_DBEAVER" == "true" ]]; then
    echo_status "Installing DBeaver"
    sudo wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
    echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
    sudo apt update
	sudo apt install -y dbeaver-ce || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install DBeaver."; exit 1; }
fi

# Install qBittorrent
if [[ -z "$INSTALL_QBITTORRENT" || "$INSTALL_QBITTORRENT" == "true" ]]; then
	echo_status "Installing qBittorrent"
	sudo apt install -y qbittorrent || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install qBittorrent."; exit 1; }
fi

# Install KeePassXC
if [[ -z "$INSTALL_KEEPASSXC" || "$INSTALL_KEEPASSXC" == "true" ]]; then
    echo_status "Installing KeePassXC"
    sudo apt install -y keepassxc || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install KeePassXC."; exit 1; }
fi

# Install Firefox
if [[ -z "$INSTALL_FIREFOX" || "$INSTALL_FIREFOX" == "true" ]]; then
    echo_status "Installing Firefox"
    sudo apt install -y firefox-esr || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Firefox."; exit 1; }
fi

# Install Thunderbird
if [[ -z "$INSTALL_THUNDERBIRD" || "$INSTALL_THUNDERBIRD" == "true" ]]; then
    echo_status "Installing Thunderbird"
    sudo apt install -y thunderbird || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Thunderbird."; exit 1; }
fi

# Install muPDF
if [[ -z "$INSTALL_MUPDF" || "$INSTALL_MUPDF" == "true" ]]; then
    echo_status "Installing muPDF"
    sudo apt install -y mupdf || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install muPDF."; exit 1; }
fi

# Install VLC
if [[ -z "$INSTALL_VLC" || "$INSTALL_VLC" == "true" ]]; then
    echo_status "Installing VLC"
    sudo apt install -y vlc || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install VLC."; exit 1; }
fi

# Install Krita
if [[ -z "$INSTALL_KRITA" || "$INSTALL_KRITA" == "true" ]]; then
    echo_status "Installing Krita"
    sudo apt install -y krita || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Krita."; exit 1; }
fi

# Install LibreOffice
if [[ -z "$INSTALL_LIBREOFFICE" || "$INSTALL_LIBREOFFICE" == "true" ]]; then
    echo_status "Installing LibreOffice"
    sudo apt install -y libreoffice || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install LibreOffice."; exit 1; }
fi

# Install Obsidian
if [[ -z "$INSTALL_OBSIDIAN" || "$INSTALL_OBSIDIAN" == "true" ]]; then
    echo_status "Installing Obsidian"
    wget -P /tmp/ https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/obsidian_1.7.7_amd64.deb
    sudo apt install -y /tmp/obsidian_1.7.7_amd64.deb || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Obsidian."; exit 1; }
fi

# Install SuperProductivity
if [[ -z "$INSTALL_SUPERPRODUCTIVITY" || "$INSTALL_SUPERPRODUCTIVITY" == "true" ]]; then
    echo_status "Installing SuperProductivity"
    wget -P /tmp/ https://github.com/johannesjo/super-productivity/releases/latest/download/superProductivity-amd64.deb
    sudo apt install -y /tmp/superProductivity-amd64.deb || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install SuperProductivity."; exit 1; }
fi

# Install Zotero
if [[ -z "$INSTALL_ZOTERO" || "$INSTALL_ZOTERO" == "true" ]]; then
    echo_status "Installing Zotero"
    wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
    sudo apt update
	sudo apt install -y zotero || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Zotero."; exit 1; }
fi

# Install RPN Calculator
if [[ -z "$INSTALL_RPN" || "$INSTALL_RPN" == "true" ]]; then
    echo_status "Installing RPN Calculator"
    sudo apt install -y grpn || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install RPN Calculator."; exit 1; }
fi

# Install SimpleScreenRecorder
if [[ -z "$INSTALL_SIMPLESR" || "$INSTALL_SIMPLESR" == "true" ]]; then
    echo_status "Installing SimpleScreenRecorder"
    sudo apt install -y simplescreenrecorder || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install SimpleScreenRecorder."; exit 1; }
fi

# Install Umbrello
if [[ -z "$INSTALL_UMBRELLO" || "$INSTALL_UMBRELLO" == "true" ]]; then
    echo_status "Installing Umbrello"
    sudo apt install -y umbrello || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Umbrello."; exit 1; }
fi

# Install Pencil Project
if [[ -z "$INSTALL_PENCIL" || "$INSTALL_PENCIL" == "true" ]]; then
    echo_status "Installing Pencil Project"
    wget -P /tmp/ https://pencil.evolus.vn/dl/V3.1.1.ga/Pencil_3.1.1.ga_amd64.deb
    sudo apt install -y /tmp/Pencil_3.1.1.ga_amd64.deb || { echo -e "\e[1;31m[ERROR]\e[0m Failed to install Pencil Project."; exit 1; }
fi

# Install Zafiro Icons
if [[ -z "$INSTALL_ZAFIRO_ICONS" || "$INSTALL_ZAFIRO_ICONS" == "true" ]]; then
    echo_status "Installing Zafiro Icons"
    wget -P /tmp/ https://github.com/zayronxio/Zafiro-Nord-Dark/archive/refs/heads/master.zip
    unzip /tmp/master.zip -d /tmp/
    sudo mv /tmp/Zafiro-Nord-Dark-master /usr/share/icons/
    sudo find /usr/share/icons/Zafiro-Nord-Dark-master/ -type d -exec chmod 755 {} \;
    sudo find /usr/share/icons/Zafiro-Nord-Dark-master/ -type f -exec chmod 644 {} \;
fi

# Install JetBrains Mono Font
if [[ -z "$INSTALL_JETBRAINS_MONO" || "$INSTALL_JETBRAINS_MONO" == "true" ]]; then
    echo_status "Installing JetBrains Mono Font"
    wget -P /tmp/ https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
    unzip /tmp/JetBrainsMono-2.304.zip -d /tmp/
    sudo mv /tmp/fonts/ttf /usr/share/fonts/JetBrainsMono
    sudo fc-cache -f -v
fi

# Configure Network Manager
if [[ -z "$INSTALL_NETWORK_MANAGER" || "$INSTALL_NETWORK_MANAGER" == "true" ]]; then
    echo_status "Configuring Network Manager"
    sudo mv /etc/network/interfaces /etc/network/interfaces.old
    sudo sed -i 's/managed=false/managed=true/' /etc/NetworkManager/NetworkManager.conf
    sudo service NetworkManager restart
fi

# Configure UFW Firewall
if [[ -z "$INSTALL_UFW" || "$INSTALL_UFW" == "true" ]]; then
	echo_status "Configuring UFW firewall"
	echo_status "Allowing essential services"
	sudo ufw allow OpenSSH
	sudo ufw allow 80
	sudo ufw allow 443
	echo_status "Enabling UFW firewall"
	sudo ufw enable
fi

# Cleanup temporary files
echo_status "Cleaning up temporary files"
rm -f /tmp/*.deb /tmp/*.zip

# Final Reboot
echo_status "Setup complete."
read -p "Would you like to reboot now? (y/n): " REBOOT
if [[ "$REBOOT" =~ ^[Yy]$ ]]; then
    sudo reboot
else
    echo_status "Reboot skipped. Please reboot manually if required."
fi
