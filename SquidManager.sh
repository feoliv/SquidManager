#!/bin/bash

#---------Global---------

#Check if package is installed variables
is_installed_squid=1000;
is_installed_squidguard=1000;
is_installed_sarg=1000;
#Packges to be installed
package_tobe_installed[0]=0;

#-------------------------------------------------Management Section------------------------------------------------
function enable_internet(){
echo "";
}

function disable_internet(){
echo "";
}

function block_per_category(){
echo "";
}

function unblock_per_category(){
echo "";
}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Administration Section------------------------------------------------
function stop_proxy(){
echo "";
}

function start_proxy(){
echo "";
}

function add_user(){
echo "";
}

function remove_user(){
echo "";
}

function add_exception(){
echo "";
}

function remove_exception(){
echo "";
}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Screen Section------------------------------------------------
function welcome_screen(){
	
	echo "1 - Express Installation";
	echo "2 - Express Removal";
	echo "3 - Personalized Installation";
	echo "4 - Administration";
	echo "5 - Exit";
	echo "choice:";
}

function installation_express(){
	clear;
	package_tobe_installed[0]="squid";
	package_tobe_installed[1]="squidguard";
	package_tobe_installed[2]="sarg";
}

function installation_personalized(){

	clear;

	echo "Do you wish to install Squid? [y/n]";
	read answer;
	if [ $answer == "y" ]
		then
		package_tobe_installed[0]="squid";
	else
		package_tobe_installed[0]="";
	fi

	echo "Do you wish to install Squid Guard? [y/n]";
	read answer;
	if [ $answer == "y" ]
		then
		package_tobe_installed[1]="squidguard";
	else
		package_tobe_installed[1]="";
	fi

	echo "Do you wish to install Sarg? [y/n]";
	read answer;
	if [ $answer == "y" ]
		then
		package_tobe_installed[2]="sarg";
	else
		package_tobe_installed[2]="";
	fi

	
}

#________________________________________________________________________________________________________________________

#-------------------------------------------------Dispatcher Section------------------------------------------------
function home(){

	while [[ true ]]; do
		welcome_screen
		check_intallation;
		read option;
		case $option in
			1 ) 	installation_express;
				installation_process;
				;;
			2 ) removal_express;
				;;
			3 ) echo "oi";
				;;
			4 ) exit;
				;;
		esac
	done
	
}

function installation_process(){
	
	echo "Installing softwares:";
	#iterates on the softwares that need to be installed
	for software in ${package_tobe_installed[@]}; do
		
		#Check which software is going to be installed
		case ${software} in
			"squid" ) 		
						install_squid;
						configure_squid;
					;;

			"squidguard" ) 
						install_squidguard;
						configure_squidguard;
					;;

			"sarg" ) 
						install_sarg;
						configure_sarg;
					;;
		esac

	done

}

#________________________________________________________________________________________________________________________

#-------------------------------------------------Installation Section------------------------------------------------

function installation(){


	if [ $is_installed_squid -eq 0 ] 
		then
		echo "Squid already installed!";
	else
		is_installed_squid;
	fi
	if [ $is_installed_squidguard -eq 0 ] 
		then
		echo "Squid Guard already installed!";
	else
		install_squidguard;
	fi
	if [ $is_installed_sarg -eq 0 ]
		then
		echo "Sarg already installed!";
	else
		install_sarg;
	fi

}

function install_squid(){
	
	echo "Installing Squid...";
	if [ $is_installed_squid -eq 1 ]
		then
		`apt-get -y install squid &>/dev/null`;

		check_intallation;

		if [ $is_installed_squid -eq 0 ]
			then
			echo "Squid successffully installed!"
		else
			echo "Squid wasn't correctly installed!"
		fi

	else
		echo "Squid already installed!"
	fi

}

function install_squidguard(){

	echo "Installing Squid Guard...";
	if [ $is_installed_squidguard -eq 1 ]
		then
		`apt-get -y install squidguard &>/dev/null`;

		check_intallation;

		if [ $is_installed_squidguard -eq 0 ]
			then
			echo "Squid Guard successffully installed!"
		else
			echo "Squid Guard wasn't correctly installed!"
		fi

	else
		echo "Squid Guard already installed!"
	fi

}

