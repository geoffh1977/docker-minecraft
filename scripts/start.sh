#!/bin/sh

# Set Config Variable
MC_CONFIG=$(echo ${1:-default} | tr "[:upper:]" "[:lower:]")

## Prepare Data Files
cd /data

# Agree To EULA
if [ ! -f eula.txt ]
then
  echo eula=true > /data/eula.txt
fi

# Setup Default JSON Files
for X in banned-ips banned-players ops whitelist
do
  if [ ! -f ${X}.json ]
  then
    if [ -f /config/defaults/${X}.json ]
    then
      cp /config/defaults/${X}.json ${X}.json
    else
      echo "[]" > ${X}.json
    fi
  fi
done

# Copy Selected Properties File To Data Folder
if [ ! -f server.properties ]
then
  if [ -f /config/settings/${MC_CONFIG} ]
  then
    cp /config/settings/${MC_CONFIG} server.properties
  else
    echo "Config File Is Not Found!"
    exit 1
  fi
fi

# Execute Minecraft Server
exec java -Xms1024M -Xmx1024M -jar /opt/minecraft/minecraft.jar nogui
