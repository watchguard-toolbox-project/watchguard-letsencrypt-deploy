# watchguard-letsencrypt-deploy
expect script for deploy letsencrypt certificates to WatchGuard Firewalls


# How to use:

the expect script use the WatchGuard SSH API to install certificates.
 1. run **push-root-ca.sh** to deploy the root CA.
 2. run **push-sub-ca.sh** to deploy the sub CA.
 3. run **push-le-cert.sh** to deploy your certificate with private key.

optional you can add your own certificates with **push-single-cert.sh**
