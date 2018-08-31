#!/bin/sh


###
### firewalld
###

systemctl stop firewalld
systemctl disable firewalld

###
### network
###

echo -e 'DNS1=8.8.8.8\nDNS2=8.8.4.4' >> /etc/sysconfig/network-scripts/ifcfg-eth0
service network restart

###
### SELinux disabled
###

sed -i -e "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

###
### yum
###

yum -y update


###
### vim
###

yum -y install vim-enhanced
echo -e 'alias vi='\''vim'\' >> /etc/profile
source /etc/profile

###
### etc
###

yum -y install wget zip unzip tree

###
### date
###

echo -e 'ZONE="Asia/Tokyo"\nUTC=false' > /etc/sysconfig/clock
cp /etc/localtime /etc/localtime.org
ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime


###
### mysql 5.6
###

yum -y erase mysql-libs
rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum -y install http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
yum -y install mysql mysql-server mysql-devel

service mysqld start
/usr/bin/mysqladmin -u root password 'root'


###
### php 7.2  +  apache
###

yum -y remove epel-release
yum -y install epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum -y install --enablerepo=remi,remi-php72 php php-devel php-intl php-mbstring php-pdo php-mysqlnd php-xdebug php-xml php-xmlrpc

cp /etc/php.ini /mnt/project/vagrant/backup/
cp /mnt/project/vagrant/php/php.ini /etc/php.ini


###
### FuelPHP oil
###

curl https://get.fuelphp.com/oil | sh


###
### phpunit
###
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit

###
### apache start
###

cp /etc/httpd/conf/httpd.conf /mnt/project/vagrant/backup/
cp /mnt/project/vagrant/httpd/httpd.conf /etc/httpd/conf/httpd.conf

service httpd start
systemctl enable httpd

###
### composer
###

curl -sS https://getcomposer.org/installer | php > /dev/null
mv composer.phar /usr/local/bin/composer

###
### git
###

yum install -y git

###
### 動作確認のため
###

mkdir /mnt/project/lesson
ln -fs /mnt/project/lesson /var/www/html/lesson

echo '<?php phpinfo();' > /var/www/html/index.php
echo 'hellolesson!' > /mnt/project/lesson/index.php
