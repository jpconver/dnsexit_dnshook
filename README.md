# dnsExit 


This a hook for the Let's Encrypt ACME client dehydrated (formerly letsencrypt.sh), that enables using DNS records on dnsexit.com to respond to dns-01 challenges. 

It's a bash script composed of the following files
- base.sh (this is an utility file that is used by authorization.sh and cleanup.sh)
- authorization.sh (this script add the dns text record to dnsexit and check that it was succesfully added)
- cleanup.sh (this script delete the created dns textrecord)
- config.sh (this script is for setting the dnsExit.com credentials)

How to use it
 # Update the config.sh with your dnsexit.com credentials
 # Call the certbot command using the required parameters: example for renew: certbot renew --force-renew --break-my-certs --staging --agree-tos --email youremail@server.com --manual --preferred-challenges dns  --manual-auth-hook ./authenticator.sh --manual-cleanup-hook ./cleanup.sh

I hope this script is useful for the comunity, if you have any comments or suggestions contact me at: jpconver@gmail.com
