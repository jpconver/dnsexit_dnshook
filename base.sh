#!/bin/bash

function getDnsExitDomain () {

  local resultVar=$1
  local certbotDomain=$2
  local domainList=$3

  # convert domain list to map
  declare -A dnsExitDomainMap
  IFS=","
  for domain in $domainList
  do
    dnsExitDomainMap[$domain]=1
  done

  # try to match the dnsExit domain with the certbot domain using exact match
  unset dnsExitMatchingDomain
  if [ ! -z ${dnsExitDomainMap[$certbotDomain]:-} ]; then
    dnsExitMatchingDomain="$certbotDomain"
    dnsExitMatchingDomainFound=true
  fi

  # if we were unable to match the domain using exact match then try to match with its variants (for subdomains)
  # example: for certbot domain "test1.test2.myDomain.com" it will try to match it with dnsExit domains: test2.myDomain.com and myDomain.com
  if [ -z ${dnsExitMatchingDomain} ]; then

    # split the certbot domain using dots and create an array of the elements
    # example: test.myDomain.com -> [test,myDomain,com]
    declare -a certbotDomainArray
    IFS="."
    for certbotDomainElement in ${certbotDomain}
    do
      certbotDomainArray+=(${certbotDomainElement})
    done

    IFS=","
    dnsExitMatchingDomain=""
    dnsExitMatchingDomainFound=false
    certbotDomainArrayMaxIndex=$((${#certbotDomainArray[@]}-1))
    for (( idx=${certbotDomainArrayMaxIndex} ; idx>=0 ; idx-- )) ; do
      if [[ $idx != $certbotDomainArrayMaxIndex ]]; then
        dnsExitMatchingDomain="${certbotDomainArray[idx]}.${dnsExitMatchingDomain}"
      else
        dnsExitMatchingDomain="${certbotDomainArray[idx]}"
      fi
      if [[ ${dnsExitDomainMap["$dnsExitMatchingDomain"]} ]]; then
        dnsExitMatchingDomainFound=true
        break;
      fi
    done
  fi

  if [[ ${dnsExitMatchingDomainFound} == false ]]; then
    echo "no matching domain found in dnsExit for: ${certbotDomain}"
    dnsExitMatchingDomain="" 
  fi

  unset IFS
  eval $resultVar="'${dnsExitMatchingDomain}'"

}
