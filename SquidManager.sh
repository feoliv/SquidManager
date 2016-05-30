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
	echo "2 - Personalized Installation";
	echo "3 - Administration";
	echo "4 - Exit";
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

	echo "${package_tobe_installed[0]},${package_tobe_installed[1]},${package_tobe_installed[2]}";
	
}

#________________________________________________________________________________________________________________________

#-------------------------------------------------Dispatcher Section------------------------------------------------
function home(){

	while [[ true ]]; do
		welcome_screen
		check_intallation;
		read option;
		case $option in
			1 ) installation_express;
				installation_process;

				;;
			2 ) installation_personalized;
				;;
			3 ) echo "oi";
				;;
			4 ) exit;
				;;
		esac
	done
	
}

function installation_process(){

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

	#Creating a backup for the default configuration file.
	`mv /etc/squid/squid.conf /etc/squid/squid.conf.bkp`;
	#Creating new file with the actual configuration
	`touch /etc/squid/squid.conf`;
	#Creating empty file that reffers to the list of blocked sites
	`touch /etc/squid/blocked_sites`;
	#Creating empty file that reffers to the list of blocked terms
	`touch /etc/squid/bloked_terms`;

	#Introducing the simple content into the file
	`/etc/squid/squid.conf << cat <<EOF
	http_port 3128
	visible_hostname ifsp

	acl all src 0.0.0.0/0.0.0.0
	acl blocked_sites url_regex -i "/etc/squid/blocked_sites"
	acl blocked_terms dstdom_regex "/etc/squid/blocked_terms"

	http_access deny sites_bloqueados
	http_access deny termos_bloqueados
	http_access allow all

EOF`
	
}

function configure_squidguard(){
echo "";
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
	`hash squidguard 2>/dev/null`;
	is_installed_squidguard=$?;

	#Check if Sarg is already installed
	`hash sarg 2>/dev/null`;
	is_installed_sarg=$?;

}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Removal Section------------------------------------------------

function removal(){
	echo "";
	#Confirmação Dupla
	#Remover Tudo
	#Erro se não estiver instalado
}

function remove_squid(){

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
