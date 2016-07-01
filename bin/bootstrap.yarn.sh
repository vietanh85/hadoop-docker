#!/bin/bash

NAME_NODE_IP=`ping -q -c 1 $NAME_NODE_HOST | grep PING | sed -e "s/).*//" | sed -e "s/.*(//"`
IP=`ip addr show eth0 | grep 'inet ' | cut -d/ -f1 | awk '{print $2}'`

sed -i "s/@YARN_IP@/$IP/g" $HADOOP_CONF_DIR/yarn-site.xml
sed -i "s/@IP@/$NAME_NODE_IP/g" $HADOOP_CONF_DIR/core-site.xml

echo "$NAME_NODE_IP $NAME_NODE_HOST" >> /etc/hosts

/usr/sbin/sshd && start-yarn.sh