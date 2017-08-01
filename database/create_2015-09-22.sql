create schema sturwild;

CREATE SEQUENCE sturio.sturwild.capture_etat_capture_etat_id_seq;

CREATE TABLE sturio.sturwild.capture_etat (
                capture_etat_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.capture_etat_capture_etat_id_seq'),
                capture_etat_libelle VARCHAR NOT NULL,
                CONSTRAINT capture_etat_pk PRIMARY KEY (capture_etat_id)
);
COMMENT ON TABLE sturio.sturwild.capture_etat IS 'Table des états à la capture';


ALTER SEQUENCE sturio.sturwild.capture_etat_capture_etat_id_seq OWNED BY sturio.sturwild.capture_etat.capture_etat_id;

CREATE SEQUENCE sturio.sturwild.capture_mode_capture_mode_id_seq;

CREATE TABLE sturio.sturwild.capture_mode (
                capture_mode_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.capture_mode_capture_mode_id_seq'),
                capture_mode_libelle VARCHAR NOT NULL,
                CONSTRAINT capture_mode_pk PRIMARY KEY (capture_mode_id)
);
COMMENT ON TABLE sturio.sturwild.capture_mode IS 'Mode de capture des poissons';


ALTER SEQUENCE sturio.sturwild.capture_mode_capture_mode_id_seq OWNED BY sturio.sturwild.capture_mode.capture_mode_id;

CREATE SEQUENCE sturio.sturwild.capture_type_capture_type_id_seq;

CREATE TABLE sturio.sturwild.capture_type (
                capture_type_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.capture_type_capture_type_id_seq'),
                capture_type_libelle VARCHAR NOT NULL,
                CONSTRAINT capture_type_pk PRIMARY KEY (capture_type_id)
);
COMMENT ON TABLE sturio.sturwild.capture_type IS 'Type de capture (professionnelle, amateur, scientifique...)';


ALTER SEQUENCE sturio.sturwild.capture_type_capture_type_id_seq OWNED BY sturio.sturwild.capture_type.capture_type_id;

CREATE SEQUENCE sturio.sturwild.ciem_ciem_id_seq;

CREATE TABLE sturio.sturwild.ciem (
                ciem_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.ciem_ciem_id_seq'),
                ciem_libelle VARCHAR NOT NULL,
                CONSTRAINT ciem_pk PRIMARY KEY (ciem_id)
);
COMMENT ON TABLE sturio.sturwild.ciem IS 'Table des zones de peche CIEM';


ALTER SEQUENCE sturio.sturwild.ciem_ciem_id_seq OWNED BY sturio.sturwild.ciem.ciem_id;

CREATE SEQUENCE sturio.sturwild.declaration_declaration_id_seq;

