# Minecraft Server Container #

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/geoffh1977/minecraft.svg?style=plastic)
![GitHub](https://img.shields.io/github/license/geoffh1977/docker-minecraft.svg?style=plastic)

## Description ##
This docker image provides the a Minecraft Server container. It includes some basic configuration to allow anybody to start a server.

## Starting Consul Server ##
To Start The Server:

`docker run --rm --name Minecraft -p 25565:25565 -v /mnt/tank/docker/minecraft/data:/data minecraft:1.14.1 [<CONFIG>]`

## Data Persistence And Configs ##
In order to maintain data persistence across service restarts, you can mount a volume or host share on the "/data" path within the container.

You can also override the default config path and provide your own configuration files by mounting over the "/config" path.

## Downloading The Minecraft Server Container ##
This repository is connected to Docker Hub - so you will always find the latest builds there. Execute the _docker pull_ command in order to get the required image:

* geoffh1977/minecraft:latest - The latest build of the application that was completed
* geoffh1977/minecraft:1.14.1 - An exact version of the application

## Building The Minecraft Server Container ##
After cloning the repository, simply execute the _make build_ command while in the repository root path to execute a docker build of the current Dockerfile. The Makefile contains a number of useful commands which perform different actions.

### Getting In Contact ###
If you find any issues with this container or want to recommend some improvements, fell free to get in contact with me or submit pull requests on github.
