<?php
class SturwildImportException extends Exception
{
}

class SturwildImport
{
    private $handle;
    private $fileColumn = array();
    private array $mandatory = array("");
    public PDO $connection;
    private $separator = ",";
    private $utf8_encode;
    private $paramTables = array();
    private $status, $origin, $capture_method, $gear_type, $target_species, $species;
    private $fileContent = array();
    public $paramToCreate = array();
    public array $errors = array();
    public bool $hasErrors = false;
    public Declaration $declaration;
    public int $recordedNumber = 0;
    public int $recorded = 0;
    public int $updated = 0;
    public int $idMin = 9999999;
    public int $idMax = 0;

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
                    throw new SturwildImportException(sprintf(_('La colonne %1$s n\'est pas reconnue (%2$s)'), $range, $value));
                }*/
            }
            while (($data = $this->readLine()) !== false) {
                $this->fileContent[] = $data;
            }
            $this->fileClose();
        } else {
            throw new SturwildImportException(sprintf(_("Le fichier %s n'a pas été trouvé ou n'est pas lisible"), $filename));
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

            $searchByExchange ? $colname = $tablename . "_exchange" : $colname = $tablename . "_name";
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
            !$withCreate && (!isset($this->paramToCreate[$tablename]) ||
                !in_array($value, $this->paramToCreate[$tablename]))
        ) {
            $this->paramToCreate[$tablename][] = $value;
        }
        return $id;
    }
}