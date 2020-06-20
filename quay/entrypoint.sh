#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Update Server
if [ ! -z ${SRCDS_APPID} ]; then
  ./steam/steamcmd.sh +@sSteamCmdForcePlatformType windows +login anonymous +force_install_dir /home/container +app_update ${SRCDS_APPID} +quit
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}