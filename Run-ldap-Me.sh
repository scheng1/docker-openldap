#!/bin/bash

if [ $# != 2 ];then
    echo "USAGE: $0 container_name another_ldap_host_ip" 
    echo " e.g.: $0 ldap_example 11.1.1.1" 
    exit 1
fi

CNAME=$1
HOST_IP=$2

#Create the first ldap server, save the container id in LDAP2_CID and get its IP:
#docker run --name ${CNAME} --hostname ldap.example.org --env LDAP_REPLICATION=true --env LDAP_TLS=false -p 636:636 -p 389:389 --detach osixia/openldap-backup:1.1.8 --loglevel debug

docker run --name ${CNAME} --hostname ldap1.bonc.com --env LDAP_REPLICATION_HOSTS="#PYTHON2BASH:['ldap://ldap1.bonc.com','ldap://ldap2.bonc.com']" --env LDAP_REPLICATION=True --env LDAP_TLS=true -p 636:636 -p 389:389 --detach osixia/openldap-backup:1.1.8 --loglevel debug

#docker exec ${CNAME} bash -c "echo ${HOST_IP} ldap2.example.org >> /etc/hosts"

-------------------------------------------------------------------------------------------------------------------------------

#!/bin/bash

if [ $# != 2 ];then
    echo "USAGE: $0 container_name another_ldap_host_ip" 
    echo " e.g.: $0 ldap_example 11.1.1.1" 
    exit 1
fi

CNAME=$1
HOST_IP=$2

#Create the second ldap server, save the container id in LDAP2_CID and get its IP:
#docker run --name ${CNAME} --hostname ldap2.example.org --env LDAP_REPLICATION=true --env LDAP_TLS=false -p 636:636 -p 389:389 --detach docker.io/osixia/openldap-backup:1.1.8 --loglevel debug

docker run --name ${CNAME} --hostname ldap2.bonc.com --env LDAP_REPLICATION_HOSTS="#PYTHON2BASH:['ldap://ldap1.bonc.com','ldap://ldap2.bonc.com']" --env LDAP_REPLICATION=true --env LDAP_TLS=true -p 636:636 -p 389:389 --detach docker.io/osixia/openldap:1.1.8 --loglevel debug

#docker exec ${CNAME} bash -c "echo ${HOST_IP} ldap1 >> /etc/hosts"
#docker exec ${CNAME} bash -c "echo ${HOST_IP} ldap.example.org>> /etc/hosts"
