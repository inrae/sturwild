-- Diff code generated with pgModeler (PostgreSQL Database Modeler)
-- pgModeler version: 1.0.5
-- Diff date: 2023-09-25 16:12:26
-- Source model: sturwild
-- Database: sturwild
-- PostgreSQL version: 13.0

-- [ Diff summary ]
-- Dropped objects: 2
-- Created objects: 15
-- Changed objects: 1

SET search_path=public,pg_catalog,sturwild,sturwildgacl;
-- ddl-end --


-- [ Dropped objects ] --
DROP TABLE IF EXISTS sturwild.gear CASCADE;
-- ddl-end --
DROP SEQUENCE IF EXISTS sturwild.gear_gear_id_seq CASCADE;
-- ddl-end --
ALTER TABLE sturwild.fish rename COLUMN tag_presence_id to presence_tag_id;
-- ddl-end --




-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.event_type DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.event_type ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.capture_method DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.capture_method ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.origin DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.origin ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.fate DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.fate ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.species DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.species ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.tag_presence DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.tag_presence ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.capture_state DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.capture_state ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.handling DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.handling ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.status DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.status ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.target_species DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.target_species ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.environment DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.environment ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.environment_detail DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.environment_detail ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


-- object: "order" | type: COLUMN --
-- ALTER TABLE sturwild.accuracy DROP COLUMN IF EXISTS "order" CASCADE;
ALTER TABLE sturwild.accuracy ADD COLUMN "order" smallint NOT NULL DEFAULT 1;
-- ddl-end --


