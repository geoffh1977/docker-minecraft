# Minecraft Docker Container Build File
FROM openjdk:17-alpine
LABEL maintainer="Geoffrey Harrison <geoffh1977@gmail.com>"

ARG VERSION
ARG URL

# Download And Install Minecraft Server And McStatus
RUN mkdir -p /data /opt/minecraft && \
    apk -U --no-cache add wget tini py-pip && \ 
    pip --no-cache-dir install --upgrade pip mcstatus && \
    wget -O /opt/minecraft/minecraft.jar -o /dev/null ${URL}

COPY docker/scripts/start.sh /usr/local/bin/start.sh
COPY docker/config/* /data/

RUN chmod 0755 /usr/local/bin/start.sh && \
  addgroup -g 1000 minecraft && \
  adduser -u 1000 -D -s /bin/sh -G minecraft minecraft && \
  chown minecraft:minecraft -R /data

VOLUME ["/data"]

EXPOSE 25565

USER minecraft

WORKDIR /data

# Configure McStatus As Healthcheck
HEALTHCHECK --interval=5m --timeout=5s --start-period=1m \
  CMD mcstatus localhost ping || exit 1

# Set Entrypoint and Default Config
ENTRYPOINT ["/sbin/tini"]
CMD ["/usr/local/bin/start.sh"]
