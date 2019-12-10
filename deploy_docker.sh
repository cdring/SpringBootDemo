#!/bin/sh
set -e
projectName=$1
docker_path=$2
appName=$3
tag=$(date +%s)
server_path=10.0.0.21:5000
target_image=${projectName}:${tag}
echo ${target_image}
cd ${docker_path}
docker build --build-arg app=${appName} -t ${target_image} .
docker tag ${target_image} ${server_path}/${projectName}
echo The name of image is "${server_path}/${target_image}"
docker push ${server_path}/${projectName}:latest
docker rmi -f $(docker images | grep ${projectName} | grep ${tag} | awk '{print $3}' | head -n 1)
