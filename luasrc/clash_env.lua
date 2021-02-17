module "luci.clash_env"

local sys = require "luci.sys"

logFile = sys.exec(". /usr/lib/clash/env.sh; echo -n $LOG_FILE")
logReal = sys.exec(". /usr/lib/clash/env.sh; echo -n $LOG_REAL")
logUpdateClash = sys.exec(". /usr/lib/clash/env.sh; echo -n $LOG_UPDATE_CLASH")
logUpdateGeoip = sys.exec(". /usr/lib/clash/env.sh; echo -n $LOG_UPDATE_GEOIP")
