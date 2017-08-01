select setval('sturwild.mime_type_mime_type_id_seq', (select max(mime_type_id) from sturwild.mime_type));
insert into sturwild.mime_type (content_type, extension) values
('video/mp4','mp4'),
('video/x-msvideo','avi'),
('video/3gpp','3gp'),
('video/x-ms-wmv','wmv'),
('video/MP2T','ts');

insert into sturwild.mime_type (content_type, extension) values ('video/quicktime','mov');
