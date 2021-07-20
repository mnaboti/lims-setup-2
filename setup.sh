#!/bin/bash
#cd /var
#sudo mkdir www
#cd www
#pwd
#echo $$
#Get the latest version of iBlis

echo ""
echo "****** Getting latest for iBLIS*******************************************************************************************************"
echo "**************************************************************************************************************************************"
echo
    app_dir="/var/www/iBLIS"

echo letmein |sudo chmod -R 777 "$app_dir"

    repo1="https://github.com/HISMalawi/iBLIS.git"

echo
echo
    git clone "$repo1" "$app_dir"
    cd /var/www/iBLIS
    git stash| git checkout -f development_1.0
echo "************copying .example files to .php************************************************************************************************"
echo "******************************************************************************************************************************************"
#Check if the file exist
FILE=(/var/www/iblis/app/config/database.php,/var/www/iblis/app/config/database.php,/var/www/iblis/app/config/database.php)
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    cp $app_dir/app/config/database.php.example $app_dir/app/config/database.php
    cp $app_dir/app/config/kblis.php.example $app_dir/app/config/kblis.php
    cp $app_dir/app/config/database.php.example $app_dir/app/config/database.php

#installing composer
echo "***************************Running the compose installation script**************************************************************************"
echo "********************************************************************************************************************************************"

    cd /var/www/iBLIS | bash composer_install.sh
echo "************update composer and run composer install****************************************************************************************"
echo

    composer update
    composer install

echo "**************Install dependencies**********************************************************************************************************"
echo
    sudo apt-get -y install php7.0-bz2 php7.0-cli php7.0-curl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-readline php7.0-sqlite3 php7.0-xml php7.0-xsl php7.0-zip php-xdebug apache2 libapache2-mod-php7.0 git curl php7.0-common php7.0-intl php7.0-soap php7.0-xml php7.0-xsl php7.0-fpm
echo "**************compress dependencies with dpkg-repack***************************************************************************************"
echo "Install dpkg-repack if it's not installed*******************************************************************************************************"
echo
    sudo apt-get update
    sudo apt-get install dpkg-repack
#package all dependencies
sudo dpkg-repack php7.0-bz2 php7.0-cli php7.0-curl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-readline php7.0-sqlite3 php7.0-xml php7.0-xsl php7.0-zip php-xdebug apache2 libapache2-mod-php7.0 git curl php7.0-common php7.0-intl php7.0-soap php7.0-xml php7.0-xsl php7.0-fpm
echo "*******************************************************************copy dependencies in debs folder*****************************************"
echo
#sudo mkdir debs
cp *.deb debs

fi

