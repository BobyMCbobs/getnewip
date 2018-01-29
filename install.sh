#
# Easy install script for fetching new IP from DropBox
#

echo "-- Welcome, let's begin. --

(Please make sure you have read README.txt)
"

. getnewip.config

first_var="$1"
second_var="$2"

if [[ $first_var = "-h" ]]
then
	echo "
-- Help Menu --

-r for removal
-l for loading a config
-h for this menu
"
	exit

elif [[ $first_var = "-r" ]]
then

	echo "Use variables from uploadnewip.config? [y|n]"
	read use_vars

	if [ $use_vars = "n" ]
	then
		echo "Enter purpose/nickname of program: (i.e: getnewip-x; x being what the nickname/purpose is.) "
		read program_name

		program_name="getnewip-$program_name"

		echo "What is the location of $program_name? (i.e: /usr/local/bin (default, press enter for this.), $HOME/bin) "
		read ipproglocation

		echo "Remove Systemd service (if installed)? "
		read systemd_service_option

		if [[ $ipproglocation = "" ]]
		then
			ipproglocation="/usr/local/bin"
		fi

	else

		program_name="getnewip-$program_name"

		echo "Is your config correct?

Program name is '$program_name'
Location is '$ipproglocation'
Systemd service is '$systemd_service_option'

Continue? [y|n]"
	read continue_var

		if [ $continue_var = "n" ]
		then
			exit
		fi

	fi

	if [ -f $ipproglocation/$program_name ]
	then
		if [ $systemd_service_option = "y" ] && [ -f /etc/systemd/system/$program_name.service ]
		then
			if sudo systemctl stop $program_name.service && \
			sudo systemctl disable $program_name.service && \
			sudo rm /etc/systemd/system/$program_name.service
			then
				echo "> Systemd service removed."
			fi
		else
			echo "> No Systemd service found or removed."
		fi

		if sudo rm $ipproglocation/$program_name
		then
			echo "> Complete."
		fi
		exit
	else
		echo "> Couldn't find $ipproglocation/$program_name."
		exit
	fi

elif [[ $first_var = "" ]]
then
	echo "> Loading getnewip.config"
else
	echo "> $first_var is not a valid argument."
	exit
fi

