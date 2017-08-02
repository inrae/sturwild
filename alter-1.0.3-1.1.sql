alter table sturwildgacl.log add column ipaddress varchar;
comment on column sturwildgacl.log.ipaddress is 'Adresse IP du client';
