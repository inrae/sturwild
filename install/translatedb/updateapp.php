<?php
use translate\Import;
use translate\ImportException;

include_once "import.class.php";
$tablefilename = "tables.csv";
$columnfilename = "colonnes.csv";
$phpfiles = "phpfilestest.txt";
$tplfiles = "tplfiles.txt";

try {
    $tableClass = new Import($tablefilename, ";");
    $columnClass = new Import($columnfilename, ";");
    $tables = $tableClass->getContentAsArray();
    $columns = $columnClass->getContentAsArray();

    /**
     * Traitement de chaque fichier
     */
    $fp = @fopen($phpfiles, "r");
    if (!$fp) {
        throw new ImportException("Impossible d'ouvrir le fichier $phpfiles");
    }
    while (($filename = fgets($fp, 4096)) !== false) {
        $content = file_get_contents($filename);
        $is_changed = false;
        foreach ($columns as $column) {
            if (!empty($column["field_translated"])) {
                $content = str_replace($column["field"], $column["field_translated"], $count);
                if ($count > 0) {
                    $is_changed = true;
                }
            }
        }
        foreach ($tables as $table) {
            if (!empty($table["table_translated"])) {
                $content = str_replace($column["table"], $column["table_translated"], $count);
                if ($count > 0) {
                    $is_changed = true;
                }
            }
        }
        if ($is_changed) {
            file_put_contents($filename, $content);
            echo "Fichier $filename mis à jour" . PHP_EOL;
        }
    }
    fclose($fp);
} catch (Exception $e) {
    echo $e->getMessage() . PHP_EOL;
}