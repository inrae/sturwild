-- Diff code generated with pgModeler (PostgreSQL Database Modeler)
-- pgModeler version: 1.0.5
-- Diff date: 2023-09-25 16:35:46
-- Source model: sturwild
-- Database: sturwild
-- PostgreSQL version: 13.0

-- [ Diff summary ]
-- Dropped objects: 0
-- Created objects: 15
-- Changed objects: 1

SET search_path=public,pg_catalog,sturwild,sturwildgacl;
-- ddl-end --


-- [ Dropped objects ] --
ALTER TABLE sturwild.capture_state DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.capture_method DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.origin DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.fate DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.species DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.event_type DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.environment_detail DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.environment DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.accuracy DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.tag_presence DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.status DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.handling DROP COLUMN IF EXISTS "order" CASCADE;
-- ddl-end --
ALTER TABLE sturwild.target_species DROP COLUMN IF EXISTS "order" CASCADE;
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


-- object: handling_order | type: COLUMN --
-- ALTER TABLE sturwild.handling DROP COLUMN IF EXISTS handling_order CASCADE;
ALTER TABLE sturwild.handling ADD COLUMN handling_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: status_order | type: COLUMN --
-- ALTER TABLE sturwild.status DROP COLUMN IF EXISTS status_order CASCADE;
ALTER TABLE sturwild.status ADD COLUMN status_order smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: target_species_order | type: COLUMN --
-- ALTER TABLE sturwild.target_species DROP COLUMN IF EXISTS target_species_order CASCADE;
ALTER TABLE sturwild.target_species ADD COLUMN target_species_order smallint NOT NULL DEFAULT 1;
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
ALTER TABLE sturwild.gear_type ADD COLUMN gear_type_order smallint NOT NULL DEFAULT 1;
-- ddl-end --




-- [ Changed objects ] --
ALTER ROLE sturwild_owner
	NOINHERIT
	PASSWORD '';
-- ddl-end --
