#!/bin/bash
      sudo tar -xvf /var/www/html/iBLIS.tar.gz
      cd /var/www/html/iBLIS

echo  "***************************************************************************************************************************"
echo  "*****  CREATING DATABASE FOR IBLIS   **************************************************************************************"

echo  "create database 'iblis'" | mysql -uroot -proot
echo  "**************************** Run the migrations to create the required database tables and Load the basic seed data    *****"
echo  "****************************************************************************************************************************"
echo  

#     php artisan migrate
#     php artisan db:seed

echo  "******************  Installing php dependencies locally from debs directory   ************************************************"
echo  "******************************************************************************************************************************"

if [ ! -x /usr/bin/php ]; then

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