function where_to_store() {
#picking where to store it
	echo "Store '$prog_name' in /usr/local/bin? [y|n] "
	read ipproglocation

	if [ $ipproglocation = "y" ]
	then
		ipproglocation="/usr/local/bin"
		prog_name_location="$ipproglocation/$prog_name"

	else [ $ipproglocation = "n"

		make_location
	fi
}

function make_location() {
#input location
	echo "> Please enter location: "
	read ipproglocation

	if [ ! -d $ipproglocation ]
	then
		echo "> Location doesn't exist. Please enter an existing location."
		make_location
	fi

	prog_name_location="$ipproglocation/$prog_name"
}

function personalise_prog() {
#config for local testing
	echo "What is your local reference device? (note: must end in '.local')"
	read localrefdevice

	if ping -q -c 1 -W 1 $localrefdevice > /dev/null
	then
		echo "> Found device."
	else
		echo "> Couldn't find device."
	fi

	echo "What are your first local reference ports? (i.e: 22)"
	read port1
	echo "What are your second local reference ports? (i.e: 80)"
  read port2
	echo "How long until loop? (in seconds, i.e, for 1 hour type '3600') "
	read looptime
	echo "Which server would you like to pick for internet testing? "
	read pinging_server
	echo "What's the dropbox folder? (i.e: IP, WORK_IP)"
	read db_folder
	echo "What's the purpose name? (i.e: home, work)"
	read purpose_name
	echo "What do you want the program's name to have appended as? "
	read program_name
	echo "What is the SSH host you want to have being edited? "
	read ext_ssh_config
	echo "Please enter your dropbox authentication key: "
	read dropbox_key
	echo "Install as systemd service? [y|n] "
	read systemd_service_option

  prog_name="getnewip-$program_name"
  prog_name_location="$ipproglocation/$prog_name"

}


function make_edit() {

	echo "Is your config correct?

	- localReferenceDevice is '$localrefdevice'
	- port 1 is '$port1'
	- port 2 is '$port2'
	- time until next check is '$looptime'
	- internet pinging server is '$pinging_server'
	- dropbox folder is '$db_folder'
	- purpose of IP setup is '$purpose_name'
	- ssh config host is '$ext_ssh_config'
	- dropbox authentication key is '$dropbox_key'
	- systemd service is '$systemd_service_option'

	- storing config in '$prog_name_location'

If any are empty, please return to editing uploadnewip.config.
Continue? [y|n]"
	read continue_var
	if [ $continue_var = "n" ]
	then
		echo "Enter Manually? [y|n] "
		read continue_var

		if [ $continue_var = "y" ]
		then
			personalise_prog
		else
			exit
		fi
	fi

	echo "> Making temp file 'custom-$purpose_name-getnewip'"
	cp getnewip custom-$purpose_name-getnewip

	sed -i -e "s/localReferenceDevice=''/localReferenceDevice='$localrefdevice'/g" custom-$purpose_name-getnewip
  sed -i -e "s/localTestPort1=''/localTestPort1='$port1'/g" custom-$purpose_name-getnewip
  sed -i -e "s/localTestPort2=''/localTestPort2='$port2'/g" custom-$purpose_name-getnewip
  sed -i -e "s/loopDelayTime=3600/loopDelayTime=$looptime/g" custom-$purpose_name-getnewip
	sed -i -e "s/pingServer=''/pingServer='$pinging_server'/g" custom-$purpose_name-getnewip
	sed -i -e "s/dropbox_folder=''/dropbox_folder='$db_folder'/g" custom-$purpose_name-getnewip
	sed -i -e "s/purpose=''/purpose='$purpose_name'/g" custom-$purpose_name-getnewip
	sed -i -e "s/SSHcfgHost=''/SSHcfgHost='$ext_ssh_config'/g" custom-$purpose_name-getnewip

}

function copy_to_location() {
#copy script to location
	if ! sudo cp custom-$purpose_name-getnewip $prog_name_location && ls $prog_name_location > /dev/null
	then
		echo "> Copy failed."
		exit
	fi
	
	if sudo chmod +x $prog_name_location
	then
		echo "> Copy complete.
> Removing temp file 'custom-$purpose_name-getnewip'"
		rm custom-$purpose_name-getnewip
	fi
}

function make_service_file() {
#make systemd unit file
cat > $prog_name.service << EOL
[Unit]
Description=If connected to internet, if not at home, fetch for new IP
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=/home/
ExecStart=$ipproglocation/$prog_name -s
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL
}

function setup() {
	if [[ $systemd_service_option = "y" ]]
	then
		if sudo cp $prog_name.service /etc/systemd/system/
		then
			echo "> Systemd service installed."
			rm $prog_name.service
		fi

		if sudo systemctl start $prog_name.service > /dev/null &&	sudo systemctl enable $prog_name.service > /dev/null && sudo systemctl status $prog_name.service > /dev/null
		then
			echo "> '$prog_name.service' enabled and started."
		else
			echo "> Could not start $prog_name.service
> Here is the systemd status for it."
			sudo systemctl status $prog_name.service
			echo "> Disabling $prog_name.service just incase."

			if sudo systemctl stop $prog_name.service > /dev/null && sudo systemctl disable $prog_name.service > /dev/null
			then
				echo "> Disabled."
				exit
			else
				echo "> Couldn't disable."
				exit
			fi
		fi
	else
		rm $prog_name.service
	fi

	if echo "OAUTH_ACCESS_TOKEN=$dropbox_key" > $HOME/.dropbox_uploader
	then
		echo "> DropBox Uploader config made."
	fi
}

#if [ ! -f getnewip.config ]
#then
#	personalise_prog
#	where_to_store

#elif [[ -f getnewip.config ]] && [[ $first_var = "-l" ]]
#then
#	. getnewip.config

#else
#	personalise_prog
#	where_to_store
#fi

make_edit
make_service_file
copy_to_location
setup

echo "
---------
Complete!

Notes:
	- Your scripts is $HOME/.scripts
	- To run without loop and checking for internet, use '$prog_name -n'.
	- To run looping and checking for internet, use '$prog_name -s'
	- To view what the last IP downloaded is, use '$prog_name -i'

> Enjoy."
