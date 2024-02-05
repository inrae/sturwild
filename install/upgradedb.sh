#!/bin/bash
SQL="select dbversion_number from sturwild.dbversion order by dbversion_id desc limit 1"
DBHOST="localhost"
DATABASE="sturwild"
LOGIN="sturwild"
PASSWORD="sturwildPassword"
ADDRESS=postgresql://"$LOGIN":"$PASSWORD"@"$DBHOST"/"$DATABASE"
VERSION=`psql $ADDRESS -c "$SQL" -t|xargs`
FOLDERINSTALL="/var/www/sturwildApp/sturwild"
SCRIPT="$FOLDERINSTALL/install/upgradedb-from-$VERSION.sh"
source $SCRIPT
