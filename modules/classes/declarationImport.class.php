<?php
class DeclarationImportException extends Exception
{
}

class DeclarationImport
{
    private $handle;
    private $fileColumn = array();
    private $colonnes = array(
        "capture_method_name",
        "origin_name",
        "gear_type_name",
        "species_name",
        "capture_state_name",
        "fate_name",
        "target_species_name",
        "capture_date",
        "year",
        "caught_number",
        "estimated_capture_date",
        "gear_mesh",
        "target_species",
        "depth",
        "depth_min",
        "depth_max",
        "length_min",
        "length_max",
        "weight_min",
        "weight_max",
        "fisher_code",
        "contact",
        "contact_coordinates",
        "harbour_vessel",
        "declaration_mode",
        "remarks",
        "handling",
        "identification_quality",
        "declaration_uuid"
    );
    public PDO $connection;
    private $separator = ",";
    private $utf8_encode;
    private $paramTables = array("status", "origin", "capture_method", "gear_type", "target_species", "fate", "species");

    private $status, $origin, $capture_method, $gear_type, $target_species, $species;
    private $fileContent = array();
    public $paramToCreate = array();

    function initFileCSV($filename, $separator = ",", $utf8_encode = false)
    {
        if ($separator == "tab") {
            $separator = "\t";
        }
        $this->separator = $separator;
        $this->utf8_encode = $utf8_encode;
        /**
         * Ouverture du fichier
         */
        if ($this->handle = fopen($filename, 'r')) {
            /**
             * Lecture de la premiere ligne et affectation des colonnes
             */
            $data = $this->readLine();
            $range = 0;
            for ($range = 0; $range < count($data); $range++) {
                $value = $data[$range];

                if (in_array($value, $this->colonnes)) {
                    $this->fileColumn[$range] = $value;
                } else {
                    throw new DeclarationImportException(sprintf(_('La colonne %1$s n\'est pas reconnue (%2$s)'), $range, $value));
                }
            }
            while (($data = $this->readLine()) !== false) {
                $this->fileContent[] = $data;
            }
            $this->fileClose();
        } else {
            throw new DeclarationImportException(sprintf(_("Le fichier %s n'a pas été trouvé ou n'est pas lisible"), $filename));
        }
    }
    /**
     * Read a line in the file, and transform it in array with the name of the column as key
     *
     * @return array|false
     */
    function readLine(): array|false
    {
        if ($this->handle) {
            $data = fgetcsv($this->handle, 1000, $this->separator);
            if ($data !== false) {
                if ($this->utf8_encode) {
                    foreach ($data as $key => $value) {
                        $data[$key] = mb_convert_encoding($value, "UTF-8", "ISO-8859-1");
                    }
                }
                $nb = count($data);
                $values = array();
                for ($i = 0; $i < $nb; $i++) {
                    $values[$this->fileColumn[$i]] = $data[$i];
                }
            }
            return $values;
        } else {
            return false;
        }
    }

    /**
     * Ferme le fichier
     */
    function fileClose()
    {
        if ($this->handle) {
            fclose($this->handle);
        }
    }

    /**
     * Init the tables of parameters
     *
     * @param PDO $pdo
     * @return void
     */
    function initParams(PDO $pdo)
    {
        $this->connection = $pdo;
        foreach ($this->paramTables as $tablename) {
            if (!isset($this->$tablename)) {
                $this->$tablename = new Param($pdo, $tablename);
            }
        }
    }
/**
 * Search the id of each parameter
 *
 * @return void
 */
    function searchFromParameters()
    {
        foreach ($this->fileContent as $key => $row) {
            foreach ($this->paramTables as $paramName) {
                $colname = $paramName . "_name";
                $colid = $paramName . "_id";
                if (strlen($row[$colname]) > 0) {
                    /**
                     * Search if exists the parameter
                     */
                    $paramData = $this->$paramName->getIdFromName($row[$colname], false, false);
                    if (!empty($paramData)) {
                        $row[$colid] = $paramData[$colid];
                    } else {
                        if (!in_array($row[$colname], $this->paramToCreate[$paramName])) {
                            $this->paramToCreate[$paramName][] = $row[$colname];
                        }

                    }
                }
            }
            $this->fileContent[$key] = $row;
        }
    }
}