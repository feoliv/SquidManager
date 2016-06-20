#!/bin/bash

#---------Global---------

#Check if package is installed variables
is_installed_squid=1000;
is_installed_squidguard=1000;
is_installed_sarg=1000;
is_installed_apache=1000;
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
function stop_service(){

 	#Stopping squid service
	 `/etc/init.d/squid stop &>>/dev/null`;
  	
	#Verifying if the action was correctly applyed
  	if [ $? -eq 0 ]
     	then
     		echo "Service sucessfully stopped";
     	else
        	echo "Error while trying to stop the service!";
  	fi

}

function start_service(){

	#Starting squid service
	`/etc/init.d/squid start &>>/dev/null; sarg &>>/dev/null`;
	
	#Verifying if the action was correctly applyed
        if [ $? -eq 0 ]
        then
                echo "Service sucessfully started";
        else
                echo "Error while trying to start the service!";
        fi

}

function add_user(){
	
	#Receiving the user username
	user=$1;
	passwd=$2;	
	
	#Checking if it already exists

	#Executing creation command
	`htpasswd -b /etc/squid/users $user $passwd &>>/dev/null`;

	#Verifying if the action was correctly applyed
	if [ $? -eq 0 ]
           then
                 echo "User successfully added!";
           else
                 echo "Error while trying to add the user!";
        fi

}

function remove_user(){
	
	#Receiving the user username
        user=$1;

        #Executing removal command
	`htpasswd -D /etc/squid/users $user &>>/dev/null`;
	
	#Verifying if the action was correctly applyed
	if [ $? -eq 0 ]
           then
          	 echo "User successfully removed!";
           else
            	 echo "Error while trying to remove the user!";
        fi

}

function reset_password(){

	#Receiving the user username
        user=$1;
        passwd=$2;

        #Checking if it already exists

        #Executing creation command
        `htpasswd -b /etc/squid/users $user $passwd &>>/dev/null`;

        #Verifying if the action was correctly applyed
        if [ $? -eq 0 ]
           then
                 echo "Password successfully changed";
           else
                 echo "Error while trying to reset password!";
        fi
	
}

function add_exception_site(){

	site=$1;
	#Adding site as execption
	`echo $site >> /var/lib/squidguard/db/blacklists/white/urls`;	

	#Verifying if the action was correctly applyed
        if [ $? -eq 0 ]
           then
                 echo "Exception successfully added!";
           else
                 echo "Error while trying to add exception!";
        fi
	
}

function remove_exception_site(){
	
	site=$1;
	#Adding site as execption
	`sed /$site/d /var/lib/squidguard/db/blacklists/white/urls > /var/lib/squidguard/db/blacklists/white/urls`;
	
	#Verifying if the action was correctly applyed
        if [ $? -eq 0 ]
           then
                 echo "Exception successfully removed!";
           else
                 echo "Error while trying to remove the exception!";
        fi

}
#________________________________________________________________________________________________________________________

#-------------------------------------------------Screen Section------------------------------------------------
function welcome_screen(){
	
	echo "Welcome to Squid Manager";	
	echo "1 - Express Installation";
	echo "2 - Personalized Installation";
	echo "3 - Express Removal";
	echo "4 - Personalized Removal";
	echo "5 - Administration";
	echo "6 - Start Service";
	echo "7 - Stop Service";
	echo "8 - Exit";
	echo "choice:";
}

function administration_screen(){

	echo "Administration - Squid Manager";	
	echo "1 - User add";
        echo "2 - User remove";
        echo "3 - User reset password";
        echo "4 - Add proxy exception";
        echo "5 - Remove proxy exception";
	echo "6 - Back to main";
	echo "7 - Exit";
        echo "choice:";
	
}

function installation_personalized(){
	
	#Clear the screen
	clear;
	
	#Verifying if Squid installation is required
	echo "Do you wish to install Squid? [y/n]";
	read answer;
	if [ $answer == "y" ]
		then
		package_tobe_installed[0]="squid";
	else
		package_tobe_installed[0]="";
	fi
	
	#Verifying if the Squid Guard installation is required
	echo "Do you wish to install Squid Guard? [y/n]";
	read answer;
	if [ $answer == "y" ]
		then
		package_tobe_installed[1]="squidguard";
	else
		package_tobe_installed[1]="";
	fi

	#Verifying if the Sarg installation is required
	echo "Do you wish to install Sarg? [y/n]";
	read answer;
	if [ $answer == "y" ]
		then
		package_tobe_installed[2]="sarg";
	else
		package_tobe_installed[2]="";
	fi

	#Verifying if the apache installation is required
        echo "Do you wish to install Apache? [y/n]";
        read answer;
        if [ $answer == "y" ]
                then
                package_tobe_installed[3]="apache";
        else
                package_tobe_installed[3]="";
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
			1 ) 	installation;
				;;
			2 ) 	echo "Will be implemented in the next version";
                                ;;
			3 )	removal_express;
				;;
			4 ) 	echo "Will be implemented in the next version";
				;;
			5 )  	administration;
				;;
			6 )     start_service;
                                ;;
			7 )     stop_service;
                                ;;
			8 )     exit;
                                ;;
		esac
	done
	
}