CREATE TABLE sturio.sturwild.declaration (
                declaration_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.declaration_declaration_id_seq'),
                statut_id INTEGER NOT NULL,
                capture_mode_id INTEGER DEFAULT 1,
                capture_type_id INTEGER NOT NULL,
                engin_type_id INTEGER,
                espece_id INTEGER,
                capture_etat_id INTEGER,
                devenir_id INTEGER,
                capture_date TIMESTAMP,
                annee INTEGER NOT NULL,
                nombre_capture INTEGER DEFAULT 1 NOT NULL,
                capture_date_estimee VARCHAR,
                engin_maille VARCHAR,
                espece_ciblee VARCHAR,
                profondeur REAL,
                prof_min REAL,
                prof_max REAL,
                lt_min REAL,
                lt_max REAL,
                masse_min REAL,
                masse_max REAL,
                pecheur_code VARCHAR,
                interlocuteur VARCHAR,
                interlocuteur_coord VARCHAR,
                navire_port VARCHAR,
                declaration_mode VARCHAR,
                observation VARCHAR,
                manipulation VARCHAR,
                qualite_identification SMALLINT DEFAULT 1 NOT NULL,
                CONSTRAINT capture_id PRIMARY KEY (declaration_id)
);
COMMENT ON TABLE sturio.sturwild.declaration IS 'Informations liées à la déclaration.';
COMMENT ON COLUMN sturio.sturwild.declaration.declaration_id IS 'Identifiant de la capture.';
COMMENT ON COLUMN sturio.sturwild.declaration.espece_id IS 'Identifiant de l''espèce';
COMMENT ON COLUMN sturio.sturwild.declaration.capture_date IS 'Date de capture.';
COMMENT ON COLUMN sturio.sturwild.declaration.annee IS 'Année de pêche';
COMMENT ON COLUMN sturio.sturwild.declaration.nombre_capture IS 'Nombre d''individu capturés';
COMMENT ON COLUMN sturio.sturwild.declaration.capture_date_estimee IS 'Estimation de la date de capture.';
COMMENT ON COLUMN sturio.sturwild.declaration.engin_maille IS 'Maille du filet, le cas échéant';
COMMENT ON COLUMN sturio.sturwild.declaration.espece_ciblee IS 'Espece normalement ciblée lors de la pêche.';
COMMENT ON COLUMN sturio.sturwild.declaration.profondeur IS 'Profondeur de pêche, en mètres';
COMMENT ON COLUMN sturio.sturwild.declaration.prof_min IS 'Profondeur minimum de pêche, en mètres';
COMMENT ON COLUMN sturio.sturwild.declaration.prof_max IS 'Profondeur maximale de pêche, en mètres';
COMMENT ON COLUMN sturio.sturwild.declaration.lt_min IS 'longueur totale minimale, en mm';
COMMENT ON COLUMN sturio.sturwild.declaration.lt_max IS 'Longueur totale maximale, en mm';
COMMENT ON COLUMN sturio.sturwild.declaration.masse_min IS 'Masse minimale en kg';
COMMENT ON COLUMN sturio.sturwild.declaration.masse_max IS 'Masse maximale en kg';
COMMENT ON COLUMN sturio.sturwild.declaration.pecheur_code IS 'Code du pêcheur';
COMMENT ON COLUMN sturio.sturwild.declaration.interlocuteur IS 'Autre interlocuteur';
COMMENT ON COLUMN sturio.sturwild.declaration.interlocuteur_coord IS 'Coordonnées de l''autre interlocuteur';
COMMENT ON COLUMN sturio.sturwild.declaration.navire_port IS 'Port d''attache du navire de pêche';
COMMENT ON COLUMN sturio.sturwild.declaration.observation IS 'Observations générales';
COMMENT ON COLUMN sturio.sturwild.declaration.manipulation IS 'Manipulation post-capture du lot capturé';
COMMENT ON COLUMN sturio.sturwild.declaration.qualite_identification IS '0 : identification de l''espèce incertaine
1 : identification sûre';


ALTER SEQUENCE sturio.sturwild.declaration_declaration_id_seq OWNED BY sturio.sturwild.declaration.declaration_id;

CREATE SEQUENCE sturio.sturwild.devenir_devenir_id_seq;

CREATE TABLE sturio.sturwild.devenir (
                devenir_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.devenir_devenir_id_seq'),
                devenir_libelle VARCHAR NOT NULL,
                CONSTRAINT devenir_pk PRIMARY KEY (devenir_id)
);
COMMENT ON TABLE sturio.sturwild.devenir IS 'Devenir des esturgeons capturés';


ALTER SEQUENCE sturio.sturwild.devenir_devenir_id_seq OWNED BY sturio.sturwild.devenir.devenir_id;

CREATE SEQUENCE sturio.sturwild.engin_type_engin_type_id_seq;

CREATE TABLE sturio.sturwild.engin_type (
                engin_type_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.engin_type_engin_type_id_seq'),
                engin_type_libelle VARCHAR NOT NULL,
                CONSTRAINT engin_type_pk PRIMARY KEY (engin_type_id)
);
COMMENT ON TABLE sturio.sturwild.engin_type IS 'Table des engins utilisés';


ALTER SEQUENCE sturio.sturwild.engin_type_engin_type_id_seq OWNED BY sturio.sturwild.engin_type.engin_type_id;

CREATE SEQUENCE sturio.sturwild.espece_espece_id_seq;

CREATE TABLE sturio.sturwild.espece (
                espece_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.espece_espece_id_seq'),
                espece_libelle VARCHAR,
                CONSTRAINT espece_id PRIMARY KEY (espece_id)
);
COMMENT ON COLUMN sturio.sturwild.espece.espece_id IS 'Identifiant de l''espèce';
COMMENT ON COLUMN sturio.sturwild.espece.espece_libelle IS 'Nom complet de l''espèce.';


ALTER SEQUENCE sturio.sturwild.espece_espece_id_seq OWNED BY sturio.sturwild.espece.espece_id;

