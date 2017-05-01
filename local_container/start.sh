#!/bin/bash

echo "Add host...  \n"
echo '127.0.0.1      test.loc' >> /etc/hosts

echo "Starting services... \n"
service nginx start
service postgresql start
service php7.0-fpm start

export DISPLAY=:1
Xvfb :1 -screen 0 1024x768x16 &
fluxbox &
java -Dwebdriver.gecko.driver="/usr/local/src/geckodriver" -jar /usr/local/src/selenium-server-standalone-3.3.0.jar &
x11vnc -display :1 -bg -nopw -xkb

./yii migrate-app --appconfig=config/console_test.php --migrationPath=@yii/rbac/migrations --interactive=0
echo "VNC info:"
echo ":0";
hostname -I | cut -d' ' -f1

sleep 20;
