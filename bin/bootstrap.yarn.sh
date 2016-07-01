#!/bin/bash

IP=`ip addr show eth0 | grep 'inet ' | cut -d/ -f1 | awk '{print $2}'`

sed -i "s/@NODE_MANAGER_IP@/$IP/g" $HADOOP_CONF_DIR/yarn-site.xml

/usr/sbin/sshd && start-yarn.sh