CREATE SEQUENCE sturio.sturwild.evenement_evenement_id_seq;

CREATE TABLE sturio.sturwild.evenement (
                evenement_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.evenement_evenement_id_seq'),
                declaration_id INTEGER,
                evenement_type_id INTEGER NOT NULL,
                evenement_date TIMESTAMP,
                evenement_commentaire VARCHAR,
                login VARCHAR,
                CONSTRAINT evenement_id PRIMARY KEY (evenement_id)
);
COMMENT ON COLUMN sturio.sturwild.evenement.evenement_commentaire IS 'Commentaire général sur l''événement';
COMMENT ON COLUMN sturio.sturwild.evenement.login IS 'Login de la personne ayant créé l''événement';


ALTER SEQUENCE sturio.sturwild.evenement_evenement_id_seq OWNED BY sturio.sturwild.evenement.evenement_id;

CREATE SEQUENCE sturio.sturwild.evenement_type_evenement_type_id_seq;

CREATE TABLE sturio.sturwild.evenement_type (
                evenement_type_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.evenement_type_evenement_type_id_seq'),
                evenement_type_libelle VARCHAR NOT NULL,
                CONSTRAINT evenement_type_pk PRIMARY KEY (evenement_type_id)
);
COMMENT ON TABLE sturio.sturwild.evenement_type IS 'Types d''événements possibles sur une déclaration';


ALTER SEQUENCE sturio.sturwild.evenement_type_evenement_type_id_seq OWNED BY sturio.sturwild.evenement_type.evenement_type_id;

CREATE SEQUENCE sturio.sturwild.individu_individu_id_seq;

CREATE TABLE sturio.sturwild.individu (
                individu_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.individu_individu_id_seq'),
                declaration_id INTEGER NOT NULL,
                espece_id INTEGER,
                presence_marque_id INTEGER,
                capture_etat_id INTEGER,
                devenir_id INTEGER,
                masse REAL,
                manipulation VARCHAR,
                numero_marque VARCHAR,
                longueur_individu INTEGER,
                cohorte_estimee VARCHAR,
                cohorte_validee SMALLINT,
                historique VARCHAR,
                commentaire VARCHAR,
                qualite_identification SMALLINT DEFAULT 1 NOT NULL,
                CONSTRAINT individu_id PRIMARY KEY (individu_id)
);
COMMENT ON COLUMN sturio.sturwild.individu.declaration_id IS 'Identifiant de la capture.';
COMMENT ON COLUMN sturio.sturwild.individu.masse IS 'Masse du poisson capturé, en grammes';
COMMENT ON COLUMN sturio.sturwild.individu.manipulation IS 'Manipulation post-capture';
COMMENT ON COLUMN sturio.sturwild.individu.cohorte_estimee IS 'Cohorte estimée (année de naissance)';
COMMENT ON COLUMN sturio.sturwild.individu.cohorte_validee IS 'Cohorte validée par expertise (année de naissance)';
COMMENT ON COLUMN sturio.sturwild.individu.historique IS 'Historique du poisson';
COMMENT ON COLUMN sturio.sturwild.individu.commentaire IS 'Commentaire général sur le poisson (état général, etc.)';
COMMENT ON COLUMN sturio.sturwild.individu.qualite_identification IS '0 : identification incertaine
1 : identification sûre';


ALTER SEQUENCE sturio.sturwild.individu_individu_id_seq OWNED BY sturio.sturwild.individu.individu_id;

