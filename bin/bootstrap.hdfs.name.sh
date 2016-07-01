#!/bin/bash

IP=`ip addr show eth0 | grep 'inet ' | cut -d/ -f1 | awk '{print $2}'`
NODE_MANAGER_IP=`ping -q -c 1 $NODE_MANAGER_HOST | grep PING | sed -e "s/).*//" | sed -e "s/.*(//"`

sed -i "s/@IP@/$IP/g" $HADOOP_CONF_DIR/core-site.xml
sed -i "s/@NODE_MANAGER_IP@/$IP/g" $HADOOP_CONF_DIR/yarn-site.xml

hdfs namenode -format \
    && /usr/sbin/sshd \
    && start-yarn.sh \
    && start-dfs.sh && hdfs dfs -mkdir -p /hbase && hdfs dfs -chown root:root /hbase