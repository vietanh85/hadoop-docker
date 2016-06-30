#!/bin/bash

IP=`ip addr show eth0 | grep 'inet ' | cut -d/ -f1 | awk '{print $2}'`
sed -i "s/@IP@/$IP/g" $HADOOP_CONF_DIR/core-site.xml

echo "$IP \t$(hostname)" >> /etc/hosts

hdfs namenode -format \
    && /usr/sbin/sshd \
    && start-dfs.sh && hdfs dfs -mkdir -p /hbase && hdfs dfs -chown root:root /hbase