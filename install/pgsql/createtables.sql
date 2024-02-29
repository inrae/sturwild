-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.6
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: Éric Quinton


-- object: sturwild | type: SCHEMA --
-- DROP SCHEMA IF EXISTS sturwild CASCADE;
CREATE SCHEMA sturwild;
-- ddl-end --
ALTER SCHEMA sturwild OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl | type: SCHEMA --
-- DROP SCHEMA IF EXISTS sturwildgacl CASCADE;
CREATE SCHEMA sturwildgacl;
-- ddl-end --
ALTER SCHEMA sturwildgacl OWNER TO sturwild;
-- ddl-end --

SET search_path TO pg_catalog,public,sturwild,sturwildgacl;
-- ddl-end --

-- object: sturwild.capture_state_capture_state_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.capture_state_capture_state_id_seq CASCADE;
CREATE SEQUENCE sturwild.capture_state_capture_state_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.capture_state_capture_state_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.capture_state | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.capture_state CASCADE;
CREATE TABLE sturwild.capture_state (
	capture_state_id integer NOT NULL DEFAULT nextval('sturwild.capture_state_capture_state_id_seq'::regclass),
	capture_state_name character varying NOT NULL,
	capture_state_exchange varchar,
	capture_state_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT capture_etat_pk PRIMARY KEY (capture_state_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.capture_state IS E'Table des états à la capture';
-- ddl-end --
COMMENT ON COLUMN sturwild.capture_state.capture_state_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.capture_state OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.capture_method_capture_method_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.capture_method_capture_method_id_seq CASCADE;
CREATE SEQUENCE sturwild.capture_method_capture_method_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.capture_method_capture_method_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.capture_method | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.capture_method CASCADE;
CREATE TABLE sturwild.capture_method (
	capture_method_id integer NOT NULL DEFAULT nextval('sturwild.capture_method_capture_method_id_seq'::regclass),
	capture_method_name character varying NOT NULL,
	capture_method_exchange varchar,
	capture_method_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT capture_mode_pk PRIMARY KEY (capture_method_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.capture_method IS E'Mode de capture des poissons';
-- ddl-end --
COMMENT ON COLUMN sturwild.capture_method.capture_method_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.capture_method OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.origin_origin_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.origin_origin_id_seq CASCADE;
CREATE SEQUENCE sturwild.origin_origin_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.origin_origin_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.origin | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.origin CASCADE;
CREATE TABLE sturwild.origin (
	origin_id integer NOT NULL DEFAULT nextval('sturwild.origin_origin_id_seq'::regclass),
	origin_name character varying NOT NULL,
	origin_exchange varchar,
	origin_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT capture_type_pk PRIMARY KEY (origin_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.origin IS E'Type de capture (professionnelle, amateur, scientifique...)';
-- ddl-end --
COMMENT ON COLUMN sturwild.origin.origin_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.origin OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.ices_ices_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.ices_ices_id_seq CASCADE;
CREATE SEQUENCE sturwild.ices_ices_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.ices_ices_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.ices | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.ices CASCADE;
CREATE TABLE sturwild.ices (
	ices_id integer NOT NULL DEFAULT nextval('sturwild.ices_ices_id_seq'::regclass),
	ices_name character varying NOT NULL,
	CONSTRAINT ciem_pk PRIMARY KEY (ices_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.ices IS E'Table des zones de peche CIEM';
-- ddl-end --
ALTER TABLE sturwild.ices OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.dbparam_dbparam_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.dbparam_dbparam_id_seq CASCADE;
CREATE SEQUENCE sturwild.dbparam_dbparam_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.dbparam_dbparam_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.dbparam | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.dbparam CASCADE;
CREATE TABLE sturwild.dbparam (
	dbparam_id integer NOT NULL DEFAULT nextval('sturwild.dbparam_dbparam_id_seq'::regclass),
	dbparam_name character varying NOT NULL,
	dbparam_value character varying,
	CONSTRAINT dbparam_pk PRIMARY KEY (dbparam_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.dbparam IS E'Table of parameters intrinsically associated to the instance';
-- ddl-end --
COMMENT ON COLUMN sturwild.dbparam.dbparam_name IS E'Name of the parameter';
-- ddl-end --
COMMENT ON COLUMN sturwild.dbparam.dbparam_value IS E'Value of the parameter';
-- ddl-end --
ALTER TABLE sturwild.dbparam OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwild.dbparam (dbparam_name, dbparam_value) VALUES (E'APPLI_code', E'sturwild');
-- ddl-end --
INSERT INTO sturwild.dbparam (dbparam_name, dbparam_value) VALUES (E'APPLI_title', E'STURWILD');
-- ddl-end --
INSERT INTO sturwild.dbparam (dbparam_name, dbparam_value) VALUES (E'mapDefaultX', E'-0.70');
-- ddl-end --
INSERT INTO sturwild.dbparam (dbparam_name, dbparam_value) VALUES (E'mapDefaultY', E'44.77');
-- ddl-end --
INSERT INTO sturwild.dbparam (dbparam_name, dbparam_value) VALUES (E'mapDefaultZoom', E'7');
-- ddl-end --
INSERT INTO sturwild.dbparam (dbparam_name, dbparam_value) VALUES (E'otp_issuer', E'sturwild.society.com');
-- ddl-end --

-- object: sturwild.dbversion_dbversion_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.dbversion_dbversion_id_seq CASCADE;
CREATE SEQUENCE sturwild.dbversion_dbversion_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.dbversion_dbversion_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.dbversion | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.dbversion CASCADE;
CREATE TABLE sturwild.dbversion (
	dbversion_id integer NOT NULL DEFAULT nextval('sturwild.dbversion_dbversion_id_seq'::regclass),
	dbversion_number character varying NOT NULL,
	dbversion_date timestamp NOT NULL,
	CONSTRAINT dbversion_pk PRIMARY KEY (dbversion_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.dbversion IS E'Table des versions de la base de donnees';
-- ddl-end --
COMMENT ON COLUMN sturwild.dbversion.dbversion_number IS E'Numero de la version';
-- ddl-end --
COMMENT ON COLUMN sturwild.dbversion.dbversion_date IS E'Date de la version';
-- ddl-end --
ALTER TABLE sturwild.dbversion OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwild.dbversion (dbversion_number, dbversion_date) VALUES (E'24.0', E'2024-02-05');
-- ddl-end --

-- object: sturwild.declaration_declaration_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.declaration_declaration_id_seq CASCADE;
CREATE SEQUENCE sturwild.declaration_declaration_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.declaration_declaration_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.declaration | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.declaration CASCADE;
CREATE TABLE sturwild.declaration (
	declaration_id integer NOT NULL DEFAULT nextval('sturwild.declaration_declaration_id_seq'::regclass),
	status_id integer NOT NULL,
	capture_method_id integer,
	origin_id integer NOT NULL,
	gear_type_id integer,
	species_id integer,
	capture_state_id integer,
	fate_id integer,
	capture_date timestamp,
	year integer NOT NULL,
	caught_number integer NOT NULL DEFAULT 1,
	estimated_capture_date character varying,
	gear_mesh character varying,
	target_species character varying,
	depth real,
	depth_min real,
	depth_max real,
	length_min real,
	length_max real,
	weight_min real,
	weight_max real,
	fisher_code character varying,
	contact character varying,
	contact_coordinates character varying,
	harbour_vessel character varying,
	declaration_mode character varying,
	remarks character varying,
	handling character varying,
	identification_quality smallint NOT NULL DEFAULT 1,
	declaration_uuid uuid NOT NULL DEFAULT gen_random_uuid(),
	origin_identifier varchar,
	target_species_id integer,
	institute_id integer,
	CONSTRAINT capture_id PRIMARY KEY (declaration_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.declaration IS E'Informations liées à la déclaration.';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.declaration_id IS E'Identifiant de la capture.';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.species_id IS E'Identifiant de l''espèce';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.capture_date IS E'Date de capture.';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.year IS E'Année de pêche';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.caught_number IS E'Nombre d''individu capturés';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.estimated_capture_date IS E'Estimation de la date de capture.';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.gear_mesh IS E'Maille du filet, le cas échéant';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.target_species IS E'Espece normalement ciblée lors de la pêche.';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.depth IS E'Profondeur de pêche, en mètres';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.depth_min IS E'Profondeur minimum de pêche, en mètres';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.depth_max IS E'Profondeur maximale de pêche, en mètres';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.length_min IS E'longueur totale minimale, en mm';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.length_max IS E'Longueur totale maximale, en mm';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.weight_min IS E'Masse minimale en kg';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.weight_max IS E'Masse maximale en kg';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.fisher_code IS E'Code du pêcheur';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.contact IS E'Autre interlocuteur';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.contact_coordinates IS E'Coordonnées de l''autre interlocuteur';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.harbour_vessel IS E'Port d''attache du navire de pêche';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.remarks IS E'Observations générales';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.handling IS E'Manipulation post-capture du lot capturé';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.identification_quality IS E'0 : identification de l''espèce incertaine\n1 : identification sûre';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.declaration_uuid IS E'UUID of the declaration';
-- ddl-end --
COMMENT ON COLUMN sturwild.declaration.origin_identifier IS E'Identifier of the declaration into the origin database. Must be filled in to import declarations with fishes';
-- ddl-end --
ALTER TABLE sturwild.declaration OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.fate_fate_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.fate_fate_id_seq CASCADE;
CREATE SEQUENCE sturwild.fate_fate_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.fate_fate_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.fate | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.fate CASCADE;
CREATE TABLE sturwild.fate (
	fate_id integer NOT NULL DEFAULT nextval('sturwild.fate_fate_id_seq'::regclass),
	fate_name character varying NOT NULL,
	fate_exchange varchar,
	fate_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT devenir_pk PRIMARY KEY (fate_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.fate IS E'Devenir des esturgeons capturés';
-- ddl-end --
COMMENT ON COLUMN sturwild.fate.fate_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.fate OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.document_document_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.document_document_id_seq CASCADE;
CREATE SEQUENCE sturwild.document_document_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.document_document_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.document | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.document CASCADE;
CREATE TABLE sturwild.document (
	document_id integer NOT NULL DEFAULT nextval('sturwild.document_document_id_seq'::regclass),
	mime_type_id integer NOT NULL,
	document_date_import date NOT NULL,
	document_name character varying NOT NULL,
	document_description character varying,
	data bytea,
	size integer,
	thumbnail bytea,
	fish_id integer NOT NULL,
	document_uuid uuid NOT NULL DEFAULT gen_random_uuid(),
	CONSTRAINT document_pk PRIMARY KEY (document_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.document IS E'Documents numériques rattachés à un poisson ou à un événement';
-- ddl-end --
COMMENT ON COLUMN sturwild.document.document_name IS E'Nom d''origine du document';
-- ddl-end --
COMMENT ON COLUMN sturwild.document.document_description IS E'Description libre du document';
-- ddl-end --
COMMENT ON COLUMN sturwild.document.document_uuid IS E'UUID of the document';
-- ddl-end --
ALTER TABLE sturwild.document OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.gear_type_gear_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.gear_type_gear_type_id_seq CASCADE;
CREATE SEQUENCE sturwild.gear_type_gear_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.gear_type_gear_type_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.gear_type | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.gear_type CASCADE;
CREATE TABLE sturwild.gear_type (
	gear_type_id integer NOT NULL DEFAULT nextval('sturwild.gear_type_gear_type_id_seq'::regclass),
	gear_type_name character varying NOT NULL,
	gear_type_exchange varchar,
	gear_type_order smallint NOT NULL DEFAULT 99,
	CONSTRAINT engin_type_pk PRIMARY KEY (gear_type_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.gear_type IS E'Table des engins utilisés';
-- ddl-end --
COMMENT ON COLUMN sturwild.gear_type.gear_type_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.gear_type OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.species_species_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.species_species_id_seq CASCADE;
CREATE SEQUENCE sturwild.species_species_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.species_species_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.species | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.species CASCADE;
CREATE TABLE sturwild.species (
	species_id integer NOT NULL DEFAULT nextval('sturwild.species_species_id_seq'::regclass),
	species_name character varying,
	species_exchange varchar,
	species_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT espece_id PRIMARY KEY (species_id)
);
-- ddl-end --
COMMENT ON COLUMN sturwild.species.species_id IS E'Identifiant de l''espèce';
-- ddl-end --
COMMENT ON COLUMN sturwild.species.species_name IS E'Nom complet de l''espèce.';
-- ddl-end --
COMMENT ON COLUMN sturwild.species.species_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.species OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.estuaire_area_id_0_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.estuaire_area_id_0_seq CASCADE;
CREATE SEQUENCE sturwild.estuaire_area_id_0_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.estuaire_area_id_0_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.event_event_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.event_event_id_seq CASCADE;
CREATE SEQUENCE sturwild.event_event_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.event_event_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.event | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.event CASCADE;
CREATE TABLE sturwild.event (
	event_id integer NOT NULL DEFAULT nextval('sturwild.event_event_id_seq'::regclass),
	declaration_id integer,
	event_type_id integer NOT NULL,
	event_date timestamp,
	event_remarks character varying,
	login character varying,
	CONSTRAINT evenement_id PRIMARY KEY (event_id)
);
-- ddl-end --
COMMENT ON COLUMN sturwild.event.event_remarks IS E'Commentaire général sur l''événement';
-- ddl-end --
COMMENT ON COLUMN sturwild.event.login IS E'Login de la personne ayant créé l''événement';
-- ddl-end --
ALTER TABLE sturwild.event OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.event_type_event_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.event_type_event_type_id_seq CASCADE;
CREATE SEQUENCE sturwild.event_type_event_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.event_type_event_type_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.event_type | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.event_type CASCADE;
CREATE TABLE sturwild.event_type (
	event_type_id integer NOT NULL DEFAULT nextval('sturwild.event_type_event_type_id_seq'::regclass),
	event_type_name character varying NOT NULL,
	event_type_exchange varchar,
	event_type_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT evenement_type_pk PRIMARY KEY (event_type_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.event_type IS E'Types d''événements possibles sur une déclaration';
-- ddl-end --
COMMENT ON COLUMN sturwild.event_type.event_type_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.event_type OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.fish_fish_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.fish_fish_id_seq CASCADE;
CREATE SEQUENCE sturwild.fish_fish_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.fish_fish_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.fish | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.fish CASCADE;
CREATE TABLE sturwild.fish (
	fish_id integer NOT NULL DEFAULT nextval('sturwild.fish_fish_id_seq'::regclass),
	declaration_id integer NOT NULL,
	species_id integer,
	tag_presence_id integer,
	capture_state_id integer,
	fate_id integer,
	weight real,
	handling character varying,
	tag_number character varying,
	fish_length integer,
	estimated_cohort character varying,
	validated_cohort smallint,
	background character varying,
	remarks character varying,
	identification_quality smallint NOT NULL DEFAULT 1,
	fish_uuid uuid NOT NULL DEFAULT gen_random_uuid(),
	CONSTRAINT individu_id PRIMARY KEY (fish_id)
);
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.declaration_id IS E'Identifiant de la capture.';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.weight IS E'Masse du poisson capturé, en grammes';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.handling IS E'Manipulation post-capture';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.estimated_cohort IS E'Cohorte estimée (année de naissance)';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.validated_cohort IS E'Cohorte validée par expertise (année de naissance)';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.background IS E'Historique du poisson';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.remarks IS E'Commentaire général sur le poisson (état général, etc.)';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.identification_quality IS E'0 : identification incertaine\n1 : identification sûre';
-- ddl-end --
COMMENT ON COLUMN sturwild.fish.fish_uuid IS E'UUID of the fish';
-- ddl-end --
ALTER TABLE sturwild.fish OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.location | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.location CASCADE;
CREATE TABLE sturwild.location (
	declaration_id integer NOT NULL,
	country_id integer,
	ices_id integer,
	region_id integer,
	environment_id integer,
	environment_detail_id integer,
	area_detail character varying,
	longitude_gps character varying,
	latitude_gps character varying,
	longitude_declared_dd double precision,
	latitude_declared_dd double precision,
	longitude_estimated_dd double precision,
	latitude_estimated_dd double precision,
	longitude_dd double precision,
	latitude_dd double precision,
	geom geometry(POINT, 4326),
	accuracy_id integer,
	CONSTRAINT localisation_id PRIMARY KEY (declaration_id)
);
-- ddl-end --
COMMENT ON COLUMN sturwild.location.area_detail IS E'Détail de la zone de pêche';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.longitude_gps IS E'Longitude au format degré, minute, seconde';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.latitude_gps IS E'Latitude au format degré, minute, seconde';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.longitude_declared_dd IS E'Longitude déclarée, au format décimal';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.latitude_declared_dd IS E'Latitude déclarée, au format décimal';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.longitude_estimated_dd IS E'Longitude estimée, au format décimal';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.latitude_estimated_dd IS E'Latitude estimée, au format décimal';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.longitude_dd IS E'Longitude utilisée, au format décimal';
-- ddl-end --
COMMENT ON COLUMN sturwild.location.latitude_dd IS E'Latitude utilisée, au format décimal';
-- ddl-end --
ALTER TABLE sturwild.location OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.environment_environment_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.environment_environment_id_seq CASCADE;
CREATE SEQUENCE sturwild.environment_environment_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.environment_environment_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.environment_detail_environment_detail_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.environment_detail_environment_detail_id_seq CASCADE;
CREATE SEQUENCE sturwild.environment_detail_environment_detail_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.environment_detail_environment_detail_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.environment_detail | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.environment_detail CASCADE;
CREATE TABLE sturwild.environment_detail (
	environment_detail_id integer NOT NULL DEFAULT nextval('sturwild.environment_detail_environment_detail_id_seq'::regclass),
	environment_detail_name character varying NOT NULL,
	environment_detail_exchange varchar,
	environment_detail_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT milieu_detail_pk PRIMARY KEY (environment_detail_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.environment_detail IS E'Milieu détaillé';
-- ddl-end --
COMMENT ON COLUMN sturwild.environment_detail.environment_detail_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.environment_detail OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.environment | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.environment CASCADE;
CREATE TABLE sturwild.environment (
	environment_id integer NOT NULL DEFAULT nextval('sturwild.environment_environment_id_seq'::regclass),
	environment_name character varying NOT NULL,
	environment_exchange varchar,
	environment_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT milieu_id PRIMARY KEY (environment_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.environment IS E'Table des milieux';
-- ddl-end --
COMMENT ON COLUMN sturwild.environment.environment_id IS E'Identifiant du milieu';
-- ddl-end --
COMMENT ON COLUMN sturwild.environment.environment_name IS E'Nom du milieu';
-- ddl-end --
COMMENT ON COLUMN sturwild.environment.environment_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.environment OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.mime_type_mime_type_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.mime_type_mime_type_id_seq CASCADE;
CREATE SEQUENCE sturwild.mime_type_mime_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.mime_type_mime_type_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.mime_type | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.mime_type CASCADE;
CREATE TABLE sturwild.mime_type (
	mime_type_id integer NOT NULL DEFAULT nextval('sturwild.mime_type_mime_type_id_seq'::regclass),
	content_type character varying NOT NULL,
	extension character varying NOT NULL,
	CONSTRAINT mime_type_pk PRIMARY KEY (mime_type_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.mime_type IS E'Table des types mime, pour les documents associés';
-- ddl-end --
COMMENT ON COLUMN sturwild.mime_type.content_type IS E'type mime officiel';
-- ddl-end --
COMMENT ON COLUMN sturwild.mime_type.extension IS E'Extension du fichier correspondant';
-- ddl-end --
ALTER TABLE sturwild.mime_type OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.country_country_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.country_country_id_seq CASCADE;
CREATE SEQUENCE sturwild.country_country_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.country_country_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.country | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.country CASCADE;
CREATE TABLE sturwild.country (
	country_id integer NOT NULL DEFAULT nextval('sturwild.country_country_id_seq'::regclass),
	country_name character varying NOT NULL,
	country_exchange varchar,
	country_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT pays_id PRIMARY KEY (country_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.country IS E'Pays de pêche';
-- ddl-end --
COMMENT ON COLUMN sturwild.country.country_id IS E'Identifiant du pays';
-- ddl-end --
ALTER TABLE sturwild.country OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.accuracy_accuracy_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.accuracy_accuracy_id_seq CASCADE;
CREATE SEQUENCE sturwild.accuracy_accuracy_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.accuracy_accuracy_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.accuracy | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.accuracy CASCADE;
CREATE TABLE sturwild.accuracy (
	accuracy_id integer NOT NULL DEFAULT nextval('sturwild.accuracy_accuracy_id_seq'::regclass),
	accuracy_name character varying NOT NULL,
	accuracy_exchange varchar,
	accuracy_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT precision_pk PRIMARY KEY (accuracy_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.accuracy IS E'Précision de la localisation du point GPS';
-- ddl-end --
COMMENT ON COLUMN sturwild.accuracy.accuracy_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.accuracy OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.tag_presence_tag_presence_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.tag_presence_tag_presence_id_seq CASCADE;
CREATE SEQUENCE sturwild.tag_presence_tag_presence_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.tag_presence_tag_presence_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.tag_presence | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.tag_presence CASCADE;
CREATE TABLE sturwild.tag_presence (
	tag_presence_id integer NOT NULL DEFAULT nextval('sturwild.tag_presence_tag_presence_id_seq'::regclass),
	tag_presence_name character varying NOT NULL,
	tag_presence_exchange varchar,
	tag_presence_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT tag_presence_pk PRIMARY KEY (tag_presence_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.tag_presence IS E'Table des types de présence de marque (présent, non signalé, absent)';
-- ddl-end --
COMMENT ON COLUMN sturwild.tag_presence.tag_presence_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.tag_presence OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.request_request_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.request_request_id_seq CASCADE;
CREATE SEQUENCE sturwild.request_request_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.request_request_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.request | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.request CASCADE;
CREATE TABLE sturwild.request (
	request_id integer NOT NULL DEFAULT nextval('sturwild.request_request_id_seq'::regclass),
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
ALTER TABLE sturwild.request OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.status_status_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwild.status_status_id_seq CASCADE;
CREATE SEQUENCE sturwild.status_status_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwild.status_status_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.status | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.status CASCADE;
CREATE TABLE sturwild.status (
	status_id integer NOT NULL DEFAULT nextval('sturwild.status_status_id_seq'::regclass),
	status_name character varying NOT NULL,
	status_exchange varchar,
	status_order smallint NOT NULL DEFAULT 1,
	CONSTRAINT statut_pk PRIMARY KEY (status_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.status IS E'Table des statuts de la déclaration';
-- ddl-end --
COMMENT ON COLUMN sturwild.status.status_exchange IS E'Name in english to exchange data between instances of Sturwild';
-- ddl-end --
ALTER TABLE sturwild.status OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.aclacl | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.aclacl CASCADE;
CREATE TABLE sturwildgacl.aclacl (
	aclaco_id integer NOT NULL,
	aclgroup_id integer NOT NULL,
	CONSTRAINT aclacl_pk PRIMARY KEY (aclaco_id,aclgroup_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.aclacl IS E'Table des droits attribués';
-- ddl-end --
ALTER TABLE sturwildgacl.aclacl OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwildgacl.aclacl (aclaco_id, aclgroup_id) VALUES (E'1', E'1');
-- ddl-end --
INSERT INTO sturwildgacl.aclacl (aclaco_id, aclgroup_id) VALUES (E'2', E'2');
-- ddl-end --
INSERT INTO sturwildgacl.aclacl (aclaco_id, aclgroup_id) VALUES (E'3', E'3');
-- ddl-end --
INSERT INTO sturwildgacl.aclacl (aclaco_id, aclgroup_id) VALUES (E'4', E'4');
-- ddl-end --

-- object: sturwildgacl.aclaco_aclaco_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwildgacl.aclaco_aclaco_id_seq CASCADE;
CREATE SEQUENCE sturwildgacl.aclaco_aclaco_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwildgacl.aclaco_aclaco_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.aclaco | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.aclaco CASCADE;
CREATE TABLE sturwildgacl.aclaco (
	aclaco_id integer NOT NULL DEFAULT nextval('sturwildgacl.aclaco_aclaco_id_seq'::regclass),
	aclappli_id integer NOT NULL,
	aco character varying NOT NULL,
	CONSTRAINT aclaco_pk PRIMARY KEY (aclaco_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.aclaco IS E'Table des droits gérés';
-- ddl-end --
ALTER TABLE sturwildgacl.aclaco OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwildgacl.aclaco (aclappli_id, aco) VALUES (E'1', E'admin');
-- ddl-end --
INSERT INTO sturwildgacl.aclaco (aclappli_id, aco) VALUES (E'1', E'consult');
-- ddl-end --
INSERT INTO sturwildgacl.aclaco (aclappli_id, aco) VALUES (E'1', E'gestion');
-- ddl-end --
INSERT INTO sturwildgacl.aclaco (aclappli_id, aco) VALUES (E'1', E'param');
-- ddl-end --

-- object: sturwildgacl.aclappli_aclappli_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwildgacl.aclappli_aclappli_id_seq CASCADE;
CREATE SEQUENCE sturwildgacl.aclappli_aclappli_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwildgacl.aclappli_aclappli_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.aclappli | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.aclappli CASCADE;
CREATE TABLE sturwildgacl.aclappli (
	aclappli_id integer NOT NULL DEFAULT nextval('sturwildgacl.aclappli_aclappli_id_seq'::regclass),
	appli character varying NOT NULL,
	applidetail character varying,
	CONSTRAINT aclappli_pk PRIMARY KEY (aclappli_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.aclappli IS E'Table des applications gérées';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.aclappli.appli IS E'Nom de l''application pour la gestion des droits';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.aclappli.applidetail IS E'Description de l''application';
-- ddl-end --
ALTER TABLE sturwildgacl.aclappli OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwildgacl.aclappli (aclappli_id, appli, applidetail) VALUES (E'1', E'sturwild', DEFAULT);
-- ddl-end --

-- object: sturwildgacl.aclgroup_aclgroup_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwildgacl.aclgroup_aclgroup_id_seq CASCADE;
CREATE SEQUENCE sturwildgacl.aclgroup_aclgroup_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwildgacl.aclgroup_aclgroup_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.aclgroup | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.aclgroup CASCADE;
CREATE TABLE sturwildgacl.aclgroup (
	aclgroup_id integer NOT NULL DEFAULT nextval('sturwildgacl.aclgroup_aclgroup_id_seq'::regclass),
	groupe character varying NOT NULL,
	aclgroup_id_parent integer,
	CONSTRAINT aclgroup_pk PRIMARY KEY (aclgroup_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.aclgroup IS E'Groupes des logins';
-- ddl-end --
ALTER TABLE sturwildgacl.aclgroup OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwildgacl.aclgroup (groupe, aclgroup_id_parent) VALUES (E'admin', DEFAULT);
-- ddl-end --
INSERT INTO sturwildgacl.aclgroup (groupe, aclgroup_id_parent) VALUES (E'consult', DEFAULT);
-- ddl-end --
INSERT INTO sturwildgacl.aclgroup (groupe, aclgroup_id_parent) VALUES (E'gestion', E'2');
-- ddl-end --
INSERT INTO sturwildgacl.aclgroup (groupe, aclgroup_id_parent) VALUES (E'param', E'3');
-- ddl-end --

-- object: sturwildgacl.acllogin_acllogin_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwildgacl.acllogin_acllogin_id_seq CASCADE;
CREATE SEQUENCE sturwildgacl.acllogin_acllogin_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwildgacl.acllogin_acllogin_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.acllogin | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.acllogin CASCADE;
CREATE TABLE sturwildgacl.acllogin (
	acllogin_id integer NOT NULL DEFAULT nextval('sturwildgacl.acllogin_acllogin_id_seq'::regclass),
	login character varying NOT NULL,
	logindetail character varying NOT NULL,
	totp_key character varying,
	CONSTRAINT acllogin_pk PRIMARY KEY (acllogin_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.acllogin IS E'Table des logins des utilisateurs autorisés';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.acllogin.logindetail IS E'Nom affiché';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.acllogin.totp_key IS E'TOTP secret key for the user';
-- ddl-end --
ALTER TABLE sturwildgacl.acllogin OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwildgacl.acllogin (login, logindetail, totp_key) VALUES (E'admin', E'admin', DEFAULT);
-- ddl-end --

-- object: sturwildgacl.acllogingroup | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.acllogingroup CASCADE;
CREATE TABLE sturwildgacl.acllogingroup (
	acllogin_id integer NOT NULL,
	aclgroup_id integer NOT NULL,
	CONSTRAINT acllogingroup_pk PRIMARY KEY (acllogin_id,aclgroup_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.acllogingroup IS E'Table des relations entre les logins et les groupes';
-- ddl-end --
ALTER TABLE sturwildgacl.acllogingroup OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwildgacl.acllogingroup (acllogin_id, aclgroup_id) VALUES (E'1', E'1');
-- ddl-end --
INSERT INTO sturwildgacl.acllogingroup (acllogin_id, aclgroup_id) VALUES (E'1', E'4');
-- ddl-end --

-- object: sturwildgacl.log_log_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwildgacl.log_log_id_seq CASCADE;
CREATE SEQUENCE sturwildgacl.log_log_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwildgacl.log_log_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.log | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.log CASCADE;
CREATE TABLE sturwildgacl.log (
	log_id integer NOT NULL DEFAULT nextval('sturwildgacl.log_log_id_seq'::regclass),
	login character varying(32) NOT NULL,
	nom_module character varying,
	log_date timestamp NOT NULL,
	commentaire character varying,
	ipaddress character varying,
	CONSTRAINT log_pk PRIMARY KEY (log_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.log IS E'Liste des connexions ou des actions enregistrées';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.log.log_date IS E'Heure de connexion';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.log.commentaire IS E'Donnees complementaires enregistrees';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.log.ipaddress IS E'Adresse IP du client';
-- ddl-end --
ALTER TABLE sturwildgacl.log OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.seq_logingestion_id | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwildgacl.seq_logingestion_id CASCADE;
CREATE SEQUENCE sturwildgacl.seq_logingestion_id
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwildgacl.seq_logingestion_id OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.logingestion | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.logingestion CASCADE;
CREATE TABLE sturwildgacl.logingestion (
	id integer NOT NULL DEFAULT nextval('sturwildgacl.seq_logingestion_id'::regclass),
	login character varying(32) NOT NULL,
	password character varying(255),
	nom character varying(32),
	prenom character varying(32),
	mail character varying(255),
	datemodif timestamp,
	actif smallint DEFAULT 1,
	is_expired boolean DEFAULT false,
	is_clientws boolean DEFAULT false,
	tokenws character varying,
	nbattempts smallint DEFAULT 0,
	lastattempt timestamp,
	CONSTRAINT pk_logingestion PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.logingestion.nbattempts IS E'Number of connection attempts';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.logingestion.lastattempt IS E'last attempt of connection';
-- ddl-end --
ALTER TABLE sturwildgacl.logingestion OWNER TO sturwild;
-- ddl-end --

INSERT INTO sturwildgacl.logingestion (login, password, nom, prenom, mail, datemodif, actif, is_expired, is_clientws, tokenws, nbattempts, lastattempt) VALUES (E'admin', E'cd916028a2d8a1b901e831246dd5b9b4d3832786ddc63bbf5af4b50d9fc98f50', E'admin', DEFAULT, DEFAULT, DEFAULT, E'1', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
-- ddl-end --

-- object: sturwildgacl.passwordlost_passwordlost_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS sturwildgacl.passwordlost_passwordlost_id_seq CASCADE;
CREATE SEQUENCE sturwildgacl.passwordlost_passwordlost_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE sturwildgacl.passwordlost_passwordlost_id_seq OWNER TO sturwild;
-- ddl-end --

-- object: sturwildgacl.passwordlost | type: TABLE --
-- DROP TABLE IF EXISTS sturwildgacl.passwordlost CASCADE;
CREATE TABLE sturwildgacl.passwordlost (
	passwordlost_id integer NOT NULL DEFAULT nextval('sturwildgacl.passwordlost_passwordlost_id_seq'::regclass),
	id integer NOT NULL,
	token character varying NOT NULL,
	expiration timestamp NOT NULL,
	usedate timestamp,
	CONSTRAINT passwordlost_pk PRIMARY KEY (passwordlost_id)
);
-- ddl-end --
COMMENT ON TABLE sturwildgacl.passwordlost IS E'Table de suivi des pertes de mots de passe';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.passwordlost.token IS E'Jeton utilise pour le renouvellement';
-- ddl-end --
COMMENT ON COLUMN sturwildgacl.passwordlost.expiration IS E'Date d''expiration du jeton';
-- ddl-end --
ALTER TABLE sturwildgacl.passwordlost OWNER TO sturwild;
-- ddl-end --

-- object: log_commentaire_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwildgacl.log_commentaire_idx CASCADE;
CREATE INDEX log_commentaire_idx ON sturwildgacl.log
USING btree
(
	commentaire
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: log_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwildgacl.log_date_idx CASCADE;
CREATE INDEX log_date_idx ON sturwildgacl.log
USING btree
(
	log_date
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: log_ip_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwildgacl.log_ip_idx CASCADE;
CREATE INDEX log_ip_idx ON sturwildgacl.log
USING btree
(
	ipaddress
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: log_login_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwildgacl.log_login_idx CASCADE;
CREATE INDEX log_login_idx ON sturwildgacl.log
USING btree
(
	login
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: logingestion_login_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwildgacl.logingestion_login_idx CASCADE;
CREATE UNIQUE INDEX logingestion_login_idx ON sturwildgacl.logingestion
USING btree
(
	login
)
WITH (FILLFACTOR = 90);
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
ALTER VIEW sturwild.v_location OWNER TO sturwild;
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
ALTER TABLE sturwild.handling OWNER TO sturwild;
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
ALTER TABLE sturwild.declaration_handling OWNER TO sturwild;
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
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

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
ALTER TABLE sturwild.target_species OWNER TO sturwild;
-- ddl-end --

-- object: target_species_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS target_species_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT target_species_fk FOREIGN KEY (target_species_id)
REFERENCES sturwild.target_species (target_species_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: sturwild.v_declaration_handlings | type: VIEW --
-- DROP VIEW IF EXISTS sturwild.v_declaration_handlings CASCADE;
CREATE VIEW sturwild.v_declaration_handlings
AS 

select declaration_id, 
array_to_string(array_agg(handling_name order by handling_name),',') as handlings_name,
array_to_string(array_agg(handling_exchange order by handling_exchange), ',') as handlings_exchange
from sturwild.declaration_handling
join sturwild.handling using (handling_id)
group by declaration_id;
-- ddl-end --
ALTER VIEW sturwild.v_declaration_handlings OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.fish_handling | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.fish_handling CASCADE;
CREATE TABLE sturwild.fish_handling (
	fish_id integer NOT NULL,
	handling_id integer NOT NULL,
	CONSTRAINT fish_handling_pk PRIMARY KEY (fish_id,handling_id)
);
-- ddl-end --
ALTER TABLE sturwild.fish_handling OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.v_fish_handlings | type: VIEW --
-- DROP VIEW IF EXISTS sturwild.v_fish_handlings CASCADE;
CREATE VIEW sturwild.v_fish_handlings
AS 

select fish_id, 
array_to_string(array_agg(handling_name order by handling_name),',') as handlings_name,
array_to_string(array_agg(handling_exchange order by handling_exchange), ',') as handlings_exchange
from sturwild.fish_handling
join sturwild.handling using (handling_id)
group by fish_id;
-- ddl-end --
ALTER VIEW sturwild.v_fish_handlings OWNER TO sturwild;
-- ddl-end --

-- object: sturwild.v_fish | type: VIEW --
-- DROP VIEW IF EXISTS sturwild.v_fish CASCADE;
CREATE VIEW sturwild.v_fish
AS 

select fish_id, declaration_id
,f.fate_id, fate_name
,f.species_id, species_name
,f.capture_state_id, capture_state_name
,tag_presence_id, tag_presence_name
,handlings
,tag_number, fish_length, estimated_cohort, validated_cohort
,background, f.remarks
identification_quality_id
from sturwild.fish f
join sturwild.declaration d using(declaration_id)
left outer join sturwild.species s on  (s.species_id = f.species_id)
left outer join sturwild.capture_state cs on (cs.capture_state_id = f.capture_state_id)
left outer join sturwild.tag_presence using (tag_presence_id)
left outer join sturwild.fate fa on (fa.fate_id = f.fate_id)
left outer join sturwild.v_fish_handlings using (fish_id);
-- ddl-end --
COMMENT ON VIEW sturwild.v_fish IS E'Detail of a fish';
-- ddl-end --
ALTER VIEW sturwild.v_fish OWNER TO sturwild;
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

-- object: declaration_uid_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwild.declaration_uid_idx CASCADE;
CREATE INDEX declaration_uid_idx ON sturwild.declaration
USING btree
(
	declaration_uuid
);
-- ddl-end --

-- object: fish_uuid_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwild.fish_uuid_idx CASCADE;
CREATE INDEX fish_uuid_idx ON sturwild.fish
USING btree
(
	fish_uuid
);
-- ddl-end --

-- object: document_uuid_idx | type: INDEX --
-- DROP INDEX IF EXISTS sturwild.document_uuid_idx CASCADE;
CREATE INDEX document_uuid_idx ON sturwild.document
USING btree
(
	document_uuid
);
-- ddl-end --

-- object: sturwild.institute | type: TABLE --
-- DROP TABLE IF EXISTS sturwild.institute CASCADE;
CREATE TABLE sturwild.institute (
	institute_id serial NOT NULL,
	institute_code varchar NOT NULL,
	institute_description varchar,
	CONSTRAINT institute_pk PRIMARY KEY (institute_id)
);
-- ddl-end --
COMMENT ON TABLE sturwild.institute IS E'List of institute partners';
-- ddl-end --
COMMENT ON COLUMN sturwild.institute.institute_code IS E'Code of the institute';
-- ddl-end --
COMMENT ON COLUMN sturwild.institute.institute_description IS E'Description of the institute';
-- ddl-end --
ALTER TABLE sturwild.institute OWNER TO sturwild;
-- ddl-end --

-- object: institute_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS institute_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT institute_fk FOREIGN KEY (institute_id)
REFERENCES sturwild.institute (institute_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: capture_etat_declaration_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS capture_etat_declaration_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT capture_etat_declaration_fk FOREIGN KEY (capture_state_id)
REFERENCES sturwild.capture_state (capture_state_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: capture_mode_capture_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS capture_mode_capture_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT capture_mode_capture_fk FOREIGN KEY (capture_method_id)
REFERENCES sturwild.capture_method (capture_method_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: capture_type_capture_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS capture_type_capture_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT capture_type_capture_fk FOREIGN KEY (origin_id)
REFERENCES sturwild.origin (origin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: devenir_declaration_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS devenir_declaration_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT devenir_declaration_fk FOREIGN KEY (fate_id)
REFERENCES sturwild.fate (fate_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: engin_type_declaration_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS engin_type_declaration_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT engin_type_declaration_fk FOREIGN KEY (gear_type_id)
REFERENCES sturwild.gear_type (gear_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: espece_declaration_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS espece_declaration_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT espece_declaration_fk FOREIGN KEY (species_id)
REFERENCES sturwild.species (species_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: statut_declaration_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.declaration DROP CONSTRAINT IF EXISTS statut_declaration_fk CASCADE;
ALTER TABLE sturwild.declaration ADD CONSTRAINT statut_declaration_fk FOREIGN KEY (status_id)
REFERENCES sturwild.status (status_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: individu_document_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.document DROP CONSTRAINT IF EXISTS individu_document_fk CASCADE;
ALTER TABLE sturwild.document ADD CONSTRAINT individu_document_fk FOREIGN KEY (fish_id)
REFERENCES sturwild.fish (fish_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: mime_type_document_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.document DROP CONSTRAINT IF EXISTS mime_type_document_fk CASCADE;
ALTER TABLE sturwild.document ADD CONSTRAINT mime_type_document_fk FOREIGN KEY (mime_type_id)
REFERENCES sturwild.mime_type (mime_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_capture_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.event DROP CONSTRAINT IF EXISTS evenement_capture_fk CASCADE;
ALTER TABLE sturwild.event ADD CONSTRAINT evenement_capture_fk FOREIGN KEY (declaration_id)
REFERENCES sturwild.declaration (declaration_id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: evenement_type_evenement_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.event DROP CONSTRAINT IF EXISTS evenement_type_evenement_fk CASCADE;
ALTER TABLE sturwild.event ADD CONSTRAINT evenement_type_evenement_fk FOREIGN KEY (event_type_id)
REFERENCES sturwild.event_type (event_type_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: capture_etat_individu_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.fish DROP CONSTRAINT IF EXISTS capture_etat_individu_fk CASCADE;
ALTER TABLE sturwild.fish ADD CONSTRAINT capture_etat_individu_fk FOREIGN KEY (capture_state_id)
REFERENCES sturwild.capture_state (capture_state_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: capture_individu_fk1 | type: CONSTRAINT --
-- ALTER TABLE sturwild.fish DROP CONSTRAINT IF EXISTS capture_individu_fk1 CASCADE;
ALTER TABLE sturwild.fish ADD CONSTRAINT capture_individu_fk1 FOREIGN KEY (declaration_id)
REFERENCES sturwild.declaration (declaration_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: devenir_individu_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.fish DROP CONSTRAINT IF EXISTS devenir_individu_fk CASCADE;
ALTER TABLE sturwild.fish ADD CONSTRAINT devenir_individu_fk FOREIGN KEY (fate_id)
REFERENCES sturwild.fate (fate_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: espece_individu_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.fish DROP CONSTRAINT IF EXISTS espece_individu_fk CASCADE;
ALTER TABLE sturwild.fish ADD CONSTRAINT espece_individu_fk FOREIGN KEY (species_id)
REFERENCES sturwild.species (species_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: presence_marque_individu_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.fish DROP CONSTRAINT IF EXISTS presence_marque_individu_fk CASCADE;
ALTER TABLE sturwild.fish ADD CONSTRAINT presence_marque_individu_fk FOREIGN KEY (tag_presence_id)
REFERENCES sturwild.tag_presence (tag_presence_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: ciem_localisation_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.location DROP CONSTRAINT IF EXISTS ciem_localisation_fk CASCADE;
ALTER TABLE sturwild.location ADD CONSTRAINT ciem_localisation_fk FOREIGN KEY (ices_id)
REFERENCES sturwild.ices (ices_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: declaration_localisation_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.location DROP CONSTRAINT IF EXISTS declaration_localisation_fk CASCADE;
ALTER TABLE sturwild.location ADD CONSTRAINT declaration_localisation_fk FOREIGN KEY (declaration_id)
REFERENCES sturwild.declaration (declaration_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: milieu_detail_localisation_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.location DROP CONSTRAINT IF EXISTS milieu_detail_localisation_fk CASCADE;
ALTER TABLE sturwild.location ADD CONSTRAINT milieu_detail_localisation_fk FOREIGN KEY (environment_detail_id)
REFERENCES sturwild.environment_detail (environment_detail_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: milieu_localisation_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.location DROP CONSTRAINT IF EXISTS milieu_localisation_fk CASCADE;
ALTER TABLE sturwild.location ADD CONSTRAINT milieu_localisation_fk FOREIGN KEY (environment_id)
REFERENCES sturwild.environment (environment_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: pays_localisation_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.location DROP CONSTRAINT IF EXISTS pays_localisation_fk CASCADE;
ALTER TABLE sturwild.location ADD CONSTRAINT pays_localisation_fk FOREIGN KEY (country_id)
REFERENCES sturwild.country (country_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: precision_fk | type: CONSTRAINT --
-- ALTER TABLE sturwild.location DROP CONSTRAINT IF EXISTS precision_fk CASCADE;
ALTER TABLE sturwild.location ADD CONSTRAINT precision_fk FOREIGN KEY (accuracy_id)
REFERENCES sturwild.accuracy (accuracy_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE DEFERRABLE INITIALLY IMMEDIATE;
-- ddl-end --

-- object: aclaco_aclacl_fk | type: CONSTRAINT --
-- ALTER TABLE sturwildgacl.aclacl DROP CONSTRAINT IF EXISTS aclaco_aclacl_fk CASCADE;
ALTER TABLE sturwildgacl.aclacl ADD CONSTRAINT aclaco_aclacl_fk FOREIGN KEY (aclaco_id)
REFERENCES sturwildgacl.aclaco (aclaco_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclgroup_aclacl_fk | type: CONSTRAINT --
-- ALTER TABLE sturwildgacl.aclacl DROP CONSTRAINT IF EXISTS aclgroup_aclacl_fk CASCADE;
ALTER TABLE sturwildgacl.aclacl ADD CONSTRAINT aclgroup_aclacl_fk FOREIGN KEY (aclgroup_id)
REFERENCES sturwildgacl.aclgroup (aclgroup_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclappli_aclaco_fk | type: CONSTRAINT --
-- ALTER TABLE sturwildgacl.aclaco DROP CONSTRAINT IF EXISTS aclappli_aclaco_fk CASCADE;
ALTER TABLE sturwildgacl.aclaco ADD CONSTRAINT aclappli_aclaco_fk FOREIGN KEY (aclappli_id)
REFERENCES sturwildgacl.aclappli (aclappli_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclgroup_aclgroup_fk | type: CONSTRAINT --
-- ALTER TABLE sturwildgacl.aclgroup DROP CONSTRAINT IF EXISTS aclgroup_aclgroup_fk CASCADE;
ALTER TABLE sturwildgacl.aclgroup ADD CONSTRAINT aclgroup_aclgroup_fk FOREIGN KEY (aclgroup_id_parent)
REFERENCES sturwildgacl.aclgroup (aclgroup_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: aclgroup_acllogingroup_fk | type: CONSTRAINT --
-- ALTER TABLE sturwildgacl.acllogingroup DROP CONSTRAINT IF EXISTS aclgroup_acllogingroup_fk CASCADE;
ALTER TABLE sturwildgacl.acllogingroup ADD CONSTRAINT aclgroup_acllogingroup_fk FOREIGN KEY (aclgroup_id)
REFERENCES sturwildgacl.aclgroup (aclgroup_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: acllogin_acllogingroup_fk | type: CONSTRAINT --
-- ALTER TABLE sturwildgacl.acllogingroup DROP CONSTRAINT IF EXISTS acllogin_acllogingroup_fk CASCADE;
ALTER TABLE sturwildgacl.acllogingroup ADD CONSTRAINT acllogin_acllogingroup_fk FOREIGN KEY (acllogin_id)
REFERENCES sturwildgacl.acllogin (acllogin_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: logingestion_passwordlost_fk | type: CONSTRAINT --
-- ALTER TABLE sturwildgacl.passwordlost DROP CONSTRAINT IF EXISTS logingestion_passwordlost_fk CASCADE;
ALTER TABLE sturwildgacl.passwordlost ADD CONSTRAINT logingestion_passwordlost_fk FOREIGN KEY (id)
REFERENCES sturwildgacl.logingestion (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

INSERT INTO sturwild.mime_type (content_type,"extension") VALUES
	 ('application/pdf','pdf'),
	 ('application/zip','zip'),
	 ('audio/mpeg','mp3'),
	 ('image/jpeg','jpg'),
	 ('image/jpeg','jpeg'),
	 ('image/png','png'),
	 ('image/tiff','tiff'),
	 ('application/vnd.oasis.opendocument.text','odt'),
	 ('application/vnd.oasis.opendocument.spreadsheet','ods'),
	 ('application/vnd.ms-excel','xls');
INSERT INTO sturwild.mime_type (content_type,"extension") VALUES
	 ('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','xlsx'),
	 ('application/msword','doc'),
	 ('application/vnd.openxmlformats-officedocument.wordprocessingml.document','docx'),
	 ('text/csv','csv'),
	 ('video/mp4','mp4'),
	 ('video/x-msvideo','avi'),
	 ('video/3gpp','3gp'),
	 ('video/x-ms-wmv','wmv'),
	 ('video/MP2T','ts'),
	 ('video/quicktime','mov');
