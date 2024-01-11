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
        "declaration_uuid",
        "origin_identifier",
        "country_name",
        "ices_name",
        "environment_name",
        "environment_detail_name",
        "area_detail",
        "longitude_gps",
        "latitude_gps",
        "longitude_dd",
        "latitude_dd",
        "accuracy_name"
    );
    private array $mandatory = array("origin_name", "caught_number");
    public PDO $connection;
    private $separator = ",";
    private $utf8_encode;
    private $paramTables = array("origin", "capture_method", "gear_type", "target_species", "fate", "species", "country", "ices", "environment", "environment_detail", "accuracy_name");

    private $status, $origin, $capture_method, $gear_type, $target_species, $species;
    private $fileContent = array();
    public $paramToCreate = array();
    public array $errors = array();
    public bool $hasErrors = false;

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
     * @return array
     */
    function searchFromParameters(array $row, bool $withCreate = false): array
    {

        foreach ($this->paramTables as $paramName) {
            $colname = $paramName . "_name";
            $colid = $paramName . "_id";
            if (strlen($row[$colname]) > 0) {
                /**
                 * Search if exists the parameter
                 */
                $paramData = $this->$paramName->getIdFromName($row[$colname], false, $withCreate);
                if (!empty($paramData)) {
                    $row[$colid] = $paramData[$colid];
                } else {
                    if (
                        !$withCreate &&
                        !in_array($row[$colname], $this->paramToCreate[$paramName])
                    ) {
                        $this->paramToCreate[$paramName][] = $row[$colname];
                    }

                }
            }
        }
        return $row;
    }

    function verifyBeforeImport()
    {
        $line = 2;
        foreach ($this->fileContent as $key => $row) {
            /**
             * search for mandatory
             */
            foreach ($this->mandatory as $field) {
                if (!isset($row[$field]) || strlen($row[$field]) == 0) {
                    $this->errors[] = array(
                        "line" => $line,
                        "message" => sprintf(_("Le champ %s est vide et doit être renseigné"), $field)
                    );
                    $this->hasErrors = true;
                }
                /**
                 * Check for date
                 */
                if (empty($row["capture_date"])&& empty($row["year"])) {
                    $this->errors[] = array(
                        "line" => $line,
                        "message" => _("La date de capture ou l'année doit être renseignée")
                    );
                    $this->hasErrors = true;
                }
                /**
                 * Check for origin identifier
                 */
                if (empty ($row["origin_identifier"])&& empty($row["declaration_uuid"])) {
                    $this->errors[] = array(
                        "line" => $line,
                        "message" => _("L'un des champs origin_identifier ou declaration_uuid doit être renseigné pour pouvoir importer les poissons associés à la déclaration")
                    );
                }
            }
            /**
             * Search for parameters
             */
            $row = $this->searchFromParameters($row);
            $this->fileContent[$key] = $row;
        }
    }
}