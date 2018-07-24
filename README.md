# getnewip

#### Release version: 2.2

##### Description
getnewip is a way to dodge having to setup a static IP address for GNU/Linux devices for user SSH config files.  
Utilising Dropbox as a middle man for storing IP addresses, getnewip downloads the IP address of (a) given server(s) from as many Dropbox accounts/folders as intended.  
(This is a companion program that pairs with [uploadnewip](https://gitlab.com/BobyMCbobs/uploadnewip))  

##### Features  
- Config unit architecture. Have multiple config entries changing at once.  
- Small footprint; Lightweight.  
- Change multiple user SSH config entries.  
- Well configurable.  

##### Packaging
Debian:  
	Binary: `make deb-pkg`  
	Source: `make deb-src`  
CentOS/Fedora specs: support/specs/CentOS-Fedora  
openSUSE specs: support/specs/openSUSE  
Arch Linux: [AUR](https://aur.archlinux.org/packages/getnewip)  
Zip archive: `make build-zip`  

##### Installation
Non-package installation: `make install`  

##### Dependencies  
Ubuntu/Debian/Raspbian: netcat curl bash openssh-client  
Arch Linux: gnu-netcat curl bash openssh  
Fedora/CentOS: nc curl bash openssh-clients  
openSUSE: netcat-openbsd curl bash openssh  

##### Usage
Standard use: `getnewip [ARGS]`  
Help: `getnewip -h`  
Generate a config unit: `getnewip -m`  

##### Dropbox app
1. Go to the [Dropbox app](https://www.dropbox.com/developers/apps) page.  
2. Choose 'Dropbox API', 'App Folder', finally give it a unique name  
3. Under 'OAuth2' find 'Generate access token'. Use the string of characters returned in variable 'dropboxAppKey' for a unit config file.  

##### Notes
- This has been testing on GNU/Linux distributions: Ubuntu (18.04, 16.04), Debian (9.x), Raspbian (9.x), Fedora (28), CentOS (7), and openSUSE (Leap 15, Tumbleweed).  
- Currently only supports Systemd, no plans currently otherwise.  
- For a slim version (built for [Termux](https://termux.com/) on Android) -- refer to [getnewip-mini](https://gitlab.com/BobyMCbobs/getnewip-mini).  
