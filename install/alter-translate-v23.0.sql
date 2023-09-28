-- Diff code generated with pgModeler (PostgreSQL Database Modeler)
-- pgModeler version: 1.0.5
-- Diff date: 2023-09-27 14:56:04
-- Source model: sturwild
-- Database: sturwild
-- PostgreSQL version: 13.0

-- [ Diff summary ]
-- Dropped objects: 5
-- Created objects: 35
-- Changed objects: 72

SET search_path=public,pg_catalog,sturwild,sturwildgacl;
-- ddl-end --


-- [ Dropped objects ] --
ALTER TABLE sturwild.tag_presence DROP CONSTRAINT IF EXISTS presence_marque_pk CASCADE;
-- ddl-end --
DROP VIEW IF EXISTS sturwild.v_individu CASCADE;
-- ddl-end --
DROP TABLE IF EXISTS sturwild.estuary_area CASCADE;
-- ddl-end --
DROP TABLE IF EXISTS sturwild.declaration_newid CASCADE;
-- ddl-end --
DROP TABLE IF EXISTS sturwild.declaration_double CASCADE;
-- ddl-end --


-- [ Created objects ] --
-- object: capture_state_exchange | type: COLUMN --
-- ALTER TABLE sturwild.capture_state DROP COLUMN IF EXISTS capture_state_exchange CASCADE;
ALTER TABLE sturwild.capture_state ADD COLUMN capture_state_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.capture_state.capture_state_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: capture_method_exchange | type: COLUMN --
-- ALTER TABLE sturwild.capture_method DROP COLUMN IF EXISTS capture_method_exchange CASCADE;
ALTER TABLE sturwild.capture_method ADD COLUMN capture_method_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.capture_method.capture_method_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: origin_exchange | type: COLUMN --
-- ALTER TABLE sturwild.origin DROP COLUMN IF EXISTS origin_exchange CASCADE;
ALTER TABLE sturwild.origin ADD COLUMN origin_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.origin.origin_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: fate_exchange | type: COLUMN --
-- ALTER TABLE sturwild.fate DROP COLUMN IF EXISTS fate_exchange CASCADE;
ALTER TABLE sturwild.fate ADD COLUMN fate_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.fate.fate_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: gear_type_exchange | type: COLUMN --
-- ALTER TABLE sturwild.gear_type DROP COLUMN IF EXISTS gear_type_exchange CASCADE;
ALTER TABLE sturwild.gear_type ADD COLUMN gear_type_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.gear_type.gear_type_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: species_exchange | type: COLUMN --
-- ALTER TABLE sturwild.species DROP COLUMN IF EXISTS species_exchange CASCADE;
ALTER TABLE sturwild.species ADD COLUMN species_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.species.species_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: event_type_exchange | type: COLUMN --
-- ALTER TABLE sturwild.event_type DROP COLUMN IF EXISTS event_type_exchange CASCADE;
ALTER TABLE sturwild.event_type ADD COLUMN event_type_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.event_type.event_type_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: environment_detail_exchange | type: COLUMN --
-- ALTER TABLE sturwild.environment_detail DROP COLUMN IF EXISTS environment_detail_exchange CASCADE;
ALTER TABLE sturwild.environment_detail ADD COLUMN environment_detail_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.environment_detail.environment_detail_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: environment_exchange | type: COLUMN --
-- ALTER TABLE sturwild.environment DROP COLUMN IF EXISTS environment_exchange CASCADE;
ALTER TABLE sturwild.environment ADD COLUMN environment_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.environment.environment_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: accuracy_exchange | type: COLUMN --
-- ALTER TABLE sturwild.accuracy DROP COLUMN IF EXISTS accuracy_exchange CASCADE;
ALTER TABLE sturwild.accuracy ADD COLUMN accuracy_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.accuracy.accuracy_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: tag_presence_exchange | type: COLUMN --
-- ALTER TABLE sturwild.tag_presence DROP COLUMN IF EXISTS tag_presence_exchange CASCADE;
ALTER TABLE sturwild.tag_presence ADD COLUMN tag_presence_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.tag_presence.tag_presence_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: status_exchange | type: COLUMN --
-- ALTER TABLE sturwild.status DROP COLUMN IF EXISTS status_exchange CASCADE;
ALTER TABLE sturwild.status ADD COLUMN status_exchange varchar;
-- ddl-end --

COMMENT ON COLUMN sturwild.status.status_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --


