#!/bin/bash
serverdir=/mnt/scp/server
datadir=/mnt/scp/persistentdata
echo "Setting timezone to $TZ"
echo $TZ > /etc/timezone 2>&1
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime 2>&1
dpkg-reconfigure -f noninteractive tzdata 2>&1
mkdir -p /root/.steam 2>/dev/null
chmod -R 777 /root/.steam 2>/dev/null
echo " "
echo "Updating scp Dedicated Server files..."
echo " "
/usr/bin/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir "$serverdir" +login anonymous +app_update 872670 validate +quit
echo "steam_appid: "`cat $serverdir/steam_appid.txt`

cd "$serverdir"
echo "Starting SCP Dedicated Server with name $SERVERNAME"
echo "Trying to remove /tmp/.X0-lock"
rm /tmp/.X0-lock 2>&1
echo " "
echo "Starting Xvfb"
Xvfb :0 -screen 0 1024x768x16 &
echo "Launching wine64 SCP"
echo " "
# DISPLAY=:0.0 wine64 /mnt/scp/server/scp.exe -persistentDataPath $datadir -serverName "$SERVERNAME" -saveName "$WORLDNAME" -logFile "$datadir/scp.log" "$game_port" "$query_port" 2>&1
# /usr/bin/tail -f /mnt/scp/persistentdata/scp.log

