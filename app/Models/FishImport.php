<?php

namespace App\Models;

use Ppci\Libraries\PpciException;

class FishImport extends SturwildImport
{
    protected array $mandatory = array("caught_number");
    protected $paramTables = array("fate", "species", "capture_state", "tag_presence", "handling");
    public Declaration $declaration;
    public Fish $fish;
    function verifyBeforeImport(string $suffix = "_exchange")
    {
        $line = 1;
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
            $this->fileContent[$key] = $this->rowSearchParameters($row, $suffix, false);
        }
    }

    function rowSearchParameters(array $row, string $suffix, bool $withCreate = false): array
    {
        $row = $this->searchFromParameters($row, $suffix, $withCreate);
        /**
         * Search for handlings
         */
        if (!empty($row["handlings$suffix"])) {
            $a_handlings = explode(",", $row["handlings$suffix"]);
            foreach ($a_handlings as $h) {
                $id = $this->_searchFromParameter("handling", $h, $suffix, $withCreate);
                if (
                    $id == 0 &&
                    (!isset($this->paramToCreate["handling"]) || !in_array($h, $this->paramToCreate["handling"]))
                ) {
                    $this->paramToCreate["handling"][] = $h;
                } else {
                    $row["handlings"][] = $id;
                }
            }
        }
        return $row;
    }

    function exec(string $suffix = "_exchange", $declaration_id = 0)
    {
        foreach ($this->fileContent as $row) {
            $id = $this->fishWrite($row, $suffix, $declaration_id);
            $this->recorded++;
            if ($id > $this->idMax) {
                $this->idMax = $id;
            }
            if ($id < $this->idMin) {
                $this->idMin = $id;
            }
        }
    }
    function fishWrite(array $row, string $suffix, int $declaration_id): int
    {
        $dfish = array();
        /**
         * Search for existing record
         */
        $id = 0;
        unset($row["fish_id"]);
        unset($row["declaration_id"]);
        if (!empty($row["fish_uuid"])) {
            $id = $this->fish->getIdByUUID($row["fish_uuid"]);
        }
        if ($id > 0) {
            $dfish = $this->fish->lire($id);
            $this->updated++;
        } else {
            if (!$declaration_id > 0) {
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
                    throw new PpciException(_("La déclaration correspondante à un poisson n'a pas été trouvée"));
                }
            }
            $dfish["declaration_id"] = $declaration_id;
        }
        /**
         * Add parameters
         */
        $row = $this->searchFromParameters($row, $suffix, true);
        /**
         * Search for handlings
         */
        if (!empty($row["handlings$suffix"])) {
            $a_handlings = explode(",", $row["handlings$suffix"]);
            foreach ($a_handlings as $h) {
                $id = $this->_searchFromParameter("handling", $h, $suffix, true);
                $dfish["handlings"][] = $id;
            }
        }
        /**
         * Write data
         */
        $dfish = array_merge($dfish, $row);
        $id = $this->fish->ecrire($dfish);
        return $id;
    }
}
