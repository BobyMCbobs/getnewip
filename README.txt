Welcome to getnewip by BobyMCbobs

This script works well when paired with uploadnewip (for server side).

-- Installing --

  Simply run './install.sh' (or 'bash install.sh') to launch the installer following the steps to setup getnewhomeip how you want it.

  -- Configurations --

  Having a file called 'getnewhomeip.config' in the same folder as well as running './install.sh -l', will allow install to load configs from a file.

  A config file should look something like this (note: the config must be in a file called 'getnewip.config'.):

    #!/bin/bash

    ##GETNEWHOMEIPCONFIGFILE

    #device on setup network that's always there
    localrefdevice="192.168.1.15"
    #ports that that device has
    port1=80
    port2=22
    #seconds of loop
    looptime=3600
    #server to check internet for
    pinging_server="8.8.8.8"
    #folder in dropbox to download IP for
    db_folder="WORK_IP"
    #purpose/description
    purpose_name="work"
    #related to purpose, but for program name
    program_name="work_main"
    #ssh config to modify
    ext_ssh_config="work_ext"
    #directory to store
    ipproglocation="/usr/local/bin"
    #dropbox key #OAUTH_ACCESS_TOKEN required for dropbox_uploader.sh
    dropbox_key="NUeL78eR11gAAAAAAAAADLeOE1DqkOk8ainvY9Ff5sjhcIwDEL46be2JH05Tb-ER"

    #format for name
    prog_name="getnewhomeip-$program_name"
    #storing it
    prog_name_location="$ipproglocation/$prog_name"

  Feel free to copy this and adjust to your needs. As this is an example, just replace the values of the variables with the config you desire.

  The Dropbox key is required for uploading to Dropbox.
  You must create a Dropbox app over at https://www.dropbox.com/developers/apps, then click generate OAuth2 access token. Use this token/key in your config.
  
      -- SSH config file --

      A file called ~/.ssh/config must exist has have a config formatted like this in it:

        Host NICKNAME
          HostName SERVER.ADDRESS.NUMBERS
          User USERNAME
          IdentityFile ~/.ssh/MYKEY (optional)

      Example:

        Host server1-ext
          HostName 123.12.123.123
          User bob
          IdentityFile ~/.ssh/key

      This configuration is important, as the data will be interpreted in such a way.
      
      The variable 'ext_ssh_config' must contain the name of the external host in your SSH config file.

-- Running --

  If enabled in the installer, then you will have a Systemd service running for automatically fetching the IP.

  Otherwise, if you want to manually run to fetch your new IP, run your customised version with a ' -n' for no looping or checking for internet.

-- Removing --

  Run './install.sh -r' and follow steps.
