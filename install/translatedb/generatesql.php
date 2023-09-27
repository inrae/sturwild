<?php
use translate\Import;
use translate\ImportException;
include_once "import.class.php";
$tablefilename = "tables.csv";
$columnfilename = "colonnes.csv";
$sqlfilename = "translate.sql";

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
        $sql = "comment on column sturwild.".$column["tablename"].".".$column["field"]. " is E'".($column["comment_translated"])."';\n";
        fwrite($sqlfile,$sql);
    }
    if(!empty($column["field_translated"])) {
        $sql = "alter table sturwild.".$column["tablename"]." rename column ".$column["field"]." to ".$column["field_translated"].";\n";
        fwrite($sqlfile,$sql);
    }
}
$tables = $tableClass->getContentAsArray();
foreach ($tables as $table) {
    if (!empty($table["comment_translated"])) {
        $sql = "comment on table sturwild.".$table["tablename"]. " is E'".($table["comment_translated"])."';\n";
        fwrite($sqlfile,$sql);
    }
    if(!empty($table["table_translated"])) {
        $sql = "alter table sturwild.".$table["tablename"]." rename to ".$table["table_translated"].";\n";
        fwrite($sqlfile,$sql);
        $sql = "alter sequence if exists sturwild.".$table["tablename"]."_".$table["tablename"]."_id_seq rename to " .$table["table_translated"]."_".$table["table_translated"]."_id_seq;\n";
        fwrite($sqlfile,$sql);
    }
}
$sql = "drop table sturwild.region cascade;\n";
fwrite($sqlfile,$sql);
fclose($sqlfile);


} catch (ImportException $e) {
echo "Erreur lors de l'importation des fichiers csv".PHP_EOL;
}
