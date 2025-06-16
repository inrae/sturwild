SET search_path=public,pg_catalog,sturwild,sturwildgacl;
-- ddl-end --

-- object: sturwild.institute_aclgroup | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.institute_aclgroup CASCADE;
CREATE TABLE sturwild.institute_aclgroup (
	institute_id integer NOT NULL,
	aclgroup_id integer NOT NULL,
	CONSTRAINT institute_aclgroup_pk PRIMARY KEY (institute_id,aclgroup_id)
);

-- ** [ Created foreign keys ]

-- object: institute_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.institute_aclgroup DROP CONSTRAINT IF EXISTS institute_fk CASCADE;
ALTER TABLE sturwild.institute_aclgroup ADD CONSTRAINT institute_fk FOREIGN KEY (institute_id)
REFERENCES sturwild.institute (institute_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: aclgroup_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.institute_aclgroup DROP CONSTRAINT IF EXISTS aclgroup_fk CASCADE;
ALTER TABLE sturwild.institute_aclgroup ADD CONSTRAINT aclgroup_fk FOREIGN KEY (aclgroup_id)
REFERENCES sturwildgacl.aclgroup (aclgroup_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

insert into institute (institute_code) 
select dbparam_value from dbparam 
where 
dbparam_name = 'APPLI_code'
and not exists 
(select 1 from institute
join dbparam on (dbparam_value = institute_code and dbparam_name = 'APPLI_code')
);

-- update declarations attached to the current institute
update declaration set institute_id = (
select institute_id 
from institute 
join dbparam on (dbparam_value = institute_code and dbparam_name = 'APPLI_code')
)
where institute_id is null;

alter table declaration alter column institute_id set not null;


INSERT INTO sturwild.dbversion (dbversion_number, dbversion_date) VALUES (E'25.0', E'2025-06-16');

