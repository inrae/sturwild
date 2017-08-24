set search_path = 'sturwild';

CREATE SEQUENCE "dbversion_dbversion_id_seq";

CREATE TABLE "dbversion" (
                "dbversion_id" INTEGER NOT NULL DEFAULT nextval('"dbversion_dbversion_id_seq"'),
                "dbversion_number" VARCHAR NOT NULL,
                "dbversion_date" TIMESTAMP NOT NULL,
                CONSTRAINT "dbversion_pk" PRIMARY KEY ("dbversion_id")
);
COMMENT ON TABLE "dbversion" IS 'Table des versions de la base de donnees';
COMMENT ON COLUMN "dbversion"."dbversion_number" IS 'Numero de la version';
COMMENT ON COLUMN "dbversion"."dbversion_date" IS 'Date de la version';


ALTER SEQUENCE "dbversion_dbversion_id_seq" OWNED BY "dbversion"."dbversion_id";

insert into dbversion(dbversion_number, dbversion_date) values ('1.1', '2017-08-18');
