#!/bin/bash

#update repos
sudo apt-get update

#install PHP / Apache
sudo apt-get install -y php5 libapache2-mod-php5 php-pear

# Install jenkins
sudo apt-get install -y jenkins

pear channel-discover pear.phing.info
pear install --alldeps phing/phing