function administration(){

        while [[ true ]]; do
                administration_screen
                read option; 
                case $option in 
                        1 )     
				echo "--- User creation ---"; 
				echo "Please, inform the username:";
				read user;
				echo "Please, inform the password:";
				read passwd;
				add_user $user $passwd;

                                ;;
                        2 )     
				echo "--- User Removal ---"; 
                                echo "Please, inform the username:";
                                read user;
                                remove_user $user;

                                ;;
                        3 )     
				echo "--- Password Reset ---";
				echo "Please, inform the username:";
                                read user;
                                echo "Please, inform the password:";
                                read passwd;
				password_reset $user $password;

                                ;;
                        4 )     
				echo "--- Add Exception ---";
                                echo "Please, inform the exception you want to add:";
                                read site;
				add_exception_site $site;
                                ;;
                        5 )     
				echo "--- Remove Exception ---";
                                echo "Please, inform the exception you want to remove:";
                                read site;
                                remove_exception_site $site;
                                ;;
                       
			6 )     home;
                                ;;
			
			7 )     exit;
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
			"apache" )
                                                install_apache;
                                                configure_apache;
                                        ;;
		esac

	done

}

#________________________________________________________________________________________________________________________

#-------------------------------------------------Installation Section------------------------------------------------

function installation(){

	#Check if the squid is already intalled, if it isn't it get installed.
	if [ $is_installed_squid -eq 0 ] 
		then
		echo "Squid already installed!";
	else
		install_squid;
		configure_squid;
	fi
	
	#Check if the squid guard is already intalled, if it isn't it get installed.
	if [ $is_installed_squidguard -eq 0 ] 
		then
		echo "Squid Guard already installed!";
	else
		install_squidguard;
		configure_squidguard;
	fi
	
	#Check if the sarg is already intalled, if it isn't it get installed.
	if [ $is_installed_sarg -eq 0 ]
		then
		echo "Sarg already installed!";
	else
		install_sarg;
		configure_sarg;
	fi

	#Check if the apache is already intalled, if it isn't it get installed.
	if [ $is_installed_apache -eq 0 ]
                then
                echo "Apache already installed!";
        else
                install_apache;
		configure_apache;
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

function install_apache(){

        echo "Installing Apache...";
        if [ $is_installed_apache -eq 1 ]
                then
                `apt-get -y install apache2 apache2-utils &>/dev/null`;

                check_intallation;

                if [ $is_installed_apache -eq 0 ]
                        then
                        echo "Apache successffully installed!"
                else
                        echo "Apache wasn't correctly installed!"
                fi

        else
                echo "Apache already installed!"
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

        #Authentication
        auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/users
        acl password proxy_auth REQUIRED
        http_access allow password

        #SquidGuard
        redirect_program /usr/lib/squidGuard

        acl all src 0.0.0.0/0.0.0.0
        acl blocked_sites url_regex -i "/etc/squid/blocked_sites"
        acl blocked_terms dstdom_regex "/etc/squid/blocked_terms"

        http_access deny blocked_sites
        http_access deny blocked_terms
        http_access allow all

EOM`;
	
}

function configure_squidguard(){

	echo "Configuring SquidGuard..."
        #Creating a backup for the default configuration file.
        `mv /etc/squidguard/squidGuard.conf /etc/squidguard/squidGuard.conf.bkp`;
        #Creating new file with the actual configuration
        `touch /etc/squidguard/squidGuard.conf`;

	FILE="/etc/squidguard/squidGuard.conf";
	`/bin/cat <<EOM >$FILE

#SquidManager Default Configuration
dbhome /var/lib/squidguard/db/blacklists/
logdir /var/log/squidguard/

src users {
       	user root
       	}

dest audio_video {
        domainlist audio-video/domains
        urllist audio-video/urls
        }

dest proxy {
        domainlist proxy/domains
        urllist proxy/urls
        }
	
dest white {
        domainlist white/domains
        urllist white/urls
        }

acl {
        users   {
       	        pass !audio-video all
               	redirect http://www.pudim.com.br
                }

        default {
       	        pass white !audio-video !proxy all
               	redirect http://www.pudim.com.br
         	}
        }
EOM`;

	#Download blacklists
        `wget -P /tmp/ -c  http://squidguard.mesd.k12.or.us/blacklists.tgz`;
        #Unpacking blacklists
        `tar -xzf /tmp/blacklists.tgz -C /var/lib/squidguard/db/`;
	#Creation WhiteList
	`mkdir /var/lib/squidguard/db/blacklists/white`;	
	`touch /var/lib/squidguard/db/blacklists/white/domains`;
	`touch /var/lib/squidguard/db/blacklists/white/urls`;
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

function configure_apache(){
	
	echo "Configuring Apache...";
	#Create the file where the proxy users will be stored
	`touch /etc/squid/users`;
		
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

	#Check if apache is already installed
        `hash apache2 2>/dev/null`;
        is_installed_apache=$?;

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
			remove_apache;		
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
		`apt-get -y remove squid &>/dev/null;apt -y autoremove &>/dev/null`;

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
		`apt-get -y remove squidguard &>/dev/null; apt -y autoremove &>/dev/null`;

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
		`apt-get -y remove sarg &>/dev/null; apt -y autoremove &>/dev/null`;

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

function remove_apache(){

        echo "Removing Apache...";
        if [ $is_installed_apache -eq 0 ]
                then
                `apt-get -y remove apache* apache2-utils &>/dev/null;apt -y autoremove &>/dev/null`;

                check_intallation;

                if [ $is_installed_apache -eq 1 ]
                        then
                        echo "Apache successffully removed!"
                else
                        echo "Apache wasn't correctly Removed!"
                fi

        else
                echo "Apache wasn't installed!"
        fi
}

#________________________________________________________________________________________________________________________

clear;
home
