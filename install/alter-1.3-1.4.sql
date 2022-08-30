alter table sturwildgacl.logingestion add column nbattempts smallint DEFAULT 0,
	add column lastattempt timestamp;
COMMENT ON COLUMN sturwildgacl.logingestion.nbattempts IS E'Number of connection attempts';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.logingestion.lastattempt IS E'last attempt of connection';

INSERT INTO sturwild.dbversion (dbversion_number, dbversion_date) VALUES (E'1.4', E'2022-08-30');
