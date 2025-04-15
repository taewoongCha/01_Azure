#! /bin/bash
setenforce 0
grubby --update-kernel ALL --args selinux=0
dnf install -y httpd php php-cli php-pdo php-fpm php-json php-mysqlnd wget tar
wget https://ko.wordpress.org/wordpress-6.7.2-ko_KR.tar.gz
tar xvfz wordpress-6.7.2-ko_KR.tar.gz
cp -ar wordpress/* /var/www/html
sed -i "s/DirectoryIndex index.html/DirectoryIndex index.php/g" /etc/httpd/conf/httpd.conf
cp /var/www/html/{wp-config-sample.php,wp-config.php}
sed -i "s/database_name_here/wordpress/g" /var/www/html/wp-config.php
sed -i "s/username_here/team4/g" /var/www/html/wp-config.php
sed -i "s/password_here/It12345\!/g" /var/www/html/wp-config.php
sed -i "s/localhost/team4-mysql.mysql.database.azure.com/g" /var/www/html/wp-config.php
echo -n '<html><body><h1>TEAM4_HEALTH_TESTPAGE_1</h1></body></html>' > /var/www/html/health.html
chown -R apache:apache /var/www/
systemctl enable --now httpd
