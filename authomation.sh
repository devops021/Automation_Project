#!/bin/bash
sudo apt update -y

    dpkg -s apache2 &> /dev/null

    if [ $? -ne 0 ]
        then
            sudo apt-get install apache2
            sudo systemctl enable apache2
    fi


    if [ $(/etc/init.d/apache2 status |grep 'active (running)' | wc -l) != 1 ]
        then
                echo "Starting Apache2"
                sudo systemctl start apache2
    fi


timestamp=$(date '+%d%m%Y-%H%M%S')
echo "$timestamp"
myname="Mukul"
s3_bucket="upgradmukul"
tar -czvf /tmp/$myname-httpd-logs-$timestamp.tar /var/log/apache2/*.log
aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
