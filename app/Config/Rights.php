<?php

namespace App\Config;

use Ppci\Config\RightsPpci;

/**
 * List of all rights required by modules
 */
class Rights extends RightsPpci
{
    protected array $rights = [
        "dbstructureHtml" => ["param"],
        "dbstructureGacl" => ["admin"],
        "dbstructureLatex" => ["param"],
        "dbstructureSchema" => ["param"],
        "declarationList" => ["consult"],
        "declarationDisplay" => ["consult"],
        "declarationChange" => ["manage"],
        "declarationWrite" => ["manage"],
        "declarationDelete" => ["manage"],
        "declarationExport" => ["consult"],
        "declarationNbSturioByYear" => ["consult"],
        "declarationDuplicate" => ["manage"],
        "declarationExportCSV" => ["consult"],
        "declarationExportJson" => ["consult"],
        "eventChange" => ["manage"],
        "eventWrite" => ["manage"],
        "eventDelete" => ["manage"],
        "lotChange" => ["manage"],
        "lotWrite" => ["manage"],
        "fishChange" => ["manage"],
        "fishWrite" => ["manage"],
        "fishDelete" => ["manage"],
        "fishExport" => ["consult"],
        "fishExportCSV" => ["consult"],
        "documentDelete" => ["manage"],
        "documentGet" => ["manage"],
        "locationChange" => ["manage"],
        "locationWrite" => ["manage"],
        "icesList" => ["manage"],
        "icesChange" => ["param"],
        "icesWrite" => ["param"],
        "icesDelete" => ["param"],
        "instituteList" => ["manage"],
        "instituteChange" => ["param"],
        "instituteWrite" => ["param"],
        "instituteDelete" => ["param"],
        "handlingList" => ["consult"],
        "handlingChange" => ["param"],
        "handlingWrite" => ["param"],
        "handlingDelete" => ["param"],
        "gear_typeList" => ["consult"],
        "gear_typeChange" => ["param"],
        "gear_typeWrite" => ["param"],
        "gear_typeDelete" => ["param"],
        "accuracyList" => ["consult"],
        "accuracyChange" => ["param"],
        "accuracyWrite" => ["param"],
        "accuracyDelete" => ["param"],
        "countryList" => ["consult"],
        "countryChange" => ["param"],
        "countryWrite" => ["param"],
        "countryDelete" => ["param"],
        "event_typeList" => ["consult"],
        "event_typeChange" => ["param"],
        "event_typeWrite" => ["param"],
        "event_typeDelete" => ["param"],
        "capture_stateList" => ["consult"],
        "capture_stateChange" => ["param"],
        "capture_stateWrite" => ["param"],
        "capture_stateDelete" => ["param"],
        "originList" => ["consult"],
        "originChange" => ["param"],
        "originWrite" => ["param"],
        "originDelete" => ["param"],
        "capture_methodList" => ["consult"],
        "capture_methodChange" => ["param"],
        "capture_methodWrite" => ["param"],
        "capture_methodDelete" => ["param"],
        "fateList" => ["consult"],
        "fateChange" => ["param"],
        "fateWrite" => ["param"],
        "fateDelete" => ["param"],
        "speciesList" => ["consult"],
        "speciesChange" => ["param"],
        "speciesWrite" => ["param"],
        "speciesDelete" => ["param"],
        "environment_detailList" => ["consult"],
        "environment_detailChange" => ["param"],
        "environment_detailWrite" => ["param"],
        "environment_detailDelete" => ["param"],
        "environmentList" => ["consult"],
        "environmentChange" => ["param"],
        "environmentWrite" => ["param"],
        "environmentDelete" => ["param"],
        "target_speciesList" => ["consult"],
        "target_speciesChange" => ["param"],
        "target_speciesWrite" => ["param"],
        "target_speciesDelete" => ["param"],
        "statusList" => ["consult"],
        "statusChange" => ["param"],
        "statusWrite" => ["param"],
        "importCSVDisplay" => ["param"],
        "importCSVControl" => ["param"],
        "importCSVExec" => ["param"],
        "importFishCSVDisplay" => ["param"],
        "importFishCSVControl" => ["param"],
        "importFishCSVExec" => ["param"],
        "importJSONDisplay" => ["param"],
        "importJSONControl" => ["param"],
        "importJSONExec" => ["param"],
        "updateparamDisplay" => ["admin", "param"],
        "updateparamExec" => ["admin", "param"],
        "updateparamGettemplate" => ["admin", "param"],
    ];
}
