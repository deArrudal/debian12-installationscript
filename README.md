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

## Execution
Download the script using the command line:

```bash
wget -P /tmp/ https://github.com/deArrudal/debian12-installationscript/script/setup.sh
wget -P /tmp/ https://github.com/deArrudal/debian12-installationscript/script/setup.conf
```
Once downloaded, make the script executable:

```bash
chmod +x /tmp/setup.sh
```
Run the script with:

```bash
sudo /tmp/setup.sh
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

## Authors

 - deArruda, Lucas [@SardinhaArruda](https://twitter.com/SardinhaArruda)


## License

This project is licensed under the GPL-3.0 License - see the LICENSE.md file for details

---

For any issues or improvements, feel free to open an issue or pull request in the repository.