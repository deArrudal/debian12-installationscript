# Debian 12 Setup Script

## Description
This script automates the installation and configuration of "some" essential applications on a fresh Debian 12 system. It allows users to customize the setup through a configuration file (setup_v2.conf), tailoring the process to their specific needs. This script is ideal for quickly setting up a development environment and installing tools commonly used for daily tasks in college and professional work. 

## Applications
The script can install the following applications:

### Security Utilities
- **SSH Server:** Secure shell access.
- **UFW Firewall:** Basic firewall.
### Core System Utilities
- **XFCE4:** Lightweight desktop environment.
- **LightDM GTK Greeter Settings:** Add LigthDM login screen settings to XFCE.
- **Timeshift:** Backup and restore utility.
- **Network Manager Gnome:** Network manager with GUI.
### Development Tools
- **Git** Version control.
- **Python and PIP:** Python development.
- **GCC and G++** Compilers for C/C++ devlopment.
- **Amazon Corretto JDK** Java development.
- **Apache Maven** Build, publish, and deploy several projects.
- **NodeJs and NPM** JavaScript runtime environment and library.
- **VSCode** Code editor.

### Database Tools
- **MySQL** Database server.
- **DBeaver**Database management tool.

### Internet and Communication
- **qBittorrent** Torrent client.
- **KeePassXC** Password manager.
- **Firefox** Internet browser.
- **Thunderbird** Email client.

### Media and Graphics
- **muPDF** PDFs viewer.
- **VLC** Multimedia player.
- **Krita** Painting software.

### Office and Productivity
- **LibreOffice** Open source Office suite.
- **Obsidian** Note-taking app.
- **SuperProductivity** Task manager.
- **Zotero** Reference manager.

### Utilities
- **GRPN** RPN Calculator.
- **SimpleScreenRecorder** Screen recording.
- **Umbrello** UML modeling tool.
- **Pencil Project** Prototyping and wireframing tool.

### Appearance and Fonts
- **Zafiro Dark** Icon theme.
- **JetBrains Mono** Font for developers.

## Prerequisites
- A clean installation of Debian 12.
- Root or sudo privileges.
- Make sure you have the necessary tools (wget, unzip) installed.
    ```bash
    sudo apt install -y wget unzip
    ```
## Execution
Download the repository from the URL and extract into the /tmp directory

```bash
wget -O /tmp/debian12-installationscript.zip https://github.com/deArrudal/debian12-installationscript/archive/refs/heads/main.zip
unzip /tmp/debian12-installationscript.zip -d /tmp

```
Navigate to the script directory and make it executable:

```bash
cd /tmp/debian12-installationscript-main/script
chmod +x ./setup.sh
```
Run the script with:

```bash
sudo ./setup.sh
```

During execution:
- You will be prompted to provide a configuration file path or proceed with the default configuration.
- Follow on-screen instructions for required customization, e.g. MySQL.
- At the end of the script, you will be asked if you want to reboot the system. If skipped, a manual reboot is recommended to apply all changes.

## Configuration File
You can use the `setup.conf` file to customize the behavior of the script. For example:

```bash
INSTALL_THUNDERBIRD=false        # Install Thunderbird email client
INSTALL_MUPDF=true               # Install muPDF for viewing PDFs
```
To edit this file:

```bash
nano /tmp/setup.conf
```
Ensure the configuration file is in the same directory as the script or provide its path when prompted.

## Log File
The script generates a log file (`setup.log`) in the current directory. Use this file to troubleshoot any issues.

## Common Issues
Due to the graphical interface used by MySQL during installation to configure the APT, you must run its installation after rebooting.

## Authors

 - deArruda, Lucas [@SardinhaArruda](https://twitter.com/SardinhaArruda)

## License
This project is licensed under the GPL-3.0 License - see the LICENSE.md file for details

---

For any issues or improvements, feel free to open an issue or pull request in the repository.