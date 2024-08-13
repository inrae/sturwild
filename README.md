# Sturwild

## What is Sturwild?

Sturwild is a software application for recording declarations of accidental sturgeon catches.

It is written in PHP, and is based on the CodeIgniter framework.

The database works with Postgresql.

## How to install it?

- install a virtual machine running Debian or Ubuntu
- define an URL for the application, as **mysturwild.myinstitute.fr**
- create a https certificate to your application
- download the installation script, and run it:

```bash
wget https://github.com/inrae/sturwild/raw/main/install/deploy_new_instance.sh
chmod +x deploy_new_instance.sh
./deploy_new_instance.sh
```

The script will:

- install Apache2 server, Php, Postgresql and all necessary libraries
- install the software in the folder `/var/www/sturwildApp/sturwild`
- create the database
- add the file `/etc/apache2/sites-available/sturwild.conf` to add the virtual host of your application

After that:

- edit the file `/etc/apache2/sites-available/sturwild.conf` to specify the URL and the paths to the certificate
- edit the file `/var/www/sturwildApp/sturwild/.env`, and:
  - define the address of your app (`app.baseURL`)
  - configure the identification mode. By default and to configure the app at the first time, you must:
    - choose an identification mode that contains **BDD** (`Ppci\Config\IdentificationConfig.identificationMode`), for example BDD, CAS-BDD, LDAP-BDD, OIDC-BDD
    - disable the support of TOTP (`Ppci\Config\IdentificationConfig.disableTotpToAdmin=1`)
- activate the app:
  - `a2ensite sturwild`
  - `systemctl restart apache2`
- you must install an email relay: the app send multiple emails when a declaration is created or when it status change. *Postfix* is a good solution for that, but you can use *msmtp*, if you prefer.

You can now load the app into your browser. The first login is:

- login: *admin*
- password: *password*

Edit the database parameters (*Administration > Application Settings*), and particulary:

- **APPLI_CODE**: the code of your institute
- **otp_issuer**: the code of your institute suffixed by STURWILD, to refind the code of the double-identification from the TOTP app in your smartphone.

You can now configure the app, create groups, users, etc. When the configuration is complete, reactive the support of TOTP.

## How to upgrade

```bash
su
cd /var/www/sturwildApp/sturwild
git pull origin main
./upgradedb.sh
```

This will:

- download the last version of the app
- update if necessary the database
