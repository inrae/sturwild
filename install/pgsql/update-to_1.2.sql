set search_path = sturwildgacl;
alter table logingestion add column is_expired boolean default false;
alter table logingestion alter column datemodif type timestamp;
drop table login_oldpassword cascade;
create index log_commentaire_idx on log using btree ( commentaire);
create unique index logingestion_login_idx on logingestion using btree(login);
alter table logingestion add column is_clientws boolean default false;
alter table logingestion add column tokenws varchar;
create index log_ip_idx on log using btree (ipaddress);

CREATE TABLE sturwild.dbparam
(
   dbparam_id     integer   NOT NULL,
   dbparam_name   varchar   NOT NULL,
   dbparam_value  varchar
);

ALTER TABLE sturwild.dbparam
   ADD CONSTRAINT dbparam_pk
   PRIMARY KEY (dbparam_id);

COMMENT ON TABLE sturwild.dbparam IS 'Table of parameters intrinsically associated to the instance';
COMMENT ON column sturwild.dbparam.dbparam_name IS 'Name of the parameter';
COMMENT ON column sturwild.dbparam.dbparam_value IS 'Value of the parameter';
INSERT INTO sturwild.dbparam (dbparam_id,dbparam_name,dbparam_value) 
VALUES
  (1,'APPLI_code','sturwild'),
  (2,'APPLI_title','STURWILD'),
  (3,'mapDefaultX','-0.70'),
  (4,'mapDefaultY','44.77'),
  (5,'mapDefaultZoom','7');
insert into sturwild.dbversion (dbversion_number, dbversion_date) values ('1.2', '2020-08-18');
