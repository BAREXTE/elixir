  
# Parent image
FROM mcr.microsoft.com/dotnet/core/runtime:3.1-bionic

MAINTAINER BAREXTE <barexte@gmail.com>

# Install lib32gcc1 and create steam user
RUN \
  dpkg --add-architecture i386 && \
  apt update && \
  apt upgrade -y && \
  apt install lib32gcc1 curl -y && \
  useradd -m elixir && \
  mkdir /elixir && \
  chown elixir:elixir /elixir
  
# Configure environment
USER elixir
WORKDIR /elixir
ENV HOME=/home/elixir

# Install SteamCMD
RUN \
  mkdir ~/steamcmd && \
  cd ~/steamcmd && \
  curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
  ./steamcmd.sh +quit
 
# Install Unturned Dedicated Server
RUN \
  mkdir ~/unturned-server && \
  cd ~/steamcmd && \
  ./steamcmd.sh +login anonymous +force_install_dir "/home/elixir/unturned-server/" +app_update 1110390 +quit
  
# Install Elixir
RUN \
  mkdir /elixir/World && \
  mkdir /elixir/Elixir.Interface

COPY ./tmp /elixir/

# Entrypoint
ENTRYPOINT ["dotnet", "Elixir.Server.dll"]
