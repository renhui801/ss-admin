sed -i -e "s~@mysql_host~$MYSQL_HOST~g"  -e "s~@mysql_user~$MYSQL_USER~g" -e "s~@mysql_pass~$MYSQL_PASS~g" -e "s~@mysql_db~$MYSQL_DB~g" /usr/local/nginx/html/ss.winhui.top/config/.config.php
