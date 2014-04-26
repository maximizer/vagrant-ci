#!/bin/bash

# Update repo for newer version of jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list

# update repos
sudo apt-get update

# install php / apache
sudo apt-get install -y php5 libapache2-mod-php5 php-pear

#install vim
sudo apt-get install -y vim

# install jenkins
sudo apt-get install -y jenkins jenkins-cli

# install jenkins plugins
jenkins-cli -s http://localhost:8080  install-plugin checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations xuni
jenkins-cli -s http://localhost:8080 safe-restart

# install phing via pear
pear channel-discover pear.phing.info
pear install --alldeps phing/phing

# install phpunit via pear
pear config-set auto_discover 1
pear install --alldeps pear.phpunit.de/PHPUnit

# install php code sniffer
php pyrus.phar --alldeps install pear/PHP_CodeSniffer-2.0.0a1

# install php copy and paste detector
wget https://phar.phpunit.de/phpcpd.phar
chmod +x phpcpd.phar
mv phpcpd.phar /usr/local/bin/phpcpd

# install phploc
wget https://phar.phpunit.de/phploc.phar
chmod +x phploc.phar
mv phploc.phar /usr/local/bin/phploc

# install phpdepend
pear channel-discover pear.pdepend.org
pear install --alldeps install pdepend/PHP_Depend-beta

# install mess detector
pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org
pear install --alldeps phpmd/PHP_PMD
