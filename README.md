# getnewip

##### Description
getnewip is a way to dodge having to setup an static IP address for a GNU/Linux devices.
Utilising Dropbox as a middle man for storing IP addresses, getnewip downloads the IP address of (a) given server(s) from as many Dropbox accounts/folders as intended.
(This is a companion program that pairs with [uploadnewip](https://github.com/BobyMCbobs/uploadnewip))

##### Building
Dependencies: fakeroot
To build into a Debian package, run `make` inside of the cloned repository.

##### Installation
a. Though make: `sudo make install`     
b. Through apt:  `apt install ./getnewip.deb`     
c. Through dpkg: `dpkg -i  ./getnewip.deb`    

##### Usage
Standard use: `getnewip [ARGS]`     
Help: `getnewip -h`     
Generate a config unit: `getnewip -m`    

##### Dropbox app
1. Go to [Dropbox app](https://www.dropbox.com/developers/apps) page      
2. Choose 'Dropbox API', 'App Folder', finally give it a unique name      
3. Under 'OAuth2' find 'Generate access token'. Use the string of characters returned in variable 'dropboxAppKey' for a unit config file.     

##### Other notes  
- For a slim version (built for [Termux](https://termux.com/) on Android) -- refer to [getnewip-mini](https://github.com/BobyMCbobs/getnewip-mini).
- This has been tested on GNU/Linux (Ubuntu, Debian, Raspbian).
