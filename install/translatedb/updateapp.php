<?php
use translate\Import;
use translate\ImportException;

include_once "import.class.php";
$tablefilename = "tables.csv";
$columnfilename = "colonnes.csv";
$files = array("phpfilestest.txt", "tplfiles.txt");

try {
    $tableClass = new Import($tablefilename, ";");
    $columnClass = new Import($columnfilename, ";");
    $tables = $tableClass->getContentAsArray();
    $columns = $columnClass->getContentAsArray();

    /**
     * Traitement de chaque fichier
     */

    foreach ($files as $file) {
        $fp = @fopen($file, "r");
        if (!$fp) {
            throw new ImportException("Impossible d'ouvrir le fichier $file");
        }
        while (($filename = fgets($fp, 4096)) !== false) {
            $filename = substr($filename, 0, strlen($filename) - 1);
            if (is_file($filename)) {
                $content = file_get_contents($filename);
                $is_changed = false;
                $count = 0;
                foreach ($columns as $column) {
                    if (!empty($column["field_translated"])) {
                        $content = str_replace($column["field"], $column["field_translated"], $content, $count);
                        if ($count > 0) {
                            $is_changed = true;
                        }
                    }
                }
                foreach ($tables as $table) {
                    if (!empty($table["table_translated"])) {
                        $content = str_replace($table["tablename"], $table["table_translated"], $content, $count);
                        if ($count > 0) {
                            $is_changed = true;
                        }
                    }
                }
                if ($is_changed) {
                    file_put_contents($filename, $content);
                    echo "Fichier $filename mis à jour" . PHP_EOL;
                }
            } else {
                echo "$filename n'est pas un fichier" . PHP_EOL;
            }
        }
        fclose($fp);
    }
} catch (ImportException $e) {
    echo $e->getMessage() . PHP_EOL;
}