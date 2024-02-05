# STURWILD

STURWILD is an application created by INRAE/EABX to record the accidental captures of sturgeons. Wrote with PHP, the database run with PostgreSQL.

It's distributed under Affero GPL License.

## Install on Debian or Ubuntu

To install a new machine from scratch, type these commands :

```
su
wget https://github.com/inrae/sturwild/raw/main/install/deploy_new_instance.sh
chmod +x deploy_new_instance.sh
./deploy_new_instance.sh
```

This script will :

- install Apache2 and php
- install postgresql
- pull the current version of the application in `/var/www/sturwildApp/sturwild`
- generate the database
- add a vhost in Apache2

You must adapt the vhost (`/etc/apache2/vhosts/sturwild.conf`) to your environment, and set a certificate. You must have a DNS used only for the application.
