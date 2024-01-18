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
    private $paramTables = array("origin", "capture_method", "gear_type", "target_species", "fate", "species", "country", "ices", "environment", "environment_detail", "accuracy_name", "handling");

    private $status, $origin, $capture_method, $gear_type, $target_species, $species;
    private $fileContent = array();
    public $paramToCreate = array();
    public array $errors = array();
    public bool $hasErrors = false;
    public int $recordedNumber = 0;
    public Declaration $declaration;
    public Location $location;
    public Institute $institute;
    public int $recorded = 0;

    function initFileCSV($filename, $separator = ",", $utf8_encode = false)
    {
        if ($separator == "tab") {
            $separator = "\t";
        }
        $this->separator = $separator;
        $this->utf8_encode = $utf8_encode;
        /**
         * Open the file
         */
        if ($this->handle = fopen($filename, 'r')) {
            /**
             * Read the first line and attribute columns
             */
            $data = fgetcsv($this->handle, 1000, $this->separator);
            $range = 0;
            for ($range = 0; $range < count($data); $range++) {
                $value = $data[$range];
                $this->fileColumn[$range] = $value;
                /*if (in_array($value, $this->colonnes)) {
                    
                } else {
                    throw new DeclarationImportException(sprintf(_('La colonne %1$s n\'est pas reconnue (%2$s)'), $range, $value));
                }*/
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
                return $values;
            }
        }
        return false;
    }

    /**
     * Close the file
     */
    function fileClose()
    {
        if (is_resource($this->handle)) {
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
    function searchFromParameters(array $row, bool $searchByExchange = true, bool $withCreate = false): array
    {
        foreach ($this->paramTables as $tablename) {
            if ($tablename == "ices") {
                $colname = "ices_name";
            } else {
                $searchByExchange ? $colname = $tablename . "_exchange" : $colname = $tablename . "_name";
            }
            $colid = $tablename . "_id";
            if (strlen($row[$colname]) > 0) {
                if ($tablename == "handling") {
                    $handlings = explode(",", $row[$colname]);
                    $handlingsId = array();
                    foreach ($handlings as $handling) {
                        $id = $this->_searchFromParameter($tablename, $handling, $searchByExchange, $withCreate);
                        if ($id > 0) {
                            $handlingsId[] = $id;
                        }
                    }
                    if (!empty($handlingsId)) {
                        $row["handling_id"] = implode(",", $handlingsId);
                    }
                } else {
                    /**
                     * Search if exists the parameter
                     */
                    $id = $this->_searchFromParameter($tablename, $row[$colname], $searchByExchange, $withCreate);
                    if ($id > 0) {
                        $row[$colid] = $id;
                    }
                }
            }
        }
        return $row;
    }
    /**
     * Search from a parameter
     *
     * @param string $tablename
     * @param string $value
     * @param bool $searchByExchange
     * @param bool $withCreate
     * @return integer
     */
    private function _searchFromParameter(string $tablename, string $value, bool $searchByExchange, bool $withCreate): int
    {
        $id = $this->$tablename->getIdFromName($value, $searchByExchange, $withCreate);
        if (
            $id == 0 &&
            !$withCreate &&
            !in_array($value, $this->paramToCreate[$tablename])
        ) {
            $this->paramToCreate[$tablename][] = $value;
        }
        return $id;
    }

    function verifyBeforeImport(bool $searchByExchange = false)
    {
        $line = 1;
        foreach ($this->fileContent as $key => $row) {
            $line++;
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
                if (empty($row["capture_date"]) && empty($row["year"])) {
                    $this->errors[] = array(
                        "line" => $line,
                        "message" => _("La date de capture ou l'année doit être renseignée")
                    );
                    $this->hasErrors = true;
                }
                /**
                 * Check for origin identifier
                 */
                if (empty($row["origin_identifier"]) && empty($row["declaration_uuid"])) {
                    $this->errors[] = array(
                        "line" => $line,
                        "message" => _("L'un des champs origin_identifier ou declaration_uuid doit être renseigné pour pouvoir importer les poissons associés à la déclaration")
                    );
                }
            }
            /**
             * Search for parameters
             */
            $row = $this->searchFromParameters($row, $searchByExchange, false);
            $this->fileContent[$key] = $row;
            /**
             * Search from institute
             */
            if (!empty($row["institude_code"])) {
                $id = $this->institute->getIdFromCode($row["institute_code"]);
                if ($id == 0) {
                    $this->paramToCreate["institute"][] = $row["institute_code"];
                }
            }
        }
    }
    function exec(bool $searchByExchange)
    {
        foreach ($this->fileContent as $row) {
            /**
             * Search for existing record
             */
            $id = 0;
            if (!empty($row["origin_identifier"])) {
                $id = $this->declaration->getIdByField("origin_identifier", $row["origin_identifier"]);
            }
            if ($id == 0 && !empty($row["declaration_uuid"])) {
                $id = $this->declaration->getIdByField("declaration_uuid", $row["declaration_uuid"]);
            }
            if ($id > 0) {
                $ddeclaration = $this->declaration->lire($id);
                $dlocation = $this->location->lire($id);
            } else {
                $ddeclaration = array("declaration_id" => $id);
                $dlocation = array();
            }
            /**
             * Add parameters
             */
            $row = $this->searchFromParameters($row, $searchByExchange, true);
            /**
             * Update declaration and location
             */
            $ddeclaration = array_merge($ddeclaration, $row);
            $dlocation = array_merge($dlocation, $row);
            $id = $this->declaration->ecrire($ddeclaration);
            $dlocation["declaration_id"] = $id;
            $this->location->ecrire($dlocation);
            $this->recorded++;
        }
    }
}