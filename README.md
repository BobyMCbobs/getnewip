# getnewip

##### Description
getnewip is a way to dodge having to setup an static IP address for a GNU/Linux devices.
Utilising Dropbox as a middle man for storing IP addresses, getnewip downloads the IP address of (a) given server(s) from as many dropbox accounts/folders as intended.
(This is a companion program that pairs with [uploadnewip](https://github.com/BobyMCbobs/uploadnewip))

##### Building
To build into a debian package, run `make` or `sudo make` (depending on your permissions) inside of the cloned repo.

##### Installation
a. Though make: `make install`
b. Through apt:  `apt install ./getnewip.deb`
c. Through dpkg: `dpkg -i  ./getnewip.deb`

##### Usage
Standard use: `getnewip [ARGS]`
Help: `getnewip -h`
Generate a config unit: `getnewip -m`

##### Dropbox app
1. Go to [Dropbox app](https://www.dropbox.com/developers/apps) page
2. Choose 'Dropbox API', 'App Folder', finally give it a unique name
3. Under 'OAuth2' find 'Generate access token'. Use the string of characters returned in variable 'dropboxAppKey'.

##### Other notes  
For a slim version (built for Termux on Android) -- refer to [getnewip-mini](github.com/BobyMCbobs/getnewip-mini).
