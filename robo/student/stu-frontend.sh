#!/bin/bash

st() {

    if [ $1 -ne 0 ] ; then 
        echo -e "\e[31m faliure \e[0m"
    else
        echo -e "\e[32m sucess \e[0m"
}


echo -n "Installing the Apache Web Server(httpd) :"
sudo yum install httpd -y
st $?

echo -n "Updating proxy config :"
cd /etc/httpd/conf.d
touch app-proxy.conf
cat > app-proxy.conf << EOL
ProxyPass "/student" "http://APP-SERVER-IPADDRESS:8080/student"
ProxyPassReverse "/student"  "http://APP-SERVER-IPADDRESS:8080/student"
EOL 

