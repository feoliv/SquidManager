#!/bin/bash



#-------------------------------------------------Management Section------------------------------------------------
function enable_internet(){

}

function disable_internet(){

}

function block_per_category(){

}

function unblock_per_category(){

}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Administration Section------------------------------------------------
function stop_proxy(){

}

function start_proxy(){

}

function add_user(){

}

function remove_user(){

}

function add_exception(){

}

function remove_exception(){

}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Data Section------------------------------------------------
function welcome_screen(){
	echo "Hello";
}

function list_rules(){

}

#________________________________________________________________________________________________________________________

#-------------------------------------------------Installation Section------------------------------------------------

function installtion(){

	#Se ja estiver instalado isso devera ser informado
}

function install_squid(){

	installation_logs=`apt-get -y install squid`;

	if [ $? -eq 0 ]
		then
		echo "Squid successffully installed!"
	fi
}

function install_squid_guard(){

	installation_logs=`apt-get -y install squid_guard`;

	if [ $? -eq 0 ]
		then
		echo "Squid Guard successffully installed!"
	fi
}

function install_sarg(){

	installation_logs=`apt-get -y install sarg`;

	if [ $? -eq 0 ]
		then
		echo "Sarg successffully installed!"
	fi
}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Configuration Section------------------------------------------------
function configure_squid(){

}

function configure_squid_guard(){

}

function configure_sarg(){

}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Removal Section------------------------------------------------

function removal(){
	#Confirmação Dupla
	#Remover Tudo
	#Erro se não estiver instalado
}

function remove_squid(){

	removal_logs=`apt-get -y remove squid &`;

	if [ $? -eq 0 ]
		then
		echo "Squid successffully removed!"
	fi
}

function remove_squid_guard(){

	removal_logs=`apt-get -y remove squid_guard &`;

	if [ $? -eq 0 ]
		then
		echo "Squid Guard successffully removed!"
	fi
}

function remove_sarg(){

	removal_logs=`apt-get -y remove sarg &`;

	if [ $? -eq 0 ]
		then
		echo "Sarg successffully removed!"
	fi
}
#________________________________________________________________________________________________________________________


