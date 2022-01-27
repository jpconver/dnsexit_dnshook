#!/bin/bash -ex

# load config
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/config.sh"

# load base
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/base.sh"

# certbot environment variables
dnsExitToken="${DNSEXIT_TOKEN}"
dnsExitBaseDomains="${DNSEXIT_BASE_DOMAINS}"
certbotDomain="${CERTBOT_DOMAIN}"
validation="${CERTBOT_VALIDATION}"
filename="update.json"

# get matching dnsExit base domain from certbot provided domain
getDnsExitDomain dnsExitBaseDomain "${certbotDomain}" "${dnsExitBaseDomains}"

json=$(cat <<-END
  {
    "apikey": "${dnsExitToken}",
    "domain": "${dnsExitBaseDomain}",
    "delete": {
      "type": "TXT",
      "name": "_acme-challenge.${certbotDomain}"
    }
  }
END
) 
# write json file
echo "${json}" > ${filename}

# delete txt record
curl  -H "Content-Type: application/json" --data @${filename} https://api.dnsexit.com/dns/

# cleanup
rm -f /tmp/dnsExit*.*
exit 0

exit 0
