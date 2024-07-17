comment on column sturwild.dbversion.dbversion_number is E'Number of the version';
comment on column sturwild.dbversion.dbversion_date is E'Date of the version';
comment on column sturwild.declaration.declaration_id is E'Identifier of the capture';
comment on column sturwild.declaration.species_id is E'Species identifier';
comment on column sturwild.declaration.capture_date is E'Date of the capture';
comment on column sturwild.declaration.year is E'Fishing year';
comment on column sturwild.declaration.estimated_capture_date is E'Estimation of capture date';
comment on column sturwild.declaration.gear_mesh is E'Mesh size, if applicable';
comment on column sturwild.declaration.target_species is E'Species normally targeted during fishing';
comment on column sturwild.declaration.depth is E'Fishing depth, in meters';
comment on column sturwild.declaration.depth_min is E'Minimum fishing depth, in meters';
comment on column sturwild.declaration.depth_max is E'Maximum fishing depth, in meters';
comment on column sturwild.declaration.length_min is E'Minimum length, in mm';
comment on column sturwild.declaration.length_max is E'Maximum length, in mm';
comment on column sturwild.declaration.weight_min is E'Minimum weight, in kg';
comment on column sturwild.declaration.weight_max is E'Maximum weight, in kg';
comment on column sturwild.declaration.fisher_code is E'fisher’s code';
comment on column sturwild.declaration.contact is E'Other contact';
comment on column sturwild.declaration.contact_coordinates is E'Coordonates of the other contact';
comment on column sturwild.declaration.harbour_vessel is E'Home harbour of fishing vessel';
comment on column sturwild.declaration.remarks is E'General remarks';
comment on column sturwild.declaration.handling is E'Post-capture handling of the captured batch';
comment on column sturwild.declaration.identification_quality is E'0: species identification uncertain
1: identification certain';
comment on column sturwild.document.document_name is E'Original name of the document';
comment on column sturwild.document.document_description is E'Description of the document';
comment on column sturwild.species.species_id is E'Identifier of the species';
comment on column sturwild.species.species_name is E'Name of the spieces';
comment on column sturwild.event.event_remarks is E'remarks on the event';
comment on column sturwild.event.login is E'Login of the person who created the event';
comment on column sturwild.fish.declaration_id is E'Identifier of the declaration';
comment on column sturwild.fish.weight is E'weitgh of the fish caught, in grams';
comment on column sturwild.fish.handling is E'Post-capture handling';
comment on column sturwild.fish.fish_length is E'Length of the fish, in mm';
comment on column sturwild.fish.estimated_cohort is E'Estimated cohort (year of birth)';
comment on column sturwild.fish.validated_cohort is E'Validated cohort by expert opinion (year of birth)';
comment on column sturwild.fish.background is E'Background of the fish';
comment on column sturwild.fish.remarks is E'General remarks on the fish (general state, etc.)';
comment on column sturwild.fish.identification_quality is E'0: species identification uncertain
1: identification certain';
comment on column sturwild.location.longitude_gps is E'Longitude in degree, minute, second';
comment on column sturwild.location.latitude_gps is E'Latitude in degree, minute, second';
comment on column sturwild.location.longitude_declared_dd is E'Declared longitude, in decimal format';
comment on column sturwild.location.latitude_declared_dd is E'Declared latitude, in decimal format';
comment on column sturwild.location.longitude_estimated_dd is E'Estimated longitude, in decimal format';
comment on column sturwild.location.latitude_estimated_dd is E'Estimated latitude, in decimal format';
comment on column sturwild.location.longitude_dd is E'Used longitude, in decimal format';
comment on column sturwild.location.latitude_dd is E'used latitude, in decimal format';
comment on column sturwild.environment.environment_id is E'Identifier of the environment';
comment on column sturwild.environment.environment_name is E'Name of the environment';
comment on column sturwild.mime_type.content_type is E'Official mime type';
comment on column sturwild.mime_type.extension is E'File extension';
comment on column sturwild.country.country_id is E'Identifier of the country';
comment on column sturwild.country.country_order is E'Order of display in the application';
comment on column sturwild.request.body is E'Body of the request';
comment on table sturwild.capture_state is E'Table of capture status';
comment on table sturwild.capture_method is E'Method of capturing fish';
comment on table sturwild.origin is E'Origin of the capture (commercial, recreational, scientific)';
comment on table sturwild.ices is E'Table of ICES fishing zones';
comment on table sturwild.dbversion is E'Table of database versions';
comment on table sturwild.declaration is E'Information relating to the declaration';
comment on table sturwild.fate is E'Fate of sturgeon caught';
comment on table sturwild.document is E'Numeric documents relating to a fish or an event';
comment on table sturwild.gear_type is E'Table of gears';
comment on table sturwild.event_type is E'Types of possible events on a declaration';
comment on table sturwild.environment is E'Table of environment';
comment on table sturwild.environment_detail is E'Environment detail';
comment on table sturwild.mime_type is E'Table of mime types for associated documents';
comment on table sturwild.country is E'Fishing country';
comment on table sturwild.accuracy is E'Accuracy of GPS point location';
comment on table sturwild.tag_presence is E'Table of tag presence types (present, not indicated, absent)';
comment on table sturwild.status is E'Declaration status table';
