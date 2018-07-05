#!/bin/bash

function waiting_client_port_open() {
    local port=$1

    while ! nc -z localhost $port; do   
        sleep 10
    done
}

waiting_client_port_open 9042

IP=$(curl 'http://169.254.169.254/latest/meta-data/local-ipv4')
TOKENS=$(nodetool ring | grep ${IP} | awk '{print $NF ","}' | xargs)
echo ${TOKENS:0:-1}