-- object: sturwild.v_location | type: VIEW --
-- DROP VIEW IF EXISTS sturwild.v_location CASCADE;
CREATE VIEW sturwild.v_location
AS 
SELECT location.declaration_id,
    location.geom,
    location.longitude_dd,
    location.latitude_dd,
    country.country_name,
    ices.ices_name,
    environment.environment_name,
    status.status_name,
    capture_method.capture_method_name,
    origin.origin_name,
    gear_type.gear_type_name,
    capture_state.capture_state_name,
    fate.fate_name,
    species.species_name,
    declaration.capture_date,
    declaration.year,
    declaration.caught_number,
    declaration.estimated_capture_date,
    declaration.gear_mesh,
    declaration.target_species,
    declaration.depth,
    declaration.depth_min,
    declaration.depth_max,
    declaration.length_min,
    declaration.length_max,
    declaration.weight_min,
    declaration.weight_max,
    declaration.fisher_code,
    declaration.contact,
    declaration.harbour_vessel,
    declaration.declaration_mode,
    declaration.handling,
    declaration.identification_quality
   FROM sturwild.location
     JOIN sturwild.declaration USING (declaration_id)
     LEFT JOIN sturwild.status USING (status_id)
     LEFT JOIN sturwild.species USING (species_id)
     LEFT JOIN sturwild.capture_method USING (capture_method_id)
     LEFT JOIN sturwild.origin USING (origin_id)
     LEFT JOIN sturwild.gear_type USING (gear_type_id)
     LEFT JOIN sturwild.capture_state USING (capture_state_id)
     LEFT JOIN sturwild.country USING (country_id)
     LEFT JOIN sturwild.ices USING (ices_id)
     LEFT JOIN sturwild.environment USING (environment_id)
     LEFT JOIN sturwild.fate USING (fate_id);
-- ddl-end --
ALTER VIEW sturwild.v_location OWNER TO sturwild_owner;
-- ddl-end --

