#!/bin/bash

echo LG52hWQ| sudo -S tar -xvf /var/www/html/iBLIS.tar.gz

sudo mv /var/www/html/var/lib/jenkins/workspace/lims-setup_master/iBLIS /var/www/html/iBLIS


echo LG52hWQ| sudo -S chmod -R 777 /var/www/html/iBLIS
