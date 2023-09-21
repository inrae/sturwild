drop view sturwild.v_localisation;
drop table sturwild.region cascade;


alter table sturwild.capture_etat rename column capture_etat_id to capture_state_id;
alter table sturwild.capture_etat rename column capture_etat_libelle to capture_state_name;
alter table sturwild.capture_mode rename column capture_mode_id to capture_method_id;
alter table sturwild.capture_mode rename column capture_mode_libelle to capture_method_name;
alter table sturwild.capture_type rename column capture_type_id to origin_id;
alter table sturwild.capture_type rename column capture_type_libelle to origin_name;
alter table sturwild.ciem rename column ciem_id to ices_id;
alter table sturwild.ciem rename column ciem_libelle to ices_name;
alter table sturwild.declaration rename column statut_id to status_id;
alter table sturwild.declaration rename column capture_mode_id to capture_method_id;
alter table sturwild.declaration rename column capture_type_id to origin_id;
alter table sturwild.declaration rename column engin_type_id to gear_type_id;
alter table sturwild.declaration rename column espece_id to species_id;
alter table sturwild.declaration rename column capture_etat_id to capture_state_id;
alter table sturwild.declaration rename column devenir_id to fate_id;
alter table sturwild.declaration rename column annee to year;
alter table sturwild.declaration rename column nombre_capture to caught_number;
alter table sturwild.declaration rename column capture_date_estimee to estimated_capture_date;
alter table sturwild.declaration rename column engin_maille to gear_mesh;
alter table sturwild.declaration rename column espece_ciblee to target_species;
alter table sturwild.declaration rename column profondeur to depth;
alter table sturwild.declaration rename column prof_min to depth_min;
alter table sturwild.declaration rename column prof_max to depth_max;
alter table sturwild.declaration rename column lt_min to length_min;
alter table sturwild.declaration rename column lt_max to length_max;
alter table sturwild.declaration rename column masse_min to weight_min;
alter table sturwild.declaration rename column masse_max to weight_max;
alter table sturwild.declaration rename column pecheur_code to fisher_code;
alter table sturwild.declaration rename column interlocuteur to contact;
alter table sturwild.declaration rename column interlocuteur_coord to contact_coordonates;
alter table sturwild.declaration rename column navire_port to harbour_vessel;
alter table sturwild.declaration rename column observation to remarks;
alter table sturwild.declaration rename column manipulation to handling;
alter table sturwild.declaration rename column qualite_identification to identification_quality;
alter table sturwild.devenir rename column devenir_id to fate_id;
alter table sturwild.devenir rename column devenir_libelle to fate_name;
alter table sturwild.document rename column document_nom to document_name;
alter table sturwild.document rename column individu_id to fish_id;
alter table sturwild.engin_type rename column engin_type_id to gear_type_id;
alter table sturwild.engin_type rename column engin_type_libelle to gear_type_name;
alter table sturwild.espece rename column espece_id to species_id;
alter table sturwild.espece rename column espece_libelle to species_name;
alter table sturwild.evenement rename column evenement_id to event_id;
alter table sturwild.evenement rename column evenement_type_id to event_type_id;
alter table sturwild.evenement rename column evenement_date to event_date;
alter table sturwild.evenement rename column evenement_commentaire to event_remarks;
alter table sturwild.evenement_type rename column evenement_type_id to event_type_id;
alter table sturwild.evenement_type rename column evenement_type_libelle to event_type_name;
alter table sturwild.individu rename column individu_id to fish_id;
alter table sturwild.individu rename column espece_id to species_id;
alter table sturwild.individu rename column presence_marque_id to tag_presence_id;
alter table sturwild.individu rename column capture_etat_id to capture_state_id;
alter table sturwild.individu rename column devenir_id to fate_id;
alter table sturwild.individu rename column masse to weight;
alter table sturwild.individu rename column manipulation to handling;
alter table sturwild.individu rename column numero_marque to tag_number;
alter table sturwild.individu rename column longueur_individu to fish_length;
alter table sturwild.individu rename column cohorte_estimee to estimated_cohort;
alter table sturwild.individu rename column cohorte_validee to validated_cohort;
alter table sturwild.individu rename column historique to background;
alter table sturwild.individu rename column commentaire to remarks;
alter table sturwild.individu rename column qualite_identification to identification_quality;
alter table sturwild.localisation rename column pays_id to country_id;
alter table sturwild.localisation rename column ciem_id to ices_id;
alter table sturwild.localisation rename column milieu_id to environment_id;
alter table sturwild.localisation rename column milieu_detail_id to environment_detail_id;
alter table sturwild.localisation rename column zone_detail to area_detail;
alter table sturwild.localisation rename column precision_id to accuracy_id;
alter table sturwild.localisation rename column longitude_declaree_dd to longitude_declared_dd;
alter table sturwild.localisation rename column latitude_declaree_dd to latitude_declared_dd;
alter table sturwild.localisation rename column longitude_estimee_dd to longitude_estimated_dd;
alter table sturwild.localisation rename column latitude_estimee_dd to latitude_estimated_dd;
alter table sturwild.milieu rename column milieu_id to environment_id;
alter table sturwild.milieu rename column milieu_libelle to environment_name;
alter table sturwild.milieu_detail rename column milieu_detail_id to environment_detail_id;
alter table sturwild.milieu_detail rename column milieu_detail_libelle to environment_detail_name;
alter table sturwild.pays rename column pays_id to country_id;
alter table sturwild.pays rename column pays_libelle to country_name;
alter table sturwild.pays rename column pays_order to country_order;
alter table sturwild.precision rename column precision_id to accuracy_id;
alter table sturwild.precision rename column precision_name to accuracy_name;
alter table sturwild.presence_marque rename column presence_marque_id to tag_presence_id;
alter table sturwild.presence_marque rename column presence_marque_libelle to tag_presence_name;
alter table sturwild.statut rename column statut_id to status_id;
alter table sturwild.statut rename column statut_libelle to status_name;
alter table sturwild.capture_etat rename to capture_state;
alter sequence if exists sturwild.capture_etat_capture_etat_id_seq rename to capture_state_capture_state_id_seq;
alter table sturwild.capture_mode rename to capture_method;
alter sequence if exists sturwild.capture_mode_capture_mode_id_seq rename to capture_method_capture_method_id_seq;
alter table sturwild.capture_type rename to origin;
alter sequence if exists sturwild.capture_type_capture_type_id_seq rename to origin_origin_id_seq;
alter table sturwild.ciem rename to ices;
alter sequence if exists sturwild.ciem_ciem_id_seq rename to ices_ices_id_seq;
alter table sturwild.devenir rename to fate;
alter sequence if exists sturwild.devenir_devenir_id_seq rename to fate_fate_id_seq;
alter table sturwild.engin_type rename to gear_type;
alter sequence if exists sturwild.engin_type_engin_type_id_seq rename to gear_type_gear_type_id_seq;
alter table sturwild.espece rename to species;
alter sequence if exists sturwild.espece_espece_id_seq rename to species_species_id_seq;
alter table sturwild.estuaire_area rename to estuary_area;
alter sequence if exists sturwild.estuaire_area_estuaire_area_id_seq rename to estuary_area_estuary_area_id_seq;
alter table sturwild.evenement rename to event;
alter sequence if exists sturwild.evenement_evenement_id_seq rename to event_event_id_seq;
alter table sturwild.evenement_type rename to event_type;
alter sequence if exists sturwild.evenement_type_evenement_type_id_seq rename to event_type_event_type_id_seq;
alter table sturwild.individu rename to fish;
alter sequence if exists sturwild.individu_individu_id_seq rename to fish_fish_id_seq;
alter table sturwild.localisation rename to location;
alter sequence if exists sturwild.localisation_localisation_id_seq rename to location_location_id_seq;
alter table sturwild.milieu rename to environment;
alter sequence if exists sturwild.milieu_milieu_id_seq rename to environment_environment_id_seq;
alter table sturwild.milieu_detail rename to environment_detail;
alter sequence if exists sturwild.milieu_detail_milieu_detail_id_seq rename to environment_detail_environment_detail_id_seq;
alter table sturwild.pays rename to country;
alter sequence if exists sturwild.pays_pays_id_seq rename to country_country_id_seq;
alter table sturwild.precision rename to accuracy;
alter sequence if exists sturwild.precision_precision_id_seq rename to accuracy_accuracy_id_seq;
alter table sturwild.presence_marque rename to tag_presence;
alter sequence if exists sturwild.presence_marque_presence_marque_id_seq rename to tag_presence_tag_presence_id_seq;
alter table sturwild.statut rename to status;
alter sequence if exists sturwild.statut_statut_id_seq rename to status_status_id_seq;

create view sturwild.v_location as 
( SELECT location.declaration_id,
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
     LEFT JOIN sturwild.fate USING (fate_id));