CREATE TABLE sturio.sturwild.localisation (
                declaration_id INTEGER NOT NULL,
                pays_id INTEGER,
                ciem_id INTEGER,
                region_id INTEGER,
                milieu_id INTEGER,
                milieu_detail_id INTEGER,
                zone_detail VARCHAR,
                longitude_gps VARCHAR,
                latitude_gps VARCHAR,
                longitude_declaree_dd DOUBLE PRECISION,
                latitude_declaree_dd DOUBLE PRECISION,
                longitude_estimee_dd DOUBLE PRECISION,
                latitude_estimee_dd DOUBLE PRECISION,
                longitude_dd DOUBLE PRECISION,
                latitude_dd DOUBLE PRECISION,
                CONSTRAINT localisation_id PRIMARY KEY (declaration_id)
);
COMMENT ON COLUMN sturio.sturwild.localisation.zone_detail IS 'Détail de la zone de pêche';
COMMENT ON COLUMN sturio.sturwild.localisation.longitude_gps IS 'Longitude au format degré, minute, seconde';
COMMENT ON COLUMN sturio.sturwild.localisation.latitude_gps IS 'Latitude au format degré, minute, seconde';
COMMENT ON COLUMN sturio.sturwild.localisation.longitude_declaree_dd IS 'Longitude déclarée, au format décimal';
COMMENT ON COLUMN sturio.sturwild.localisation.latitude_declaree_dd IS 'Latitude déclarée, au format décimal';
COMMENT ON COLUMN sturio.sturwild.localisation.longitude_estimee_dd IS 'Longitude estimée, au format décimal';
COMMENT ON COLUMN sturio.sturwild.localisation.latitude_estimee_dd IS 'Latitude estimée, au format décimal';
COMMENT ON COLUMN sturio.sturwild.localisation.longitude_dd IS 'Longitude utilisée, au format décimal';
COMMENT ON COLUMN sturio.sturwild.localisation.latitude_dd IS 'Latitude utilisée, au format décimal';
SELECT AddGeometryColumn ('sturwild', 'localisation', 'geom', 4326, 'POINT', 2 );

CREATE SEQUENCE sturio.sturwild.milieu_milieu_id_seq;

CREATE TABLE sturio.sturwild.milieu (
                milieu_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.milieu_milieu_id_seq'),
                milieu_libelle VARCHAR NOT NULL,
                CONSTRAINT milieu_id PRIMARY KEY (milieu_id)
);
COMMENT ON TABLE sturio.sturwild.milieu IS 'Table des milieux';
COMMENT ON COLUMN sturio.sturwild.milieu.milieu_id IS 'Identifiant du milieu';
COMMENT ON COLUMN sturio.sturwild.milieu.milieu_libelle IS 'Nom du milieu';


ALTER SEQUENCE sturio.sturwild.milieu_milieu_id_seq OWNED BY sturio.sturwild.milieu.milieu_id;

CREATE SEQUENCE sturio.sturwild.milieu_detail_milieu_detail_id_seq;

CREATE TABLE sturio.sturwild.milieu_detail (
                milieu_detail_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.milieu_detail_milieu_detail_id_seq'),
                milieu_detail_libelle VARCHAR NOT NULL,
                CONSTRAINT milieu_detail_pk PRIMARY KEY (milieu_detail_id)
);
COMMENT ON TABLE sturio.sturwild.milieu_detail IS 'Milieu détaillé';


ALTER SEQUENCE sturio.sturwild.milieu_detail_milieu_detail_id_seq OWNED BY sturio.sturwild.milieu_detail.milieu_detail_id;

CREATE SEQUENCE sturio.sturwild.pays_pays_id_seq;

CREATE TABLE sturio.sturwild.pays (
                pays_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.pays_pays_id_seq'),
                pays_libelle VARCHAR NOT NULL,
                pays_order SMALLINT DEFAULT 1 NOT NULL,
                CONSTRAINT pays_id PRIMARY KEY (pays_id)
);
COMMENT ON TABLE sturio.sturwild.pays IS 'Pays de pêche';
COMMENT ON COLUMN sturio.sturwild.pays.pays_id IS 'Identifiant du pays';


ALTER SEQUENCE sturio.sturwild.pays_pays_id_seq OWNED BY sturio.sturwild.pays.pays_id;

CREATE SEQUENCE sturio.sturwild.presence_marque_presence_marque_id_seq;

CREATE TABLE sturio.sturwild.presence_marque (
                presence_marque_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.presence_marque_presence_marque_id_seq'),
                presence_marque_libelle VARCHAR NOT NULL,
                CONSTRAINT presence_marque_pk PRIMARY KEY (presence_marque_id)
);
COMMENT ON TABLE sturio.sturwild.presence_marque IS 'Table des types de présence de marque (présent, non signalé, absent)';


ALTER SEQUENCE sturio.sturwild.presence_marque_presence_marque_id_seq OWNED BY sturio.sturwild.presence_marque.presence_marque_id;

CREATE SEQUENCE sturio.sturwild.region_region_id_seq;

CREATE TABLE sturio.sturwild.region (
                region_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.region_region_id_seq'),
                region_libelle VARCHAR NOT NULL,
                CONSTRAINT region_id PRIMARY KEY (region_id)
);
COMMENT ON TABLE sturio.sturwild.region IS 'Grande région de pêche';
COMMENT ON COLUMN sturio.sturwild.region.region_id IS 'Identifiant de la région';


