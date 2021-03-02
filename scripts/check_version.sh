#!/bin/bash -xe

# Get Latests Docker Hub Tag
LATEST_TAG=$(curl -s https://hub.docker.com/v2/repositories/geoffh1977/minecraft/tags | jq -r '.results[].name' | grep -v "[a-z]" | sort -rn | head -n1)

# Get Live Software Version
VERSION=$(curl -s https://www.minecraft.net/en-us/download/server/ | grep server.jar | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+")

# Display Results
echo
echo "Latest Stored Docker Build Tag: ${LATEST_TAG}"
echo "Current Live Software Version: ${VERSION}"

echo
if [ "${LATEST_TAG}" == "${VERSION}" ]
then
  echo "Versions Match. No Rebuild Is Required."
  echo "export REBUILD_REQUIRED=false" >> "${BASH_ENV}"
else
  echo "Version MisMatch. A Rebuild Is Required."
  echo "export REBUILD_REQUIRED=true" >> "${BASH_ENV}"
fi
echo
