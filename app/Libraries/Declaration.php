<?php

namespace App\Libraries;

use app\Libraries\SendMail;
use App\Models\Declaration as ModelsDeclaration;
use App\Models\Document;
use App\Models\Event;
use App\Models\Fish;
use App\Models\Ices;
use App\Models\Institute;
use App\Models\Location;
use App\Models\Param;
use Ppci\Libraries\DefaultPage;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Declaration extends PpciLibrary
{
    /**
     * @var ModelsDeclaration
     */
    protected PpciModel $dataclass;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsDeclaration();
        $keyName = "declaration_id";
        if (isset($_REQUEST[$keyName])) {
            $this->id = $_REQUEST[$keyName];
        }
    }
    function list()
    {
        $this->vue = service('Smarty');
        /*
         * Display the list of all records of the table
         */
        $_SESSION["searchDeclaration"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchDeclaration"]->getParam();
        if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
            $data = $this->dataclass->search($dataSearch);
            $this->vue->set($data, "data");
            $this->vue->set(1, "isSearch");
        }
        /*
         * Integration des listes de selection de la boite de recherche
         */
        $ices = new Ices();
        $this->vue->set($ices->getListe(2), "ices");

        $country = new \App\Models\Country();
        $this->vue->set($country->getListe(3), "country");

        $environment = new Param("environment");
        $this->vue->set($environment->getListe(2), "environment");

        $species = new Param("species");
        $this->vue->set($species->getListe(2), "species");

        $capture_state = new Param("capture_state");
        $this->vue->set($capture_state->getListe(2), "capture_state");

        $gear_type = new Param("gear_type");
        $this->vue->set($gear_type->getListe(2), "gear_type");

        $status = new Param("status");
        $this->vue->set($status->getListe(1), "status");
        $this->vue->set($_SESSION["searchDeclaration"]->isSearch(), "isSearch");
        $this->vue->set($_SESSION["searchDeclaration"]->getListeAnnee(), "years");
        $institute = new Institute();
        $this->vue->set($institute->getListe(2), "institute");
        $this->vue->set($dataSearch, "dataSearch");
        $this->vue->set("declaration/declarationList.tpl", "corps");

        /**
         * Generate data for markers on the map
         */
        $dataMap["markers"] = array();
        foreach ($data as $row) {
            if (!empty($row["longitude_dd"]) && !empty($row["latitude_dd"])) {
                $dataMap["markers"][] = array(
                    "latlng" => array(
                        $row["latitude_dd"],
                        $row["longitude_dd"]
                    ),
                    "id" => $row["declaration_id"],
                    "date" => $row["capture_date"]
                );
            }
        }
        $this->vue->set(json_encode($dataMap), "markers");
        $this->vue->htmlVars[] = "markers";
        return $this->vue->send();
    }
    function display()
    {
        $this->vue = service('Smarty');
        /*
         * Display the detail of the record
         */
        $this->vue->set($data = $this->dataclass->getDetail($this->id), "data");
        $this->vue->set("declaration/declarationDisplay.tpl", "corps");
        if ($this->dataclass->isGrantedFromInstitute($data["institute_id"])) {
            $this->vue->set(1, "editGranted");
        } else {
            $this->vue->set(0, "editGranted");
        }
        /*
         * Recuperation des autres informations a afficher
         */
        $location = new Location();
        $this->vue->set($location->getDetail($this->id), "location");
        $fish = new Fish();
        $this->vue->set($fish->getListeFromDeclaration($this->id), "fishs");
        $event = new Event();
        $this->vue->set($event->getListeFromDeclaration($this->id), "events");
        $document = new Document();
        try {
            $this->vue->set($document->getListFromDeclaration($this->id), "dataDoc");
        } catch (PpciException $de) {
            $this->message->set(_("Problème(s) rencontré(s) pour afficher les photos ou documents. Contactez l'administrateur du système."));
            $this->message->setSyslog($de->getMessage());
        } 
        return $this->vue->send();
    }
    function change()
    {
        $this->vue = service('Smarty');
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $this->dataRead($this->id, "declaration/declarationChange.tpl");
        /*
         * Lecture des tables de parametres
         */
        $status = new Param("status");
        $this->vue->set($status->getListe(), "status");
        $captureMethod = new Param("capture_method");
        $this->vue->set($captureMethod->getListe(), "capture_method");
        $origin = new Param("origin");
        $this->vue->set($origin->getListe(), "origin");
        $gearType = new Param("gear_type");
        $this->vue->set($gearType->getListe(), "gear_type");
        $species = new Param("species");
        $this->vue->set($species->getListe(), "species");
        $fate = new Param("fate");
        $this->vue->set($fate->getListe(), "fate");
        $captureState = new Param("capture_state");
        $this->vue->set($captureState->getListe(), "capture_state");
        $targetSpecies = new Param("target_species");
        $this->vue->set($targetSpecies->getListe(), "target_species");
        $institute = new Institute();
        $this->vue->set($institute->getInstitutesEnabled(), "institutes");
        /**
         * Handlings
         */
        $this->vue->set($this->dataclass->getHandlings($this->id), "handlings");
        /*
         * Recuperation de la liste des years
         */
        $this->vue->set($_SESSION["searchDeclaration"]->getListeAnnee(), "years");
        return $this->vue->send();
    }
    function write()
    {
        /*
         * write record in database
         */
        /*
         * Recherche de l'ancien status
         */
        if ($this->id == 0) {
            $statusOld = 0;
        } else {
            $dataStatus = $this->dataclass->lire($this->id);
            $statusOld = $dataStatus["status_id"];
        }
        $this->id = $this->dataWrite($_REQUEST);
        if ($this->id > 0) {
            $_REQUEST["declaration_id"] = $this->id;
            /*
             * Traitement du changement de status : envoi d'un message si le status vaut 3 ou 4
             */
            if (($_REQUEST["status_id"] == 3 || $_REQUEST["status_id"] == 4) && $statusOld != $_REQUEST["status_id"]) {
                $mail = new SendMail();
                $mail->send($this->id);
            }
            return $this->display();
        } else {
            return $this->change();
        }
    }
    function delete()
    {
        /*
         * delete record
         */
        try {
            $this->dataDelete($this->id);
            return $this->list();
        } catch (PpciException $e) {
            return $this->change();
        }
    }
    function export()
    {
        /*
         * Exporte la liste des captures accidentelles au format CSV
         */
        $this->vue = service('CsvView');
        $_SESSION["searchDeclaration"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchDeclaration"]->getParam();
        if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
            $this->vue->setFilename("sturwild_declaration-" . date('Y-m-d') . ".csv");
            $this->vue->setDelimiter("tab");
            $this->vue->set($this->dataclass->getDataToExport($dataSearch));
            return $this->vue->send();
        }
    }
    function sturioByYear()
    {
        /*
         * Recherche du nombre d'esturgeons captures par year
         */
        $this->vue = service('Smarty');
        $this->vue->set($this->dataclass->getNbSturioByYear(), "data");
        $this->vue->set("declaration/nbSturioByYear.tpl", "corps");
        return $this->vue->send();
    }
    function duplicate()
    {
        /*
         * Duplication de la fiche courante
         */
        if ($this->id > 0) {
            try {
                $newId = $this->dataclass->duplicate($this->id);
                $_REQUEST["declaration_id"] = $newId;
                $this->message->set(_("Déclaration dupliquée !"));
                return $this->change();
            } catch (PpciException $e) {
                $this->message->set(_("Echec de duplication de la déclaration"), true);
                $this->message->set($e->getMessage(), true);
                return $this->list();
            }
        } else {
            defaultPage();
        }
    }
    function exportCSV()
    {
        if (isset($_POST["declaration_ids"]) && count($_POST["declaration_ids"]) > 0) {
            $data = $this->dataclass->getDataForExport($_POST["declaration_ids"], $_POST["use_exchange_labels"]);
            if (!empty($data)) {
                $this->vue = service ("CsvView");
                $this->vue->setFilename("sturwild_declarations-" . date('Y-m-d') . ".csv");
                $this->vue->setDelimiter(",");
                $this->vue->set($data);
                $this->vue->send();
            } else {
                $this->message->set(_("Aucune des déclarations sélectionnées ne peut être exportée : elles doivent avoir été validées au préalable"), true);
                return $this->list();
            }
        } else {
            $this->message->set(_("Aucune déclaration n'a été sélectionnée"), true);
            return $this->list();
        }
    }
    function exportJSON()
    {
        $fish = new Fish();
        if (isset($_POST["declaration_ids"]) && count($_POST["declaration_ids"]) > 0) {
            $data = $this->dataclass->getDataForExport($_POST["declaration_ids"], $_POST["use_exchange_labels"]);
            if (!empty($data)) {
                $this->vue = service ("JsonFileView");
                foreach ($data as $k => $v) {
                    $data[$k]["fishes"] = $fish->getDataForExport(array($v["declaration_uuid"]), $_POST["use_exchange_labels"], false, true);
                }
                $this->vue->set($data);
                $this->vue->setFilename("sturwild-declarations-" . date('Y-m-d') . ".json");
                $this->vue->send();
            } else {
                unset($this->vue);
                $module_coderetour = -1;
                $this->message->set(_("Aucune des déclarations sélectionnées ne peut être exportée : elles doivent avoir été validées au préalable"), true);
                return $this->list();
            }
        } else {
            unset($this->vue);
            $this->message->set(_("Aucune déclaration n'a été sélectionnée"), true);
            return $this->list();
        }
    }
}