-- object: sturwild.handling | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.handling CASCADE;
CREATE TABLE sturwild.handling (
	handling_id serial NOT NULL,
	handling_name varchar NOT NULL,
	handling_exchange varchar,
	handling_order smallint NOT NULL DEFAULT 1,
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
	CONSTRAINT declaration_handling_pk PRIMARY KEY (declaration_id,handling_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.declaration_handling IS E'List of all handling for a declaration';
-- ddl-end --
ALTER TABLE sturwild.declaration_handling OWNER TO sturwild_owner;

-- object: sturwild.target_species | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.target_species CASCADE;
CREATE TABLE sturwild.target_species (
	target_species_id serial NOT NULL,
	target_species_name varchar NOT NULL,
	target_species_exchange varchar,
	target_species_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT target_species_pk PRIMARY KEY (target_species_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.target_species IS E'List of species targeted';
-- ddl-end --
COMMENT ON COLUMN sturwild.target_species.target_species_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.target_species OWNER TO sturwild_owner;
-- ddl-end --

-- object: target_species_id | type: COLUMN --
-- ALTER TABLE sturwild.declaration DROP COLUMN IF EXISTS target_species_id CASCADE;
ALTER TABLE sturwild.declaration ADD COLUMN target_species_id integer;
-- ddl-end --


-- object: event_type_order | type: COLUMN --
-- ALTER TABLE sturwild.event_type DROP COLUMN IF EXISTS event_type_order CASCADE;
ALTER TABLE sturwild.event_type ADD COLUMN event_type_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: capture_method_order | type: COLUMN --
-- ALTER TABLE sturwild.capture_method DROP COLUMN IF EXISTS capture_method_order CASCADE;
ALTER TABLE sturwild.capture_method ADD COLUMN capture_method_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: origin_order | type: COLUMN --
-- ALTER TABLE sturwild.origin DROP COLUMN IF EXISTS origin_order CASCADE;
ALTER TABLE sturwild.origin ADD COLUMN origin_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: fate_order | type: COLUMN --
-- ALTER TABLE sturwild.fate DROP COLUMN IF EXISTS fate_order CASCADE;
ALTER TABLE sturwild.fate ADD COLUMN fate_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: species_order | type: COLUMN --
-- ALTER TABLE sturwild.species DROP COLUMN IF EXISTS species_order CASCADE;
ALTER TABLE sturwild.species ADD COLUMN species_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: tag_presence_order | type: COLUMN --
-- ALTER TABLE sturwild.tag_presence DROP COLUMN IF EXISTS tag_presence_order CASCADE;
ALTER TABLE sturwild.tag_presence ADD COLUMN tag_presence_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: capture_state_order | type: COLUMN --
-- ALTER TABLE sturwild.capture_state DROP COLUMN IF EXISTS capture_state_order CASCADE;
ALTER TABLE sturwild.capture_state ADD COLUMN capture_state_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: status_order | type: COLUMN --
-- ALTER TABLE sturwild.status DROP COLUMN IF EXISTS status_order CASCADE;
ALTER TABLE sturwild.status ADD COLUMN status_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: environment_order | type: COLUMN --
-- ALTER TABLE sturwild.environment DROP COLUMN IF EXISTS environment_order CASCADE;
ALTER TABLE sturwild.environment ADD COLUMN environment_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: environment_detail_order | type: COLUMN --
-- ALTER TABLE sturwild.environment_detail DROP COLUMN IF EXISTS environment_detail_order CASCADE;
ALTER TABLE sturwild.environment_detail ADD COLUMN environment_detail_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: accuracy_order | type: COLUMN --
-- ALTER TABLE sturwild.accuracy DROP COLUMN IF EXISTS accuracy_order CASCADE;
ALTER TABLE sturwild.accuracy ADD COLUMN accuracy_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: gear_type_order | type: COLUMN --
-- ALTER TABLE sturwild.gear_type DROP COLUMN IF EXISTS gear_type_order CASCADE;
ALTER TABLE sturwild.gear_type ADD COLUMN gear_type_order smallint NOT NULL DEFAULT 99;
-- ddl-end --


-- [ Changed objects ] --
ALTER ROLE sturwild_owner
	NOINHERIT
	PASSWORD '';
-- ddl-end --
ALTER SCHEMA sturwild OWNER TO sturwild_owner;
-- ddl-end --

ALTER TABLE sturwild.declaration ALTER COLUMN declaration_id SET DEFAULT nextval('sturwild.declaration_declaration_id_seq'::regclass);
-- ddl-end --
ALTER TABLE sturwild.environment ALTER COLUMN environment_id SET DEFAULT nextval('sturwild.environment_environment_id_seq'::regclass);
-- ddl-end --
ALTER TABLE sturwild.country ALTER COLUMN country_id SET DEFAULT nextval('sturwild.country_country_id_seq'::regclass);
-- ddl-end --


-- [ Created constraints ] --
-- object: tag_presence_pk | type: CONSTRAINT --
-- ALTER TABLE sturwild.tag_presence DROP CONSTRAINT IF EXISTS tag_presence_pk CASCADE;
ALTER TABLE sturwild.tag_presence ADD CONSTRAINT tag_presence_pk PRIMARY KEY (tag_presence_id);
-- ddl-end --



-- [ Created foreign keys ] --
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


CREATE TABLE sturwild.fish_handling (
	fish_id integer NOT NULL,
	handling_id integer NOT NULL,
	CONSTRAINT fish_handling_pk PRIMARY KEY (fish_id,handling_id)
);
-- ddl-end --
ALTER TABLE sturwild.fish_handling OWNER TO sturwild_owner;
-- ddl-end --

-- object: fish_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.fish_handling DROP CONSTRAINT IF EXISTS fish_fk CASCADE;
ALTER TABLE sturwild.fish_handling ADD CONSTRAINT fish_fk FOREIGN KEY (fish_id)
REFERENCES sturwild.fish (fish_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: handling_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.fish_handling DROP CONSTRAINT IF EXISTS handling_fk CASCADE;
ALTER TABLE sturwild.fish_handling ADD CONSTRAINT handling_fk FOREIGN KEY (handling_id)
REFERENCES sturwild.handling (handling_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

CREATE VIEW sturwild.v_fish_handlings
AS 
select fish_id, 
array_to_string(array_agg(handling_name order by handling_name),', ') as handlings
from sturwild.fish_handling
join sturwild.handling using (handling_id)
group by fish_id;
-- ddl-end --
ALTER VIEW sturwild.v_fish_handlings OWNER TO sturwild_owner;
-- ddl-end --

-- object: sturwild.v_fish | type: VIEW --
DROP VIEW IF EXISTS sturwild.v_fish CASCADE;
CREATE VIEW sturwild.v_fish
AS 
select fish_id, declaration_id
,fate_id, fate_name
,species_id, species_name
capture_state_id, capture_state_name
,tag_presence_id, tag_presence_name
,handlings
,tag_number, fish_length, estimated_cohort, validated_cohort
,background, remarks
identification_quality_id
from sturwild.fish f
join sturwild.declaration d using(declaration_id)
left outer join sturwild.species s on  (s.species_id = f.species_id)
left outer join sturwild.capture_state using (capture_state_id)
left outer join sturwild.tag_presence using (tag_presence_id)
left outer join sturwild.v_fish_handlings using (declaration_id);
-- ddl-end --
COMMENT ON VIEW sturwild.v_fish IS E'Detail of a fish';
-- ddl-end --
ALTER VIEW sturwild.v_fish OWNER TO sturwild_owner;
-- ddl-end --
DROP VIEW IF EXISTS sturwild.v_declaration_handlings CASCADE;
CREATE VIEW sturwild.v_declaration_handlings
AS 
select declaration_id, 
array_to_string(array_agg(handling_name order by handling_name),', ') as handlings
from sturwild.declaration_handling
join sturwild.handling using (handling_id)
group by declaration_id;
-- ddl-end --
ALTER VIEW sturwild.v_declaration_handlings OWNER TO sturwild_owner;
