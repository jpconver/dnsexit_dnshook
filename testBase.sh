#!/bin/bash -e
PS4=':${LINENO}+'

# load base
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/base.sh"

# current path
currentPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function checkDomain () {
  local certbotDomain=$1
  local dnsExitDomain=$2
  getDnsExitDomain baseDomain $certbotDomain "$currentPath/dnsExitLoginPage.html"
  if [ $baseDomain = $dnsExitDomain ]; then
    echo "success: certbot domain: $certbotDomain match with dnsExit domain: $dnsExitDomain"
  else
    echo "failure: certbot domain: $certbotDomain does not match with dnsExit domain: $dnsExitDomain"
  fi 
}

checkDomain "qa.mydomain.com" "qa.mydomain.com"
checkDomain "test.qa.mydomain.com" "test.qa.mydomain.com"
checkDomain "test1.mydomain.com" "mydomain.com"
checkDomain "test1.test2.test3.mydomain.com" "mydomain.com"







