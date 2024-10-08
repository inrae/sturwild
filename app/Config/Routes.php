<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
//$routes->get('/', 'Home::index');
$routes->add('declarationList', 'Declaration::list');
$routes->add('declarationDisplay', 'Declaration::display');
$routes->add('declarationChange', 'Declaration::change');
$routes->post('declarationWrite', 'Declaration::write');
$routes->post('declarationDelete', 'Declaration::delete');
$routes->add('declarationExport', 'Declaration::export');
$routes->add('declarationNbSturioByYear', 'Declaration::sturioByYear');
$routes->add('declarationDuplicate', 'Declaration::duplicate');
$routes->add('declarationExportCSV', 'Declaration::exportCSV');
$routes->add('declarationExportJson', 'Declaration::exportJSON');
$routes->add('eventChange', 'Event::change');
$routes->post('eventWrite', 'Event::write');
$routes->post('eventDelete', 'Event::delete');
$routes->add('lotChange', 'Lot::change');
$routes->post('lotWrite', 'Lot::write');
$routes->add('fishChange', 'Fish::change');
$routes->post('fishWrite', 'Fish::write');
$routes->post('fishDelete', 'Fish::delete');
$routes->add('fishExport', 'Fish::export');
$routes->add('fishExportCSV', 'Fish::exportCSV');
$routes->add('documentDelete', 'Fish::documentDelete');
$routes->add('documentGet', 'Document::get');
$routes->add('locationChange', 'Location::change');
$routes->post('locationWrite', 'Location::write');
$routes->add('parametre', '\Ppci\Controllers\Utils::submenu/parametre');
$routes->add('icesList', 'Ices::list');
$routes->add('icesChange', 'Ices::change');
$routes->post('icesWrite', 'Ices::write');
$routes->post('icesDelete', 'Ices::delete');
$routes->add('instituteList', 'Institute::list');
$routes->add('instituteChange', 'Institute::change');
$routes->post('instituteWrite', 'Institute::write');
$routes->post('instituteDelete', 'Institute::delete');
$routes->add('handlingList', 'Param::list/handling');
$routes->add('handlingChange', 'Param::change/handling');
$routes->post('handlingWrite', 'Param::write/handling');
$routes->post('handlingDelete', 'Param::delete/handling');
$routes->add('gear_typeList', 'Param::list/gear_type');
$routes->add('gear_typeChange', 'Param::change/gear_type');
$routes->post('gear_typeWrite', 'Param::write/gear_type');
$routes->post('gear_typeDelete', 'Param::delete/gear_type');
$routes->add('accuracyList', 'Param::list/accuracy');
$routes->add('accuracyChange', 'Param::change/accuracy');
$routes->post('accuracyWrite', 'Param::write/accuracy');
$routes->post('accuracyDelete', 'Param::delete/accuracy');
$routes->add('countryList', 'Param::list/country');
$routes->add('countryChange', 'Param::change/country');
$routes->post('countryWrite', 'Param::write/country');
$routes->post('countryDelete', 'Param::delete/country');
$routes->add('event_typeList', 'Param::list/event_type');
$routes->add('event_typeChange', 'Param::change/event_type');
$routes->post('event_typeWrite', 'Param::write/event_type');
$routes->post('event_typeDelete', 'Param::delete/event_type');
$routes->add('capture_stateList', 'Param::list/capture_state');
$routes->add('capture_stateChange', 'Param::change/capture_state');
$routes->post('capture_stateWrite', 'Param::write/capture_state');
$routes->post('capture_stateDelete', 'Param::delete/capture_state');
$routes->add('originList', 'Param::list/origin');
$routes->add('originChange', 'Param::change/origin');
$routes->post('originWrite', 'Param::write/origin');
$routes->post('originDelete', 'Param::delete/origin');
$routes->add('capture_methodList', 'Param::list/capture_method');
$routes->add('capture_methodChange', 'Param::change/capture_method');
$routes->post('capture_methodWrite', 'Param::write/capture_method');
$routes->post('capture_methodDelete', 'Param::delete/capture_method');
$routes->add('fateList', 'Param::list/fate');
$routes->add('fateChange', 'Param::change/fate');
$routes->post('fateWrite', 'Param::write/fate');
$routes->post('fateDelete', 'Param::delete/fate');
$routes->add('speciesList', 'Param::list/species');
$routes->add('speciesChange', 'Param::change/species');
$routes->post('speciesWrite', 'Param::write/species');
$routes->post('speciesDelete', 'Param::delete/species');
$routes->add('environment_detailList', 'Param::list/environment_detail');
$routes->add('environment_detailChange', 'Param::change/environment_detail');
$routes->post('environment_detailWrite', 'Param::write/environment_detail');
$routes->post('environment_detailDelete', 'Param::delete/environment_detail');
$routes->add('environmentList', 'Param::list/environment');
$routes->add('environmentChange', 'Param::change/environment');
$routes->post('environmentWrite', 'Param::write/environment');
$routes->post('environmentDelete', 'Param::delete/environment');
$routes->add('target_speciesList', 'Param::list/target_species');
$routes->add('target_speciesChange', 'Param::change/target_species');
$routes->post('target_speciesWrite', 'Param::write/target_species');
$routes->post('target_speciesDelete', 'Param::delete/target_species');
$routes->add('statusList', 'Status::list');
$routes->add('statusChange', 'Status::change');
$routes->post('statusWrite', 'Status::write');
$routes->add('importCSVDisplay', 'Import::display');
$routes->add('importCSVControl', 'Import::control');
$routes->add('importCSVExec', 'Import::csvExec');
$routes->add('importFishCSVDisplay', 'ImportFish::display');
$routes->add('importFishCSVControl', 'ImportFish::control');
$routes->add('importFishCSVExec', 'ImportFish::csvExec');
$routes->add('importJSONDisplay', 'Import::jsonDisplay');
$routes->add('importJSONControl', 'Import::jsonControl');
$routes->add('importJSONExec', 'Import::jsonExec');
$routes->add('updateparamDisplay', 'Updateparam::display');
$routes->add('updateparamExec', 'Updateparam::exec');
$routes->add('updateparamGettemplate', 'Updateparam::gettemplate');
$routes->add('aide', '\Ppci\Controllers\Utils::submenu/aide');