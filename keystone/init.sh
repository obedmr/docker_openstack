#!/bin/bash

mysql -uroot -h localhost -psecure \
      -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'secure';"
mysql -uroot -h localhost -psecure \
      -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'secure';"

su -s /bin/sh -c "keystone-manage db_sync" keystone
