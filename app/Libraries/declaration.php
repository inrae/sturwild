<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Xx extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $this->dataClass;

    function __construct()
    {
        parent::__construct();
        $this->dataClass = new \App\Models\XXX();
        $keyName = "xxx_id";
        if (isset($_REQUEST[$keyName])) {
            $this->id = $_REQUEST[$keyName];
        }
    }
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 août 2015
 */
include_once 'modules/classes/declaration.class.php';
$this->dataClass = new Declaration();
$keyName = "declaration_id";
$this->id = $_REQUEST[$keyName];

    function list(){
$this->vue=service('Smarty');
        /*
         * Display the list of all records of the table
         */
        $_SESSION["searchDeclaration"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchDeclaration"]->getParam();
        if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
            $data = $this->dataClass->search($dataSearch);
            $this->vue->set($data, "data");
            $this->vue->set(1, "isSearch");
        }
        /*
         * Integration des listes de selection de la boite de recherche
         */
        include 'modules/declaration/declarationSearch.php';
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
        ]
    function display(){
$this->vue=service('Smarty');
        /*
         * Display the detail of the record
         */
        $this->vue->set($this->dataClass->getDetail($this->id), "data");
        $this->vue->set("declaration/declarationDisplay.tpl", "corps");

        /*
         * Recuperation des autres informations a afficher
         */
        require_once 'modules/classes/location.class.php';
        $location = new Location();
        $this->vue->set($location->getDetail($this->id), "location");

        require_once 'modules/classes/fish.class.php';
        $fish = new Fish();
        $this->vue->set($fish->getListeFromDeclaration($this->id), "fishs");

        require_once 'modules/classes/event.class.php';
        $event = new Event();
        $this->vue->set($event->getListeFromDeclaration($this->id), "events");

        require_once 'modules/classes/document.class.php';
        $document = new Document();
        try {
            $this->vue->set($document->getListFromDeclaration($this->id), "dataDoc");
        } catch (DocumentException $de) {
            $this->message->set(_("Problème(s) rencontré(s) pour afficher les photos ou documents. Contactez l'administrateur du système."));
            $this->message->setSyslog($de->getMessage());
        }

        /*
         * Ajout des coordonnees pour l'affichage de la carte
         */
        $this->vue->set($MAPS_url, "MAPS_url");
        $this->vue->set($MAPS_enabled, "MAPS_enabled");

        ]
    function change(){
$this->vue=service('Smarty');
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $this->dataRead( $this->id, "declaration/declarationChange.tpl");
        /*
         * Lecture des tables de parametres
         */
        require_once "modules/classes/param.class.php";
        require_once "modules/classes/fish.class.php";
        $status = new Param($bdd, "status");
        $this->vue->set($status->getListe(), "status");
        $captureMethod = new Param($bdd, "capture_method");
        $this->vue->set($captureMethod->getListe(), "capture_method");
        $origin = new Param($bdd, "origin");
        $this->vue->set($origin->getListe(), "origin");
        $gearType = new Param($bdd, "gear_type");
        $this->vue->set($gearType->getListe(), "gear_type");
        $species = new Param($bdd, "species");
        $this->vue->set($species->getListe(), "species");
        $fate = new Param($bdd, "fate");
        $this->vue->set($fate->getListe(), "fate");
        $captureState = new Param($bdd, "capture_state");
        $this->vue->set($captureState->getListe(), "capture_state");
        $targetSpecies = new Param($bdd, "target_species");
        $this->vue->set($targetSpecies->getListe(), "target_species");
        require_once "modules/classes/institute.class.php";
        $institute = new Institute();
        $this->vue->set($institute->getListe(2), "institutes");
        /**
         * Handlings
         */
        $this->vue->set($this->dataClass->getHandlings($this->id), "handlings");
        /*
         * Recuperation de la liste des years
         */
        $this->vue->set($_SESSION["searchDeclaration"]->getListeAnnee(), "years");

        ]
    function write(){
        /*
         * write record in database
         */
        /*
         * Recherche de l'ancien status
         */
        if ($this->id == 0) {
            $statusOld = 0;
        } else {
            $dataStatus = $this->dataClass->lire($this->id);
            $statusOld = $dataStatus["status_id"];
        }
        $this->id = $this->dataWrite( $_REQUEST);
        if ($this->id > 0) {
            $_REQUEST[$keyName] = $this->id;
            /*
             * Traitement du changement de status : envoi d'un message si le status vaut 3 ou 4
             */
            if (($_REQUEST["status_id"] == 3 || $_REQUEST["status_id"] == 4) && $statusOld != $_REQUEST["status_id"]) {
                sendMail($this->id);
            }
            $module_coderetour = 1;
        } else {
            $module_coderetour = -1;
        }
        ]
    function delete(){
        /*
         * delete record
         */
        $this->dataDelete( $this->id);
        ]
    case "export() {
        /*
         * Exporte la liste des captures accidentelles au format CSV
         */
        $_SESSION["searchDeclaration"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchDeclaration"]->getParam();
        if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
            $this->vue->setFilename("sturwild_declaration-" . date('d-m-Y') . ".csv");
            $this->vue->setDelimiter("tab");
            $this->vue->set($this->dataClass->getDataToExport($dataSearch));
            /*
             * require_once 'modules/classes/export.class.php';
             * $export = new Export();
             * $export->exportCSVinit("sturwild_declaration", "tab");
             * $export->exportCSV($this->dataClass->getDataToExport($dataSearch), true);
             */
        }
        ]
    case "sturioByYear() {
        /*
         * Recherche du nombre d'esturgeons captures par year
         */
        $this->vue->set($this->dataClass->getNbSturioByYear(), "data");
        $this->vue->set("declaration/nbSturioByYear.tpl", "corps");

        ]
    case "duplicate() {
        /*
         * Duplication de la fiche courante
         */
        if ($this->id > 0) {
            $newId = $this->dataClass->duplicate($this->id);
            if ($newId > 0) {
                $_REQUEST["declaration_id"] = $newId;
                $this->message->set(_("Déclaration dupliquée !"));
            } else {
                $this->message->set(_("Echec de duplication de la déclaration"), true);
                $this->message->set($this->dataClass->getErrorData(1));

                $this->message->setSyslog($this->dataClass->getErrorData(1));
            }
        }
        $module_coderetour = 1;
        ]
    case "exportCSV() {
        if (isset($_POST["declaration_ids"]) && count($_POST["declaration_ids"]) > 0) {
            $data = $this->dataClass->getDataForExport($_POST["declaration_ids"], $_POST["use_exchange_labels"]);
            if (!empty($data)) {
                $this->vue->setFilename("sturwild_declarations-" . date('Y-m-d') . ".csv");
                $this->vue->setDelimiter(",");
                $this->vue->set($data);
            } else {
                unset($this->vue);
                $module_coderetour = -1;
                $this->message->set(_("Aucune des déclarations sélectionnées ne peut être exportée : elles doivent avoir été validées au préalable"), true);
            }
        } else {
            unset($this->vue);
            $module_coderetour = -1;
            $this->message->set(_("Aucune déclaration n'a été sélectionnée"), true);
        }
        ]
    case "exportJSON() {
        include_once "modules/classes/fish.class.php";
        $fish = new Fish();
        if (isset($_POST["declaration_ids"]) && count($_POST["declaration_ids"]) > 0) {
            $data = $this->dataClass->getDataForExport($_POST["declaration_ids"], $_POST["use_exchange_labels"]);
            if (!empty($data)) {
                foreach ($data as $k => $v) {
                    $data[$k]["fishes"] = $fish->getDataForExport(array($v["declaration_uuid"]), $_POST["use_exchange_labels"], false, true);
                }
                $this->vue->set($data);
                $this->vue->setFilename("sturwild-declarations-". date('Y-m-d') . ".json");
            } else {
                unset($this->vue);
                $module_coderetour = -1;
                $this->message->set(_("Aucune des déclarations sélectionnées ne peut être exportée : elles doivent avoir été validées au préalable"), true);
            }
        } else {
            unset($this->vue);
            $module_coderetour = -1;
            $this->message->set(_("Aucune déclaration n'a été sélectionnée"), true);
        }
        ]
}

