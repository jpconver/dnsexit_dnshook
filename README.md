# dnsExit certbot hook (bash script)

This a hook for the Let's Encrypt ACME client dehydrated (formerly letsencrypt.sh), that enables using DNS records on dnsexit.com to respond to dns-01 challenges. It requires to have dig installed (sudo apt-get install dnsutils)

**Hook Files**
- base.sh (this is an utility file that is used by authorization.sh and cleanup.sh scripts)
- authorization.sh (this script add the dns text record to dnsexit and check that it was succesfully added)
- cleanup.sh (this script delete the created dns txt record)
- config.sh (this script is for setting the dnsExit.com access information)
  - dnsExitToken: Token provided by dns exit
  - dnsExitDomainList: List of possible base domains that you want to process

**How to use it**
- Update the config.sh with your dnsexit.com credentials
- Call the certbot command using the required parameters (renew example)
  - certbot renew --force-renew --break-my-certs --staging --agree-tos --email youremail@server.com --manual --preferred-challenges dns  --manual-auth-hook ./authenticator.sh --manual-cleanup-hook ./cleanup.sh

**How to test it**

- There are two test script that will ask for your DNSExit credentials that will call the main scripts:
  - testAuthenticator.sh
  - testCleanup.sh

I hope this script is useful for the community, if you have any comments or suggestions contact me
