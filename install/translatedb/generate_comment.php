<?php
use translate\Import;
use translate\ImportException;

include_once "import.class.php";
$tablefilename = "tables.csv";
$columnfilename = "colonnes.csv";
$sqlfilename = "comment_sql.sql";

try {
    $tableClass = new Import($tablefilename, ";");
    $columnClass = new Import($columnfilename, ";");
    $sqlfile = fopen($sqlfilename, "w");
    /**
     * Renommage des colonnes
     */
    $columns = $columnClass->getContentAsArray();
    foreach ($columns as $column) {
        if (!empty($column["comment_translated"])) {
            !empty($column["table_translated"]) ? $tablename = $column["table_translated"] : $tablename = $column["tablename"];
            !empty($column["field_translated"]) ? $field = $column["field_translated"] : $field = $column["field"];
            $sql = "comment on column sturwild." . $tablename . "." . $field . " is E'" . ($column["comment_translated"]) . "';" . PHP_EOL;
            fwrite($sqlfile, $sql);
        }
    }
    $tables = $tableClass->getContentAsArray();
    foreach ($tables as $table) {
        if (!empty($table["comment_translated"])) {
            !empty($table["table_translated"]) ? $tablename = $table["table_translated"] : $tablename = $table["tablename"];
            $sql = "comment on table sturwild." . $tablename . " is E'" . ($table["comment_translated"]) . "';" . PHP_EOL;
            fwrite($sqlfile, $sql);
        }
    }
    fclose($sqlfile);
} catch (ImportException $e) {
    echo "Erreur lors de l'importation des fichiers csv" . PHP_EOL;
}