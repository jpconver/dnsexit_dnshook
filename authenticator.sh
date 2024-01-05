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
    "add": {
      "type": "TXT",
      "name": "_acme-challenge.${certbotDomain}",
      "content": "${validation}",
      "ttl": 3600,
      "overwrite": true
    }
  }
END
) 
# write json file
echo "${json}" > ${filename}

# save txt record
curl -H "Content-Type: application/json" --data @${filename} https://api.dnsexit.com/dns/

# txt dns
txtName="_acme-challenge.${certbotDomain}"
txtValue="${validation}"

# check that dns change was applied
timer=0
count=0
until dig '@9.9.9.9' -t txt "${txtName}" | grep -q "${txtValue}"; do
  if [[ "$timer" -ge 500 ]]; then
    echo "error: txt record was not added"
    exit 1
  else
    echo "dns not propagated, waiting 15s for record creation and replication... elapsed time: $timer seconds."
    ((timer+=15))
    sleep 15
  fi
done

rm ${filename}

exit 0