ALTER SEQUENCE sturio.sturwild.region_region_id_seq OWNED BY sturio.sturwild.region.region_id;

CREATE SEQUENCE sturio.sturwild.statut_statut_id_seq;

CREATE TABLE sturio.sturwild.statut (
                statut_id INTEGER NOT NULL DEFAULT nextval('sturio.sturwild.statut_statut_id_seq'),
                statut_libelle VARCHAR NOT NULL,
                CONSTRAINT statut_pk PRIMARY KEY (statut_id)
);
COMMENT ON TABLE sturio.sturwild.statut IS 'Table des statuts de la déclaration';


ALTER SEQUENCE sturio.sturwild.statut_statut_id_seq OWNED BY sturio.sturwild.statut.statut_id;

ALTER TABLE sturio.sturwild.declaration ADD CONSTRAINT capture_etat_declaration_fk
FOREIGN KEY (capture_etat_id)
REFERENCES sturio.sturwild.capture_etat (capture_etat_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.individu ADD CONSTRAINT capture_etat_individu_fk
FOREIGN KEY (capture_etat_id)
REFERENCES sturio.sturwild.capture_etat (capture_etat_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.declaration ADD CONSTRAINT capture_mode_capture_fk
FOREIGN KEY (capture_mode_id)
REFERENCES sturio.sturwild.capture_mode (capture_mode_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.declaration ADD CONSTRAINT capture_type_capture_fk
FOREIGN KEY (capture_type_id)
REFERENCES sturio.sturwild.capture_type (capture_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.localisation ADD CONSTRAINT ciem_localisation_fk
FOREIGN KEY (ciem_id)
REFERENCES sturio.sturwild.ciem (ciem_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.evenement ADD CONSTRAINT evenement_capture_fk
FOREIGN KEY (declaration_id)
REFERENCES sturio.sturwild.declaration (declaration_id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.individu ADD CONSTRAINT capture_individu_fk1
FOREIGN KEY (declaration_id)
REFERENCES sturio.sturwild.declaration (declaration_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.localisation ADD CONSTRAINT declaration_localisation_fk
FOREIGN KEY (declaration_id)
REFERENCES sturio.sturwild.declaration (declaration_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.declaration ADD CONSTRAINT devenir_declaration_fk
FOREIGN KEY (devenir_id)
REFERENCES sturio.sturwild.devenir (devenir_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.individu ADD CONSTRAINT devenir_individu_fk
FOREIGN KEY (devenir_id)
REFERENCES sturio.sturwild.devenir (devenir_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.declaration ADD CONSTRAINT engin_type_declaration_fk
FOREIGN KEY (engin_type_id)
REFERENCES sturio.sturwild.engin_type (engin_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.declaration ADD CONSTRAINT espece_declaration_fk
FOREIGN KEY (espece_id)
REFERENCES sturio.sturwild.espece (espece_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.individu ADD CONSTRAINT espece_individu_fk
FOREIGN KEY (espece_id)
REFERENCES sturio.sturwild.espece (espece_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.evenement ADD CONSTRAINT evenement_type_evenement_fk
FOREIGN KEY (evenement_type_id)
REFERENCES sturio.sturwild.evenement_type (evenement_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.localisation ADD CONSTRAINT milieu_localisation_fk
FOREIGN KEY (milieu_id)
REFERENCES sturio.sturwild.milieu (milieu_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.localisation ADD CONSTRAINT milieu_detail_localisation_fk
FOREIGN KEY (milieu_detail_id)
REFERENCES sturio.sturwild.milieu_detail (milieu_detail_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.localisation ADD CONSTRAINT pays_localisation_fk
FOREIGN KEY (pays_id)
REFERENCES sturio.sturwild.pays (pays_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.individu ADD CONSTRAINT presence_marque_individu_fk
FOREIGN KEY (presence_marque_id)
REFERENCES sturio.sturwild.presence_marque (presence_marque_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.localisation ADD CONSTRAINT region_localisation_fk
FOREIGN KEY (region_id)
REFERENCES sturio.sturwild.region (region_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE sturio.sturwild.declaration ADD CONSTRAINT statut_declaration_fk
FOREIGN KEY (statut_id)
REFERENCES sturio.sturwild.statut (statut_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
