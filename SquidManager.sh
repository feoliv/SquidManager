#!/bin/bash

#---------Global---------

#Check if package is installed variables
is_installed_squid=1000;
is_installed_sarg=1000;
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
	clear;
	echo "1 - Express Installation";
	echo "2 - Personalized Installation";
	echo "3 - Administration";
	echo "4 - Exit";
}

function installation_express(){
	clear;
	$package_tobe_installed[0]="squid";
	$package_tobe_installed[1]="squid_guard";
	$package_tobe_installed[2]="sarg";
}

function installation_personalized(){

	clear;

	echo "Do you wish to install Squid?";
	read answer;
	if [ $answer == "y" ]
		then
		$package_tobe_installed[0]="squid";
	else
		$package_tobe_installed[0]="";
	fi

	echo "Do you wish to install Squid?";
	read answer;
	if [ $answer == "y" ]
		then
		$package_tobe_installed[1]="squid_guard";
	else
		$package_tobe_installed[1]="";
	fi

	echo "Do you wish to install Squid?";
	read answer;
	if [ $answer == "y" ]
		then
		$package_tobe_installed[2]="sarg";
	else
		$package_tobe_installed[2]="";
	fi
	
}

#________________________________________________________________________________________________________________________

#-------------------------------------------------Dispatcher Section------------------------------------------------
function initiallization(){

	while [[ true ]]; do
		welcome_screen
		read option;
		case $option in
			1 ) echo "escolheu 1";
				;;
			2 ) installation_personalized;
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
	if [ $is_installed_squid_guard -eq 0 ] 
		then
		echo "Squid Guard already installed!";
	else
		install_squid_guard;
	fi
	if [ $is_installed_sarg -eq 0 ]
		then
		echo "Sarg already installed!";
	else
		install_sarg;
	fi

	#Se ja estiver instalado isso devera ser informado
}

function install_squid(){

	installation_logs=`apt-get -y install squid &>/dev/null`;

	if [ $? -eq 0 ]
		then
		echo "Squid successffully installed!"
	fi
}

function install_squid_guard(){

	installation_logs=`apt-get -y install squid_guard &>/dev/null`;

	if [ $? -eq 0 ]
		then
		echo "Squid Guard successffully installed!"
	fi
}

function install_sarg(){

	installation_logs=`apt-get -y install sarg &>/dev/null`;

	if [ $? -eq 0 ]
		then
		echo "Sarg successffully installed!"
	fi
}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Configuration Section------------------------------------------------
function configure_squid(){
echo "";
}

function configure_squid_guard(){
echo "";
}

function configure_sarg(){
echo "";
}

function check_intallation(){

	#Check if Squid is already installed
	`dpkg -l squid &>/dev/null`;
	$is_installed_squid=$?;
	
	#Check if Squid Guard is already installed
	`dpkg -l squid_guard &>/dev/null`;
	$is_installed_squid_guard=$?;

	#Check if Sarg is already installed
	`dpkg -l sarg &>/dev/null`;
	$is_installed_sarg=$?;

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

	removal_logs=`apt-get -y remove squid &>/dev/null`;

	if [ $? -eq 0 ]
		then
		echo "Squid successffully removed!"
	fi
}

function remove_squid_guard(){

	removal_logs=`apt-get -y remove squid_guard &>/dev/null`;

	if [ $? -eq 0 ]
		then
		echo "Squid Guard successffully removed!"
	fi
}

function remove_sarg(){

	removal_logs=`apt-get -y remove sarg &>/dev/null`;

	if [ $? -eq 0 ]
		then
		echo "Sarg successffully removed!"
	fi
}
#________________________________________________________________________________________________________________________


initiallization