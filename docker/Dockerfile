FROM ubuntu:18.04

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y wget lib32z1 libncurses5:i386 libbz2-1.0:i386 lib32gcc1 lib32stdc++6 libtinfo5:i386 libcurl3-gnutls:i386

RUN useradd -m tf2server
USER tf2server

WORKDIR /home/tf2server

RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar xzf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz
RUN chmod +x steamcmd.sh

# Uncomment for debugging:
#USER root
#RUN apt-get install -y gdb
#USER tf2server

COPY server.sh .
CMD ["./server.sh"]
