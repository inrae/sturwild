<?php
class DeclarationImport extends SturwildImport
{

    protected array $mandatory = array("caught_number");
    protected $paramTables = array("origin", "capture_method", "gear_type", "target_species", "fate", "species", "country", "environment", "environment_detail", "accuracy_name", "handling", "status");
    public Location $location;
    public Institute $institute;
    public Ices $ices;
    public Fish $fish;
    public FishImport $fishImport;
    function verifyBeforeImport(string $suffix = "_exchange")
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
            $row = $this->searchFromParameters($row, $suffix, false);
            $this->fileContent[$key] = $row;
            /**
             * Search from institute
             */
            if (!empty($row["institute_code"])) {
                $id = $this->institute->getIdFromCode($row["institute_code"]);
                if (
                    $id == 0 &&
                    (!isset($this->paramToCreate["institute"]) || !in_array($row["institute_code"], $this->paramToCreate["institute"]))
                ) {
                    $this->paramToCreate["institute"][] = $row["institute_code"];
                }
            }
            /**
             * Search for ices
             */
            if (!empty($row["ices_name"])) {
                $id = $this->ices->getIdFromName($row["ices_name"]);
                if (
                    $id == 0 &&
                    (!isset($this->paramToCreate["ices"]) || !in_array($row["ices_name"], $this->paramToCreate["ices"]))
                ) {
                    $this->paramToCreate["ices"][] = $row["ices_name"];
                }
            }
            /**
             * Search for handlings
             */
            if (!empty($row["handlings$suffix"])) {
                $a_handlings = explode(",", $row["handlings$suffix"]);
                foreach ($a_handlings as $h) {
                    $id = $this->_searchFromParameter("handling", $h, $suffix, false);
                    if (
                        $id == 0 &&
                        (!isset($this->paramToCreate["handling"]) || !in_array($h, $this->paramToCreate["handling"]))
                    ) {
                        $this->paramToCreate["handling"][] = $h;
                    }
                }
            }
        }
    }
    function exec(string $suffix = "_exchange")
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
                $this->updated++;
            } else {
                $ddeclaration = array("declaration_id" => $id);
                $dlocation = array();
            }
            /**
             * Add parameters
             */
            $row = $this->searchFromParameters($row, $suffix, true);
            if (!empty($row["institute_code"])) {
                $row["institute_id"] = $this->institute->getIdFromCode($row["institute_code"], true);
            }
            if (!empty($row["ices_name"])) {
                $row["ices_id"] = $this->ices->getIdFromName($row["ices_name"], true);
            }
            /**
             * Set the status
             */
            if (!strlen($row["status_id"]) > 0) {
                $row["status_id"] = 3;
            }
            /**
             * Search for handlings
             */
            if (!empty($row["handlings$suffix"])) {
                $a_handlings = explode(",", $row["handlings$suffix"]);
                foreach ($a_handlings as $h) {
                    $id = $this->_searchFromParameter("handling", $h, $suffix, true);
                    $row["handlings"][] = $id;
                }
            }
            /**
             * Update declaration and location
             */
            $ddeclaration = array_merge($ddeclaration, $row);
            $dlocation = array_merge($dlocation, $row);
            $id = $this->declaration->ecrire($ddeclaration);
            $dlocation["declaration_id"] = $id;
            $this->location->ecrire($dlocation);
            $this->recorded++;
            if ($id > $this->idMax) {
                $this->idMax = $id;
            }
            if ($id < $this->idMin) {
                $this->idMin = $id;
            }
            /**
             * Search from fish
             */
            foreach ($row["fishes"] as $rowFish) {
                $this->fishImport->fishWrite($rowFish, $suffix, $id);
            }
        }
    }
}