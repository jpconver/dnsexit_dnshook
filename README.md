# dehydrated [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=23P9DSJBTY7C8)

![](docs/logo.jpg)

Dehydrated is a client for signing certificates with an ACME-server (e.g. Let's Encrypt) implemented as a relatively simple (zsh-compatible) bash-script.
This client supports both ACME v1 and the new ACME v2 including support for wildcard certificates!

It uses the `openssl` utility for everything related to actually handling keys and certificates, so you need to have that installed.

Other dependencies are: cURL, sed, grep, awk, mktemp (all found pre-installed on almost any system, cURL being the only exception).

Current features:
- Signing of a list of domains (including wildcard domains!)
- Signing of a custom CSR (either standalone or completely automated using hooks!)
- Renewal if a certificate is about to expire or defined set of domains changed
- Certificate revocation

Please keep in mind that this software, the ACME-protocol and all supported CA servers out there are relatively young and there might be a few issues. Feel free to report any issues you find with this script or contribute by submitting a pull request,
but please check for duplicates first (feel free to comment on those to get things rolling).

## Getting started

For getting started I recommend taking a look at [docs/domains_txt.md](docs/domains_txt.md), [docs/wellknown.md](docs/wellknown.md) and the [Usage](#usage) section on this page (you'll probably only need the `-c` option).

Generally you want to set up your WELLKNOWN path first, and then fill in domains.txt.

**Please note that you should use the staging URL when experimenting with this script to not hit Let's Encrypt's rate limits.** See [docs/staging.md](docs/staging.md).

If you have any problems take a look at our [Troubleshooting](docs/troubleshooting.md) guide.

## Config
