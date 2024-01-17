SET search_path=public,pg_catalog,sturwild,sturwildgacl;
-- ddl-end --


-- [ Created objects ] --
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

-- object: pgcrypto | type: EXTENSION --
-- DROP EXTENSION IF EXISTS pgcrypto CASCADE;
CREATE EXTENSION pgcrypto
WITH SCHEMA public;
-- ddl-end --

-- object: declaration_uuid | type: COLUMN --
-- ALTER TABLE sturwild.declaration DROP COLUMN IF EXISTS declaration_uuid CASCADE;
ALTER TABLE sturwild.declaration ADD COLUMN declaration_uuid uuid NOT NULL DEFAULT gen_random_uuid();
-- ddl-end --

COMMENT ON COLUMN sturwild.declaration.declaration_uuid IS E'UUID of the declaration';
-- ddl-end --

alter table sturwild.declaration ADD COLUMN origin_identifier varchar;
COMMENT ON COLUMN sturwild.declaration.origin_identifier is 'Identifier of the declaration into the origin database. Must be filled in to import declarations with fishes';

-- object: fish_uuid | type: COLUMN --
-- ALTER TABLE sturwild.fish DROP COLUMN IF EXISTS fish_uuid CASCADE;
ALTER TABLE sturwild.fish ADD COLUMN fish_uuid uuid NOT NULL DEFAULT gen_random_uuid();
-- ddl-end --

COMMENT ON COLUMN sturwild.fish.fish_uuid IS E'UUID of the fish';
-- ddl-end --


-- object: document_uuid | type: COLUMN --
-- ALTER TABLE sturwild.document DROP COLUMN IF EXISTS document_uuid CASCADE;
ALTER TABLE sturwild.document ADD COLUMN document_uuid uuid NOT NULL DEFAULT gen_random_uuid();
-- ddl-end --

COMMENT ON COLUMN sturwild.document.document_uuid IS E'UUID of the document';
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

alter table sturwild.dbparam add column dbparam_description varchar;
alter table sturwild.dbparam add column dbparam_description_en varchar;
COMMENT ON COLUMN sturwild.dbparam.dbparam_description IS E'Description of the parameter';
-- ddl-end --
COMMENT ON COLUMN sturwild.dbparam.dbparam_description_en IS E'Description of the parameter, in English';
-- ddl-end --
update sturwild.dbparam set dbparam_description = 'Code de l''institut. Ce code est utilisé pour les échanges d''informations', dbparam_description_en = 'Code of the institute. This code is used to exchange data' where dbparam_name = 'APPLI_code';
update sturwild.dbparam set dbparam_description = 'Nom de l''instance, affiché dans l''interface', dbparam_description_en = 'Instance name, displayed in the interface' where dbparam_name = 'APPLI_title';
update sturwild.dbparam set dbparam_description = 'Longitude de positionnement par défaut des cartes', dbparam_description_en = 'Default positioning longitude for maps' where dbparam_name = 'mapDefaultX';
update sturwild.dbparam set dbparam_description = 'Latitude de positionnement par défaut des cartes', dbparam_description_en = 'Default positioning latitude for maps' where dbparam_name = 'mapDefaultY';
update sturwild.dbparam set dbparam_description = 'Niveau de zoom par défaut dans les cartes', dbparam_description_en = 'Default zoom level in maps' where dbparam_name = 'mapDefaultZoom';
update sturwild.dbparam set dbparam_description = 'Nom affiché dans les applications de génération de codes uniques pour l''identification à double facteur', dbparam_description_en = 'Name displayed in applications generating unique codes for two-factor identification' where dbparam_name = 'otp_issuer';

DROP VIEW IF EXISTS sturwild.v_declaration_handlings CASCADE;
CREATE VIEW sturwild.v_declaration_handlings
AS 

select declaration_id, 
array_to_string(array_agg(handling_name order by handling_name),',') as handlings_name,
array_to_string(array_agg(handling_exchange order by handling_exchange), ',') as handlings_exchange
from sturwild.declaration_handling
join sturwild.handling using (handling_id)
group by declaration_id;
-- ddl-end --
ALTER VIEW sturwild.v_declaration_handlings OWNER TO sturwild_owner;
-- ddl-end --

 DROP VIEW IF EXISTS sturwild.v_fish_handlings CASCADE;
CREATE VIEW sturwild.v_fish_handlings
AS 

select fish_id, 
array_to_string(array_agg(handling_name order by handling_name),',') as handlings_name,
array_to_string(array_agg(handling_exchange order by handling_exchange), ',') as handlings_exchange
from sturwild.fish_handling
join sturwild.handling using (handling_id)
group by fish_id;
-- ddl-end --
ALTER VIEW sturwild.v_fish_handlings OWNER TO sturwild_owner;
-- ddl-end --

insert into sturwild.dbversion (dbversion_number, dbversion_date)
values
('24.0', '2024-01-31');