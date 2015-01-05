#!/bin/bash
# container.sh
# example script to create a build container

# settings
name=cibuild
domain=webfact.example.ch
interactive=0        # 0=daemon 1=bash

image="boran/cibuild"  
#docker build -t=$image .

volumes="-v /opt/sites/$name/builder:/home/builder -v /opt/sites/$name/log:/var/log  "
mkdir -p /opt/sites/$name/builder /opt/sites/$name/log 2>&1

ports="-p 2201:22 -p 8011:80"

envs=""

args="$ports --restart=always $volumes $envs -e VIRTUAL_HOST=$name.$domain -e VIRTUAL_PORT=80 --hostname $name.$domain --name $name $image"
#echo $args

echo "stop, delete and run $name"
docker stop $name 2>/dev/null
docker rm $name 2>/dev/null
mkdir -p /opt/sites/$name 2>/dev/null

if [ $interactive -eq 1 ] ; then
  docker run -it $args /bin/bash
else 
  docker run -dt $args 
  docker logs -f $name
  #docker exec -it $name bash
fi


