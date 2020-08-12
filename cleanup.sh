#!/bin/bash -ex

# load config
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/config.sh"
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/base.sh"

# certbot environment variables
certbotDomain="${CERTBOT_DOMAIN}"
validation="${CERTBOT_VALIDATION}"
cookiesFile="/tmp/dnsExitCookies.txt"

# calculated variables
txtName="_acme-challenge.${fullDomain/$baseDomain/}"
txtValue="${validation}"
token="10d56a723037e3ff850edb5ce6878dd9^1920:1080|1855:1056|24:24^^180"

# get login page
curl -s -D - -X GET -c ${cookiesFile} "https://www.dnsexit.com/Direct.sv?cmd=login" > "/tmp/dnsExitLoginForm.html"

# login
token="10d56a723037e3ff850edb5ce6878dd9^1920:1080|1855:1056|24:24^^180"
curl -L -s -D - -X POST --data "currenttries=0&fptoken=${token}&loggedIn=&topage=&login=${username}&password=${password}&button=Login" -b ${cookiesFile} -c ${cookiesFile} "https://www.dnsexit.com/Login.sv" > "/tmp/dnsExitLoginPage.html"

# get dnsExit domain
getDnsExitDomain baseDomain "$certbotDomain" "/tmp/dnsExitLoginPage.html"

# open domain information
curl -s -D - -X GET -c ${cookiesFile} -b ${cookiesFile} "https://www.dnsexit.com/Direct.sv?cmd=userShowDns&domainname=${baseDomain}" > /tmp/dnsExitDomainPage.html

# get txt record deletion url
IFS=" " 
grepCommand="grep -Pzo (?s)${validation}(.*?)Edit</a>.\\|.<a.class=\"winlink\".href=\"\K(.*?)\" /tmp/dnsExitDomainPage.html"
deletionUrl=`${grepCommand}`
deletionUrl="https://www.dnsexit.com/"${deletionUrl::-1}

# execute delete url
curl -s -D - -X GET -c ${cookiesFile} -b ${cookiesFile} "${deletionUrl}" > /tmp/dnsExitDomainPage.html

# save changes
curl -s -D - -X GET -c ${cookiesFile} -b ${cookiesFile} "https://www.dnsexit.com/Direct.sv?cmd=userShowDns&actioncode=2" > /tmp/dnsExitSaveChanges.html

# cleanup
rm -f /tmp/dnsExit*.*
exit 0
