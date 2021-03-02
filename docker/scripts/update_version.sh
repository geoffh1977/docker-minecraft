#!/bin/bash
# Update The Software Version From Online

# Get The Versions Of The Software
SITE_VERSION=$(curl -s https://www.minecraft.net/en-us/download/server/ | grep server.jar | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+")
LOCAL_VERSION=$(grep "finalImageVersion" config.yml | cut -d: -f 2 | sed 's/ //g')

# Check Versions And Update File
if [ "$SITE_VERSION" != "$LOCAL_VERSION" ]
then
  sed -i "s/^finalImageVersion:.*/finalImageVersion: ${SITE_VERSION}/" config.yml
  OBJECT_ID=$(curl -s https://www.minecraft.net/en-us/download/server/ | grep server.jar | sed 's:<a href="\(.*\)">.*</a>:\1:' | cut -d/ -f6)
  sed -i "s/^minecraftObjectId:.*/minecraftObjectId: ${OBJECT_ID}/" config.yml
  echo "Version Updated. New Version Set To ${SITE_VERSION}"
else
  echo "No Version Change Required."
fi
