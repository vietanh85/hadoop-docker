#!/bin/bash

IP=`ip addr show eth0 | grep 'inet ' | cut -d/ -f1 | awk '{print $2}'`

sed -i "s/@IP@/$IP/g" $HADOOP_CONF_DIR/core-site.xml

hdfs namenode -format \
    && /usr/sbin/sshd \
    && hadoop-daemons.sh --script hdfs start namenode