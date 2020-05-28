#!/bin/bash
set -e

PATH=/usr/local/bin:$PATH

LOCAL_IP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
MY_IP="$LOCAL_IP"!"$MEDIA_PUB_IP"


sed -i -e "s/MY_NG_IP/$LOCAL_IP/g" /etc/rtpengine.conf
sed -i -e "s/MY_IP/$MY_IP/g" /etc/rtpengine.conf
sed -i -e "s/RTP_MIN/$RTP_MIN/g" /etc/rtpengine.conf
sed -i -e "s/RTP_MAX/$RTP_MAX/g" /etc/rtpengine.conf
sed -i -e "s/NG_LISTEN/$NG_LISTEN/g" /etc/rtpengine.conf

if [ "$1" = 'rtpengine' ]; then
  shift
  exec rtpengine --config-file /etc/rtpengine.conf  "$@"
fi

exec "$@"
