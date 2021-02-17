#!/bin/sh
. /usr/lib/clash/functions.sh

Key=$(uci get clash.config.license_key 2>/dev/null)
geoip_source=$(uci get clash.config.geoip_source 2>/dev/null)
if [ -f /var/run/geoip_down_complete ]; then
  rm -rf /var/run/geoip_down_complete 2>/dev/null
fi
echo '' >$LOG_UPDATE_GEOIP 2>/dev/null

if [ $geoip_source == 1 ]; then
  ensure_download "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=$Key&suffix=tar.gz" /tmp/ipdb.tar.gz -c4 --timeout=300
  if [ "$?" -eq "0" ]; then
    tar zxvf /tmp/ipdb.tar.gz -C /tmp && rm -rf /tmp/ipdb.tar.gz >/dev/null 2>&1 && mv /tmp/GeoLite2-Country_*/GeoLite2-Country.mmdb /etc/clash/Country.mmdb && rm -rf /tmp/GeoLite2-Country_* >/dev/null 2>&1
  fi
else
  ensure_download "https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb" /etc/clash/Country.mmdb -c4 --timeout=300
fi

sleep 2
touch /var/run/geoip_down_complete >/dev/null 2>&1
sleep 2
rm -rf /var/run/geoip_update >/dev/null 2>&1
echo "" >$LOG_UPDATE_GEOIP >/dev/null 2>&1

if pidof clash >/dev/null; then
  /etc/init.d/clash restart 2>/dev/null
fi
