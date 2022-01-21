#!/bin/bash -e

echo "Test Authenticator Script"

# ask for user input
read -p 'DNSExit api-key:: ' dnsExitToken
read -p 'DNSExit Domain List:: ' dnsExitDomainList
read -p 'CERTBOT Domain:: ' certbotDomain

# export variables
export DNSEXIT_TOKEN=${dnsExitToken}
export DNSEXIT_BASE_DOMAINS=${dnsExitDomainList}
export CERTBOT_DOMAIN=${certbotDomain}
export CERTBOT_VALIDATION=jfEVZCbJH_J96HjWXPNGoW0rpolrztrA-arVqPTre8c

# execute authenticator
./authenticator.sh

# echo print success
echo "authenticator executed successfully!"
