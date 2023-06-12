#! /bin/bash

echo '=========================================================='
echo -e "\tWelcome to FMWK (php framework) by NSTY.ind"
echo '=========================================================='
echo -e "\t\trunning v0.0.1 pre-alpha version"

read -p 'Proyect name: ' proyectName

echo 'Creating envs file (--dev msg only)'
touch '.env'
echo 'URL=url' >> .env

echo 'Creating macors php file (--dev msg only)'
if [  -f 'macros' ]
then
	echo 'Archivo de macros ya existe'
else
	touch 'macros.php'
	echo '<?php' >> 'macros.php'
	echo 'define("CONFIG_PATH", __DIR__."/../.env");' >> 'macros.php'
	echo 'define("VIEWS_PATH", __DIR__."/../views/");' >> 'macros.php'
	echo 'define("LETTERS_ONLY_NO_SPACES", "__JUST_LETTERS_REGEXP");' >> 'macros.php'
	echo 'define("ROUTER", "URL");' >> 'macros.php'
fi

read -p 'Index file name: ' indexFileName
echo "INDEXCONTROLLER=$indexFileName" >> '.env'
echo "define('INDEX', 'INDEXCONTROLLER');" >> 'macros.php';

##CREATION OF CONNECTIONS FILE
echo 'Creating connections file (--dev msg only)'
if [ -f 'connObj.php' ]
then
	echo 'Archvo de conecciones ya existe'
else
	touch 'connObj.php'
	echo '<?php' >> 'connObj.php'
	echo "include __DIR__.'/iConn.php';" >> 'connObj.php'


fi

echo 'Creating temp connection file'


read -p 'Add database connections [y/n]: ' dbConnResponse
while [ $dbConnResponse == "y" ]
do
	clear
	echo '=========================================================='
	echo -e "\tWelcome to FMWK (php framework) by NSTY.ind"
	echo '=========================================================='
	echo -e "\t\trunning v0.0.1 pre-alpha version"

	read -p 'Connection name: ' connName
	if [[ !( $connName =~ [a-zA-z]) ]]
	then
		echo 'Is not a valid connection name, please introduce a valid one'
		continue
	fi

	cat '.dbClass' >> 'connObj.php'
	sed -i s/'$DBC'/${connName^^}/g 'connObj.php'
	
	echo -e "case DB_${connName^^}: \n\t\t return new __DB_${connName^^}();" >> '.dbConns'
	# echo -e "case DB_${connName^^}: \n\t\t return new __DB_${connName^^}();" '.dbConns' 

	#HOST NAME
	read -p 'Host name: ' hostName
	echo "DB"${connName^^}"HOST=${hostName^^}" >> '.env'
	printf "define('DB_%s_HOST', 'DB%sHOST');\n" ${connName^^} ${connName^^} >> 'macros.php'

	#DATA BASE NAME
	read -p 'Database name: ' dbName
	echo "DB"${connName^^}"=${dbName^^}" >> '.env'
	printf "define('DB_%s', 'DB%s');\n" ${connName^^} ${connName^^} >> 'macros.php'

	#DATA BASE USER
	read -p 'Data base user name: ' dbUser
	echo "DB"${connName^^}"USER=$dbUser" >> '.env'
	printf "define('DB_%s_USER', 'DB%sUSER');\n" ${connName^^} ${connName^^} >> 'macros.php'

	#DATA BASE PWD
	read -p 'Data base pwd: ' dbPwd 
	echo "DB"${connName^^}"PWD=$dbPwd" >> '.env' 
	printf "define('DB_%s_PWD', 'DB%s');\n" ${connName^^} ${connName^^} >> 'macros.php'
	#PORT
	read -p 'Port: ' dbPort  
	echo "DB"${connName^^}"PORT=${dbPort^^}" >> '.env'
	printf "define('DB_%s_PORT', 'DB%s');\n" ${connName^^} ${connName^^} >> 'macros.php'

	read -p 'Want to add another connection [y/n]: ' dbConnResponse
	if [[ !($dbConnResponse == "y") ]]
	then
		break;
	fi 
done

curl -o "$proyectName.zip" http://10.52.3.61/uei/framework_php.zip
unzip "$proyectName.zip"
mv 'framework_php' ./$proyectName
rm "$proyectName.zip"

echo -e "\t\t} \n\t } \n}" >> '.dbConns'


sed -i s/"Home"/"$indexFileName"/g ./$proyectName/controllers/home.php
sed -i s/"home"/"$indexFileName"/g ./$proyectName/index.php
mv ./$proyectName/controllers/home.php ./$proyectName/controllers/"$indexFileName.php"

mv ./$proyectName/views/home ./$proyectName/views/$indexFile

mv .dbConns ./$proyectName/db/connection.php

grep -v '^$' '.env' >> '.env'

mv '.env' ./$proyectName/.env
mv 'macros.php' ./$proyectName/config/macros.php
mv 'connObj.php' ./$proyectName/db/connObj.php


clear
echo '=========================================================='
echo -e "\tGood bye proyect is ready"
echo '=========================================================='
echo -e "\t\trunning v0.0.1 pre-alpha version"





## SE AGREGAN LOS 

# DOWNLOAD AL FILES FROM A REPO AS ZIP FILE AND THEN UN ZIP IT
