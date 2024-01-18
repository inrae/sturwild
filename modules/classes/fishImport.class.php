<?php

class FishImport extends SturwildImport {
    private array $mandatory = array("caught_number");
    private $paramTables = array("origin", "capture_method", "gear_type", "target_species", "fate", "species", "country", "environment", "environment_detail", "accuracy_name", "handling", "status");
    function verifyBeforeImport() {

    }

    function exec() {}
}