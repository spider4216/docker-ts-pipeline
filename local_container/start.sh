#!/bin/bash

echo "Add host...  \n";
echo '127.0.0.1      test.loc' >> /etc/hosts

echo "Starting services... \n";
service nginx start
service postgresql start
service php7.0-fpm start
DISPLAY=:99 xvfb-run -a -n 1 -l -s "-screen 0, 1024x768x8" java -Dwebdriver.gecko.driver="/usr/local/src/geckodriver" -jar /usr/local/src/selenium-server-standalone-3.3.0.jar &
./yii migrate-app --migrationPath=@yii/rbac/migrations --interactive=0
echo "ok \n"
