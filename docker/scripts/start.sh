#!/bin/sh

# Configure Variables
JAVA_OPTS=${JAVA_OPTS:-'-Xms1024M -Xmx1024M'}

# Agree To EULA
if [ ! -f /data/eula.txt ]
then
  echo eula=true > /data/eula.txt
fi

# Switch To Data Path
cd /data || exit 1

# Execute Minecraft Server
# shellcheck disable=SC2086
exec java ${JAVA_OPTS} -jar /opt/minecraft/minecraft.jar nogui
