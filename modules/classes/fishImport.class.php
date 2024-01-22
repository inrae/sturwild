<?php

class FishImport extends SturwildImport
{
    protected array $mandatory = array("caught_number");
    protected $paramTables = array("fate", "species", "capture_state", "tag_presence", "handling");
    public Declaration $declaration;
    public Fish $fish;
    function verifyBeforeImport(bool $searchByExchange = false)
    {
        $line = 1;
        $searchByExchange ? $suffix = "_exchange" : $suffix = "_name";
        foreach ($this->fileContent as $key => $row) {
            $line++;
            /**
             * Check for origin identifier
             */
            if (empty($row["origin_identifier"]) && empty($row["declaration_uuid"])) {
                $this->errors[] = array(
                    "line" => $line,
                    "message" => _("L'un des champs origin_identifier ou declaration_uuid doit être renseigné pour pouvoir importer les poissons associés à la déclaration")
                );
                $this->hasErrors = true;
            }
            /**
             * Check for declaration
             */
            $declaration_id = 0;
            if (!empty($row["origin_identifier"])) {
                $declaration_id = $this->declaration->getIdByField("origin_identifier", $row["origin_identifier"]);
            }
            if (!empty($row["declaration_uuid"]) && $declaration_id == 0) {
                $declaration_id = $this->declaration->getIdByField("declaration_uuid", $row["declaration_uuid"]);
            }
            if ($declaration_id == 0) {
                $this->errors[] = array(
                    "line" => $line,
                    "message" => _("Aucune déclaration ne correspond soit au champ origin_identifier, soit au champ declaration_uuid")
                );
                $this->hasErrors = true;
            }
            /**
             * Search for parameters
             */
            $row = $this->searchFromParameters($row, $searchByExchange, false);
            $this->fileContent[$key] = $row;
            /**
             * Search for handlings
             */
            if (!empty($row["handlings$suffix"])) {
                $a_handlings = explode(",", $row["handlings$suffix"]);
                foreach ($a_handlings as $h) {
                    $id = $this->_searchFromParameter("handling", $h, $searchByExchange, false);
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

    function exec(bool $searchByExchange)
    {
        $searchByExchange ? $suffix = "_exchange" : $suffix = "_name";
        foreach ($this->fileContent as $row) {
            $dfish = array();
            /**
             * Search for existing record
             */
            $id = 0;
            if (!empty($row["fish_uuid"])) {
                $id = $this->fish->getIdByUUID($row["fish_uuid"]);
            }
            if ($id > 0) {
                $dfish = $this->fish->lire($id);
                $this->updated++;
            } else {
                /**
                 * Search the id of the declaration
                 */
                $declaration_id = 0;
                if (!empty($row["origin_identifier"])) {
                    $declaration_id = $this->declaration->getIdByField("origin_identifier", $row["origin_identifier"]);
                }
                if ($declaration_id == 0 && !empty($row["declaration_uuid"])) {
                    $declaration_id = $this->declaration->getIdByField("declaration_uuid", $row["declaration_uuid"]);
                }
                if ($declaration_id == 0) {
                    throw new SturwildImportException(_("La déclaration correspondante à un poisson n'a pas été trouvée"));
                }
                $dfish["declaration_id"] = $declaration_id;
            }
            /**
             * Add parameters
             */
            $row = $this->searchFromParameters($row, $searchByExchange, true);
            /**
             * Search for handlings
             */
            if (!empty($row["handlings$suffix"])) {
                $a_handlings = explode(",", $row["handlings$suffix"]);
                foreach ($a_handlings as $h) {
                    $id = $this->_searchFromParameter("handling", $h, $searchByExchange, true);
                    $dfish["handlings"][] = $id;
                }
            }
            /**
             * Write data
             */
            $dfish = array_merge($dfish, $row);
            $this->fish->ecrire($dfish);
            $this->recorded++;
            if ($id > $this->idMax) {
                $this->idMax = $id;
            }
            if ($id < $this->idMin) {
                $this->idMin = $id;
            }
        }
    }
}