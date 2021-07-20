#!/bin/bash

echo  "***************** compress application folder *********************************************************************************"

echo
      tar -czvf iBLIS.tar.gz /var/www/iBLIS
echo  "*****************shipping iBLIS to production  ****************************************************************************"
      #"rsync " + "-r $WORKSPACE/iBLIS.tar.gz" + site['username'] + "@" + site['ip_address'] + ":/var/www"

echo

      sudo tar -xvf /var/www/iBLIS.tar.gz
      cd /var/www/iBLIS

echo  "***************************************************************************************************************************"
echo  "*****  CREATING DATABASE FOR IBLIS   **************************************************************************************"

echo  "create database 'iblis'" | mysql -uroot -proot
echo  "**************************** Run the migrations to create the required database tables and Load the basic seed data    *****"
echo  "****************************************************************************************************************************"
echo  

      php artisan migrate
      php artisan db:seed

echo  "******************  Installing php dependencies locally from debs directory   ************************************************"
echo  "******************************************************************************************************************************"
      sudo dpkg -RGE --install debs/
if [ ! -x /usr/local/bin/composer ]; then

echo "**********     installing composer ****************************************************"
echo

      php composer-setup.php --filename=composer.phar
      sudo cp composer.phar /usr/local/bin/composer
      sudo chown root:root /usr/local/bin/composer
      chmod g+x /usr/local/bin/composer
      chmod o+x /usr/local/bin/composer

fi
