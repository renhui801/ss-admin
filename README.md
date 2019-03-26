# ss-admin
#yum install -y docker	 	
#docker pull winning24/ss-admin
#docker pull centos/mysql-57-centos7
#docker run -d --name=mysql -p3306:3306 -e MYSQL_USER=MYSQL_USER -e MYSQL_PASSWORD=MYSQL_PASSWORD -e MYSQL_DATABASE=sspanel centos/mysql-57-centos7
#docker run -d --name=ss-admin -p80:80 -e MYSQL_USER=MYSQL_USER -e MYSQL_PASSWORD=MYSQL_PASSWORD -e MYSQL_DATABASE=sspanel --link=mysql:mysql ss-admin
