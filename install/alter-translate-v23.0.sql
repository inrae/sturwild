-- Diff code generated with pgModeler (PostgreSQL Database Modeler)
-- pgModeler version: 1.0.5
-- Diff date: 2023-09-21 09:38:59
-- Source model: sturwild
-- Database: sturwild
-- PostgreSQL version: 13.0

-- [ Diff summary ]
-- Dropped objects: 3
-- Created objects: 23
-- Changed objects: 2

SET search_path=public,pg_catalog,sturwild,sturwildgacl;
-- ddl-end --


-- [ Dropped objects ] --
DROP TABLE IF EXISTS sturwild.estuary_area CASCADE;
-- ddl-end --
DROP TABLE IF EXISTS sturwild.declaration_newid CASCADE;
-- ddl-end --
DROP TABLE IF EXISTS sturwild.declaration_double CASCADE;
-- ddl-end --


-- [ Created objects ] --
-- object: sturwild_owner | type: ROLE --
-- DROP ROLE IF EXISTS sturwild_owner;
CREATE ROLE sturwild_owner;
-- ddl-end --

-- object: sturwild.handling | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.handling CASCADE;
CREATE TABLE sturwild.handling (
	handling_id serial NOT NULL,
	handling_name varchar NOT NULL,
	handling_exchange varchar,
	CONSTRAINT handling_pk PRIMARY KEY (handling_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.handling IS E'Types of handling used after catch';
-- ddl-end --
COMMENT ON COLUMN sturwild.handling.handling_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.handling OWNER TO sturwild_owner;
-- ddl-end --

-- object: sturwild.declaration_handling | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.declaration_handling CASCADE;
CREATE TABLE sturwild.declaration_handling (
	declaration_id integer NOT NULL,
	handling_id integer NOT NULL,
	CONSTRAINT declaration_handling_pk PRIMARY KEY (declaration_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.declaration_handling IS E'List of all handling for a declaration';
-- ddl-end --
ALTER TABLE sturwild.declaration_handling OWNER TO sturwild_owner;
-- ddl-end --

-- object: sturwild.target_species | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.target_species CASCADE;
CREATE TABLE sturwild.target_species (
	target_species_id serial NOT NULL,
	target_species_name varchar NOT NULL,
	target_species_exchange varchar,
	CONSTRAINT target_species_pk PRIMARY KEY (target_species_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.target_species IS E'List of species targeted';
-- ddl-end --
COMMENT ON COLUMN sturwild.target_species.target_species_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.target_species OWNER TO sturwild_owner;
-- ddl-end --

-- object: gear_id | type: COLUMN --
-- ALTER TABLE sturwild.declaration DROP COLUMN IF EXISTS gear_id CASCADE;
ALTER TABLE sturwild.declaration ADD COLUMN gear_id integer;
-- ddl-end --


-- object: target_species_id | type: COLUMN --
-- ALTER TABLE sturwild.declaration DROP COLUMN IF EXISTS target_species_id CASCADE;
ALTER TABLE sturwild.declaration ADD COLUMN target_species_id integer;
-- ddl-end --


-- object: status_exchange | type: COLUMN --
-- ALTER TABLE sturwild.status DROP COLUMN IF EXISTS status_exchange CASCADE;
ALTER TABLE sturwild.status ADD COLUMN status_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.status.status_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: origin_exchange | type: COLUMN --
-- ALTER TABLE sturwild.origin DROP COLUMN IF EXISTS origin_exchange CASCADE;
ALTER TABLE sturwild.origin ADD COLUMN origin_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.origin.origin_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: capture_method_exchange | type: COLUMN --
-- ALTER TABLE sturwild.capture_method DROP COLUMN IF EXISTS capture_method_exchange CASCADE;
ALTER TABLE sturwild.capture_method ADD COLUMN capture_method_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.capture_method.capture_method_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: gear_type_exchange | type: COLUMN --
-- ALTER TABLE sturwild.gear_type DROP COLUMN IF EXISTS gear_type_exchange CASCADE;
ALTER TABLE sturwild.gear_type ADD COLUMN gear_type_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.gear_type.gear_type_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: fate_exchange | type: COLUMN --
-- ALTER TABLE sturwild.fate DROP COLUMN IF EXISTS fate_exchange CASCADE;
ALTER TABLE sturwild.fate ADD COLUMN fate_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.fate.fate_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: species_exchange | type: COLUMN --
-- ALTER TABLE sturwild.species DROP COLUMN IF EXISTS species_exchange CASCADE;
ALTER TABLE sturwild.species ADD COLUMN species_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.species.species_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: environment_exchange | type: COLUMN --
-- ALTER TABLE sturwild.environment DROP COLUMN IF EXISTS environment_exchange CASCADE;
ALTER TABLE sturwild.environment ADD COLUMN environment_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.environment.environment_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: environment_detail_exchange | type: COLUMN --
-- ALTER TABLE sturwild.environment_detail DROP COLUMN IF EXISTS environment_detail_exchange CASCADE;
ALTER TABLE sturwild.environment_detail ADD COLUMN environment_detail_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.environment_detail.environment_detail_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: accuracy_exchange | type: COLUMN --
-- ALTER TABLE sturwild.accuracy DROP COLUMN IF EXISTS accuracy_exchange CASCADE;
ALTER TABLE sturwild.accuracy ADD COLUMN accuracy_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.accuracy.accuracy_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: capture_state_exchange | type: COLUMN --
-- ALTER TABLE sturwild.capture_state DROP COLUMN IF EXISTS capture_state_exchange CASCADE;
ALTER TABLE sturwild.capture_state ADD COLUMN capture_state_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.capture_state.capture_state_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: tag_presence_exchange | type: COLUMN --
-- ALTER TABLE sturwild.tag_presence DROP COLUMN IF EXISTS tag_presence_exchange CASCADE;
ALTER TABLE sturwild.tag_presence ADD COLUMN tag_presence_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.tag_presence.tag_presence_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: event_type_exchange | type: COLUMN --
-- ALTER TABLE sturwild.event_type DROP COLUMN IF EXISTS event_type_exchange CASCADE;
ALTER TABLE sturwild.event_type ADD COLUMN event_type_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.event_type.event_type_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --




-- [ Changed objects ] --
ALTER SCHEMA sturwild OWNER TO sturwild_owner;
-- ddl-end --
ALTER VIEW sturwild.v_location OWNER TO sturwild_owner;
-- ddl-end --




-- object: declaration_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration_handling DROP CONSTRAINT IF EXISTS declaration_fk CASCADE;
ALTER TABLE sturwild.declaration_handling ADD CONSTRAINT declaration_fk FOREIGN KEY (declaration_id)
REFERENCES sturwild.declaration (declaration_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: handling_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration_handling DROP CONSTRAINT IF EXISTS handling_fk CASCADE;
ALTER TABLE sturwild.declaration_handling ADD CONSTRAINT handling_fk FOREIGN KEY (handling_id)
REFERENCES sturwild.handling (handling_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: target_species_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS target_species_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT target_species_fk FOREIGN KEY (target_species_id)
REFERENCES sturwild.target_species (target_species_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

