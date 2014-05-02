#!/bin/bash

# Update repo for newer version of jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list

# update repos
apt-get update

# install php / apache
apt-get install -y php5 libapache2-mod-php5 php-pear

# install a few other things we'll need / want
apt-get install -y curl make vim git

# install composer
curl -sS https://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

# install jenkins
apt-get install -y jenkins jenkins-cli

# bounce jenkins
/etc/init.d/jenkins restart

# install phing via pear
pear channel-discover pear.phing.info
pear install --alldeps phing/phing

# install phpunit via pear
pear config-set auto_discover 1
pear install --alldeps pear.phpunit.de/PHPUnit

# install php code sniffer
pear install --alldeps PHP_CodeSniffer-2.0.0a2

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
pear install --alldeps phpmd/PHP_PMD

# install phpdox
apt-get install -y  php5-xsl
wget http://phpdox.de/releases/phpdox.phar
chmod +x phpdox.phar
mv phpdox.phar /usr/local/bin/phpdox

# install jenkins plugins - for some reason shortname aren't working...

# ... so we need this annoying bit...

  # Get the update center ourself
  wget -O default.js http://updates.jenkins-ci.org/update-center.json
  # remove first and last line javascript wrapper
  sed '1d;$d' default.js > default.json
  # Now push it to the update URL
  curl -X POST -H "Accept: application/json" -d @default.json http://localhost:8080/updateCenter/byId/default/postBack

# ... now we can installl all of these.
jenkins-cli -s http://localhost:8080  install-plugin checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations xunit
jenkins-cli -s http://localhost:8080 safe-restart

# pull Sebastian's jenkins-php.org template
wget https://raw.github.com/sebastianbergmann/php-jenkins-template/master/config.xml
jenkins-cli -s http://localhost:8080 create-job php-template
jenkins-cli -s http://localhost:8080 reload-configuration
