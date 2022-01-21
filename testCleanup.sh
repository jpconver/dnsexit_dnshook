#!/bin/bash -e

echo "Test Cleanup Script"

# ask for user input
read -p 'DNSExit api-key:: ' dnsExitToken
read -p 'DNSExit Domain List:: ' dnsExitDomainList
read -p 'CERTBOT Domain:: ' certbotDomain

# export variables
export DNSEXIT_TOKEN=${dnsExitToken}
export DNSEXIT_BASE_DOMAINS=${dnsExitDomainList}
export CERTBOT_DOMAIN=${certbotDomain}

# execute cleanup script
./cleanup.sh

# print success
echo "cleanup executed successfully"
