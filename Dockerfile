  
# Parent image
FROM ubuntu:bionic

MAINTAINER BAREXTE <barexte@gmail.com>

# Install lib32gcc1 and create steam user
RUN \
  dpkg --add-architecture i386 && \
  apt update && \
  apt upgrade -y && \
  apt install lib32gcc1 curl -y && \
  useradd -m steam 
  
# Configure environment
USER steam
WORKDIR /home/steam
ENV HOME=/home/steam

# Install SteamCMD
RUN \
  mkdir ~/unturned-server && \
  mkdir ~/Steam && \
  cd ~/Steam && \
  curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
 
# Install SE Server
#RUN \
#  cd ~/Steam && \
#  ./steamcmd.sh +login anonymous +force_install_dir "/home/steam/unturned-server/" +app_update 1110390 +quit

# switch user
USER root
