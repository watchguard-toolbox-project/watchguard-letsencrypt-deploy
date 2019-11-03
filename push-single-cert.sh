#!/usr/bin/expect
# WatchGuard Proxy Cert+Key import script - Kevin Schley
# 
# Credits:
# https://www.boc.de/watchguard-info-portal/2016/08/letsencrypt-zertifikat-als-proxy-zertifikat-auf-watchguard-firebox/
# https://www.boc.de/watchguard-info-portal/2016/06/reboot-der-watchguard-per-script/

set firebox    "10.0.10.187";	# WatchGuard IP
set fbusername "admin";			# Username (need device admin)
set fbpassword "readwrite"; 	# Password for admin user



spawn ssh $fbusername@$firebox -p 4118

# accept SSH key verification at first login.

set logged_in 0
 while {!$logged_in} {
 expect timeout {
 } "Are you sure you want to continue connecting (yes/no)? " {
 exp_send "yes\r"
 } "\[Pp\]assword*" {
 exp_send "$fbpassword\r"
 } -re "WG.*(#|>)" {
 set logged_in 1
 }
 }

# Issue import command and disconnect SSH connection!

set timeout 20
 exp_send "import certificate proxy-server from console\r"
 expect timeout {
 } "paste certificate below, then ^D to complete; or ^C to abort" {
 exp_send "
-----BEGIN CERTIFICATE-----
(Insert public key)
-----END CERTIFICATE-----
-----BEGIN RSA PRIVATE KEY-----
(Insert private key)
-----END RSA PRIVATE KEY-----
\r"
 }
 send "\x04"
 exp_send "exit\r"
 expect -re "WG.*(#|>)"
 exp_close
 exp_wait
