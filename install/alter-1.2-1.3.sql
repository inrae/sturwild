alter table sturwildgacl.acllogin add column totp_key varchar;
COMMENT ON COLUMN sturwildgacl.acllogin.totp_key IS E'TOTP secret key for the user';
CREATE UNIQUE INDEX acllogin_login_idx ON gacl.acllogin
	USING btree
	(
	  login
	);
create sequence sturwild.dbparam_dbparam_id_seq;
select setval( 'sturwild.dbparam_dbparam_id_seq', (select max(dbparam_id) from sturwild.dbparam));
alter table sturwild.dbparam alter column dbparam_id set default nextval('sturwild.dbparam_dbparam_id_seq');
insert into sturwild.dbparam (dbparam_name, dbparam_value) values ('otp_issuer', 'sturwild.eabx.inrae.fr');

CREATE TABLE sturwild.request (
	request_id serial NOT NULL,
	create_date timestamp NOT NULL,
	last_exec timestamp,
	title character varying NOT NULL,
	body character varying NOT NULL,
	login character varying NOT NULL,
	datefields character varying,
	CONSTRAINT request_pk PRIMARY KEY (request_id)

);
-- ddl-end --
COMMENT ON TABLE sturwild.request IS E'Request table in database';
-- ddl-end --
COMMENT ON COLUMN sturwild.request.create_date IS E'Date of create of the request';
-- ddl-end --
COMMENT ON COLUMN sturwild.request.last_exec IS E'Date of the last execution';
-- ddl-end --
COMMENT ON COLUMN sturwild.request.title IS E'Title of the request';
-- ddl-end --
COMMENT ON COLUMN sturwild.request.body IS E'Body of the request. Don''t begin it by SELECT, which will be added automatically';
-- ddl-end --
COMMENT ON COLUMN sturwild.request.login IS E'Login of the creator of the request';
-- ddl-end --
COMMENT ON COLUMN sturwild.request.datefields IS E'List of the date fields used in the request, separated by a comma, for format it';
-- ddl-end --

-- table precision
CREATE TABLE sturwild.precision (
	precision_id serial NOT NULL,
	precision_name varchar NOT NULL,
	CONSTRAINT precision_pk PRIMARY KEY (precision_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.precision IS E'Précision de la localisation du point GPS';
-- ddl-end --
ALTER TABLE sturwild.precision OWNER TO postgres;
-- ddl-end --

INSERT INTO sturwild.precision (precision_name) VALUES (E'Point GPS fourni par le déclarant');
-- ddl-end --
INSERT INTO sturwild.precision (precision_name) VALUES (E'Point GPS estimé < 1km');
-- ddl-end --
INSERT INTO sturwild.precision (precision_name) VALUES (E'Point GPS estimé 1 - 10 km');
-- ddl-end --
INSERT INTO sturwild.precision (precision_name) VALUES (E'Point GPS estimé > 10 km');

alter table sturwild.localisation add column precision_id int;
ALTER TABLE sturwild.localisation ADD CONSTRAINT precision_fk FOREIGN KEY (precision_id)
REFERENCES sturwild.precision (precision_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

INSERT INTO sturwild.dbversion (dbversion_number, dbversion_date) VALUES (E'1.3', E'2021-02-23');
