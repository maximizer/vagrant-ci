#!/bin/bash

# update repos
sudo apt-get update

#install php / apache
sudo apt-get install -y php5 libapache2-mod-php5 php-pear

# install jenkins
sudo apt-get install -y jenkins

# install phing via pear
pear channel-discover pear.phing.info
pear install --alldeps phing/phing
