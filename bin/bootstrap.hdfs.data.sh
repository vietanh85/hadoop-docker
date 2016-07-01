#!/bin/bash

NAME_NODE_IP=`ping -q -c 1 $NAME_NODE_HOST | grep PING | sed -e "s/).*//" | sed -e "s/.*(//"`
NODE_MANAGER_IP=`ping -q -c 1 $NODE_MANAGER_HOST | grep PING | sed -e "s/).*//" | sed -e "s/.*(//"`

sed -i "s/@IP@/$NAME_NODE_IP/g" $HADOOP_CONF_DIR/core-site.xml
sed -i "s/@NODE_MANAGER_IP@/$NODE_MANAGER_IP/g" $HADOOP_CONF_DIR/yarn-site.xml

echo "$NAME_NODE_IP $NAME_NODE_HOST" >> /etc/hosts

/usr/sbin/sshd && start-dfs.sh