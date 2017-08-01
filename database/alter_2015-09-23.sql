set search_path = sturwild;

CREATE TABLE mime_type
(
   mime_type_id  serial     NOT NULL,
   content_type  varchar    NOT NULL,
   extension     varchar    NOT NULL
);

-- Column mime_type_id is associated with sequence public.mime_type_mime_type_id_seq


ALTER TABLE mime_type
   ADD CONSTRAINT mime_type_pk
   PRIMARY KEY (mime_type_id);

COMMENT ON TABLE mime_type IS 'Table des types mime, pour les documents associés';
COMMENT ON COLUMN mime_type.content_type IS 'type mime officiel';
COMMENT ON COLUMN mime_type.extension IS 'Extension du fichier correspondant';
INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  1,  'application/pdf',  'pdf');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  2,  'application/zip',  'zip');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  3,  'audio/mpeg',  'mp3');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  4,  'image/jpeg',  'jpg');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES(  5,  'image/jpeg',  'jpeg');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  6,  'image/png',  'png');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  7,  'image/tiff',  'tiff');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  9,  'application/vnd.oasis.opendocument.text',  'odt');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  10,  'application/vnd.oasis.opendocument.spreadsheet',  'ods');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  11,  'application/vnd.ms-excel',  'xls');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  12,  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',  'xlsx');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  13,  'application/msword',  'doc');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  14,  'application/vnd.openxmlformats-officedocument.wordprocessingml.document',  'docx');

INSERT INTO mime_type(  mime_type_id,  content_type,  extension)
VALUES
(  8,  'text/csv',  'csv');


CREATE TABLE document
(
   document_id           serial     NOT NULL,
   mime_type_id          integer    NOT NULL,
   document_date_import  date       NOT NULL,
   document_nom          varchar    NOT NULL,
   document_description  varchar,
   data                  bytea,
   size                  integer,
   thumbnail             bytea
);

-- Column document_id is associated with sequence public.document_document_id_seq


ALTER TABLE document
   ADD CONSTRAINT document_pk
   PRIMARY KEY (document_id);

ALTER TABLE document
  ADD CONSTRAINT mime_type_document_fk FOREIGN KEY (mime_type_id)
  REFERENCES mime_type (mime_type_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

COMMENT ON TABLE document IS 'Documents numériques rattachés à un poisson ou à un événement';
COMMENT ON COLUMN document.document_nom IS 'Nom d''origine du document';
COMMENT ON COLUMN document.document_description IS 'Description libre du document';

alter table document add column individu_id integer not null;

alter table document 
add constraint individu_document_fk foreign key (individu_id)
references individu (individu_id)
on update no action
on delete no action;
