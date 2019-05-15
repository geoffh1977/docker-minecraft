# Minecraft Docker Container Build File
FROM geoffh1977/openjdk8:latest
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"
USER root

# Download And Install Minecraft Server - Set run Script Permissions
RUN mkdir -p /data /config /opt/minecraft && \
    chown ${ALPINE_USER}:${ALPINE_USER} /data /config && \
    apk -U --no-cache add wget tini py-pip && \ 
    pip --no-cache-dir install --upgrade pip mcstatus && \
    wget -O /opt/minecraft/minecraft.jar -o /dev/null https://launcher.mojang.com/v1/objects/ed76d597a44c5266be2a7fcd77a8270f1f0bc118/server.jar

# Add Provided Configs To Container
ADD config/ /config/
ADD scripts/start.sh /usr/local/bin/start.sh

# Make Run File Executable
RUN chmod 0755 /usr/local/bin/start.sh

# Docker Settings
USER ${ALPINE_USER}
VOLUME ["/data","/config"]
EXPOSE 25565
WORKDIR /data

# Set Healthcheck
HEALTHCHECK --interval=5m --timeout=5s --start-period=1m \
  CMD mcstatus localhost ping || exit 1

# Set Entrypoint and Default Config
ENTRYPOINT ["/sbin/tini","/usr/local/bin/start.sh"]
CMD ["default"]