function install_sarg(){

	echo "Installing Sarg...";
	if [ $is_installed_sarg -eq 1 ]
		then
		`apt-get -y install sarg &>/dev/null`;

		check_intallation;

		if [ $is_installed_sarg -eq 0 ]
			then
			echo "Sarg successffully installed!"
		else
			echo "Sarg wasn't correctly installed!"
		fi

	else
		echo "Sarg already installed!"
	fi

}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Configuration Section------------------------------------------------
function configure_squid(){
	
	echo "Configuring Squid..."
	#Creating a backup for the default configuration file.
	`mv /etc/squid/squid.conf /etc/squid/squid.conf.bkp`;
	#Creating new file with the actual configuration
	`touch /etc/squid/squid.conf`;
	#Creating empty file that reffers to the list of blocked sites
	`touch /etc/squid/blocked_sites`;
	#Creating empty file that reffers to the list of blocked terms
	`touch /etc/squid/bloked_terms`;

	#Introducing the simple content into the file
	FILE="/etc/squid/squid.conf";

	`/bin/cat <<EOM >$FILE
	http_port 3128
	visible_hostname ifsp

	acl all src 0.0.0.0/0.0.0.0
	acl blocked_sites url_regex -i "/etc/squid/blocked_sites"
	acl blocked_terms dstdom_regex "/etc/squid/blocked_terms"

	http_access deny sites_bloqueados
	http_access deny termos_bloqueados
	http_access allow all
EOM`;
	
}

function configure_squidguard(){

	#Download blacklists
	`wget -P /tmp/ -c  http://squidguard.mesd.k12.or.us/blacklists.tgz`;
	#Unpacking blacklists
	`tar -xzf /tmp/blacklists.tgz -C /var/lib/squidguard/db/`;
	#Compiling lists
	`squidGuard -C all`;
	#Setting up the permissions
	`chown -R proxy:proxy /var/lib/squidguard/db/*;
	find /var/lib/squidguard/db -type f | xargs chmod 644;
	find /var/lib/squidguard/db -type d | xargs chmod 755;`
}

function configure_sarg(){
echo "";
}

function check_intallation(){

	#If it is not found returns 1
	#Check if Squid is already installed
	`hash squid 2>/dev/null`;
	is_installed_squid=$?;
	
	#Check if Squid Guard is already installed
	if [ -d /usr/lib/squidguard ]
	then
	is_installed_squidguard=0;
	else
	is_installed_squidguard=1;
	fi

	#Check if Sarg is already installed
	`hash sarg 2>/dev/null`;
	is_installed_sarg=$?;

}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Removal Section------------------------------------------------

function removal_express(){

	echo "Do you wish to remove all the these products: Squid, Squid Guard and Sarg? [y/n]";
	read answer;
	if [ $answer == "y" ]
		then
		echo "Do you REALLY wish to REMOVE ALL the these products: Squid, Squid Guard and Sarg? [y/n]";
		read answer;
		if [ $answer == "y" ]
			then
			remove_squid;
			remove_squidguard;
			remove_sarg;		
		else
			echo "Removal cancelled!";
		fi

		echo "";		
	else
		echo "Removal cancelled!";
	fi
}

function remove_squid(){
	echo "Removing Squid...";
	if [ $is_installed_squid -eq 0 ]
		then
		`apt-get -y remove squid &>/dev/null`;

		check_intallation;

		if [ $is_installed_squid -eq 1 ]
			then
			echo "Squid successffully removed!"
		else
			echo "Squid wasn't correctly Removed!"
		fi

	else
		echo "Squid wasn't installed!"
	fi

}

function remove_squidguard(){
	
	echo "Removing Squid Guard...";
	if [ $is_installed_squidguard -eq 0 ]
		then
		`apt-get -y remove squidguard &>/dev/null`;

		check_intallation;

		if [ $is_installed_squidguard -eq 1 ]
			then
			echo "Squid Guard successffully removed!"
		else
			echo "Squid Guard wasn't correctly Removed!"
		fi

	else
		echo "Squid Guard wasn't installed!"
	fi
}

function remove_sarg(){
	
	echo "Removing Sarg...";	
	if [ $is_installed_sarg -eq 0 ]
		then
		`apt-get -y remove sarg &>/dev/null`;

		check_intallation;

		if [ $is_installed_sarg -eq 1 ]
			then
			echo "Sarg successffully removed!"
		else
			echo "Sarg wasn't correctly Removed!"
		fi

	else
		echo "Sarg wasn't installed!"
	fi
}
#________________________________________________________________________________________________________________________


home
