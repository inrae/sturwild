#! /bin/bash
# generate rsa key for encrypted tokens
echo "generate encryption keys for identification tokens"
openssl genpkey -algorithm rsa -out param/id_sturwild -pkeyopt rsa_keygen_bits:2048
openssl rsa -in param/id_sturwild -pubout -out param/id_sturwild.pub
chown www-data param/id_sturwild