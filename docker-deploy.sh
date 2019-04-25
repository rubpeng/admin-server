#!/usr/bin/env bash
serviceName="admin-server"
BUILD_NUMBER=$1
serviceIp=$2
env=$3

echo "stop and delete exist docker images and container..."
running=`docker ps | grep ${serviceName} | awk '{print $1}'`
if [ ! -z "$running" ]; then
    docker stop $running
fi

container=`docker ps -a | grep ${serviceName} | awk '{print $1}'`
if [ ! -z "$container" ]; then
    docker rm $container -f
fi

imagesid=`docker images|grep -i ${serviceName}|awk '{print $3}'`
if [ ! -z "$imagesid" ]; then
    docker rmi $imagesid -f
fi

echo "load docker images ${serviceName}_${BUILD_NUMBER}.tar .."
docker load -i ${serviceName}_${BUILD_NUMBER}.tar

echo "run docker container..."
docker run --env env=${env} --env serviceIp=${serviceIp} -it -d -p 8000:8000 --name ${serviceName} ${serviceName}:$BUILD_NUMBER