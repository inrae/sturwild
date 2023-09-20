<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 août 2015
 */
include_once 'modules/classes/declaration.class.php';
$dataClass = new Declaration($bdd, $ObjetBDDParam);
$keyName = "declaration_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
    case "list":
        /*
         * Display the list of all records of the table
         */
        $_SESSION["searchDeclaration"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchDeclaration"]->getParam();
        if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
            $data = $dataClass->search($dataSearch);
            $vue->set($data, "data");
            $vue->set(1, "isSearch");
        }
        /*
         * Integration des listes de selection de la boite de recherche
         */
        include 'modules/declaration/declarationSearch.php';
        $vue->set($dataSearch, "dataSearch");
        $vue->set("declaration/declarationList.tpl", "corps");

        break;
    case "display":
        /*
         * Display the detail of the record
         */
        $vue->set($dataClass->getDetail($id), "data");
        $vue->set("declaration/declarationDisplay.tpl", "corps");

        /*
         * Recuperation des autres informations a afficher
         */
        require_once 'modules/classes/location.class.php';
        $location = new Location($bdd, $ObjetBDDParam);
        $vue->set($location->getDetail($id), "location");

        require_once 'modules/classes/fish.class.php';
        /*
         * $lot = new Lot($bdd, $ObjetBDDParam);
         * $smarty->assign("dataLot", $lot->getDetail($id));
         */
        $fish = new Fish($bdd, $ObjetBDDParam);
        $vue->set($fish->getListeFromDeclaration($id), "fishs");

        require_once 'modules/classes/event.class.php';
        $event = new Event($bdd, $ObjetBDDParam);
        $vue->set($event->getListeFromDeclaration($id), "events");

        require_once 'modules/classes/document.class.php';
        $document = new Document($bdd, $ObjetBDDParam);
        try {
            $vue->set($document->getListFromDeclaration($id), "dataDoc");
        } catch (DocumentException $de) {
            $message->set(_("Problème(s) rencontré(s) pour afficher les photos ou documents. Contactez l'administrateur du système."));
            $message->setSyslog($de->getMessage());
        }

        /*
         * Ajout des coordonnees pour l'affichage de la carte
         */
        $vue->set($MAPS_url, "MAPS_url");
        $vue->set($MAPS_enabled, "MAPS_enabled");

        break;
    case "change":
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        dataRead($dataClass, $id, "declaration/declarationChange.tpl");
        /*
         * Lecture des tables de parametres
         */
        require_once "modules/classes/fish.class.php";
        $status = new Status($bdd, $ObjetBDDParam);
        $vue->set($status->getListe(1), "status");
        $captureMode = new Capture_method($bdd, $ObjetBDDParam);
        $vue->set($captureMode->getListe(2), "capture_method");
        $captureType = new Origin($bdd, $ObjetBDDParam);
        $vue->set($captureType->getListe(2), "origin");
        $enginType = new Gear_type($bdd, $ObjetBDDParam);
        $vue->set($enginType->getListe(2), "gear_type");
        $species = new Species($bdd, $ObjetBDDParam);
        $vue->set($species->getListe(2), "species");
        $fate = new Fate($bdd, $ObjetBDDParam);
        $vue->set($fate->getListe(1), "fate");
        $captureEtat = new Capture_state($bdd, $ObjetBDDParam);
        $vue->set($captureEtat->getListe(2), "capture_state");
        /*
         * Recuperation de la liste des years
         */
        $vue->set($_SESSION["searchDeclaration"]->getListeAnnee(), "years");

        break;
    case "write":
        /*
         * write record in database
         */
        /*
         * Recherche de l'ancien status
         */
        if ($id == 0) {
            $statusOld = 0;
        } else {
            $dataStatus = $dataClass->lire($id);
            $statusOld = $dataStatus["status_id"];
        }
        $id = dataWrite($dataClass, $_REQUEST);
        if ($id >= 0) {
            $_REQUEST[$keyName] = $id;
            /*
             * Traitement du changement de status : envoi d'un message si le status vaut 3 ou 4
             */
            if (($_REQUEST["status_id"] == 3 || $_REQUEST["status_id"] == 4) && $statusOld != $_REQUEST["status_id"]) {
                sendMail($id);
            }
        }
        break;
    case "delete":
        /*
         * delete record
         */
        dataDelete($dataClass, $id);
        break;
    case "export":
        /*
         * Exporte la liste des captures accidentelles au format CSV
         */
        $_SESSION["searchDeclaration"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchDeclaration"]->getParam();
        if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
            $vue->setFilename("sturwild_declaration-" . date('d-m-Y') . ".csv");
            $vue->setDelimiter("tab");
            $vue->set($dataClass->getDataToExport($dataSearch));
            /*
             * require_once 'modules/classes/export.class.php';
             * $export = new Export();
             * $export->exportCSVinit("sturwild_declaration", "tab");
             * $export->exportCSV($dataClass->getDataToExport($dataSearch), true);
             */
        }
        break;
    case "sturioByYear":
        /*
         * Recherche du nombre d'esturgeons captures par year
         */
        $vue->set($dataClass->getNbSturioByYear(), "data");
        $vue->set("declaration/nbSturioByYear.tpl", "corps");

        break;
    case "duplicate":
        /*
         * Duplication de la fiche courante
         */
        if ($id > 0) {
            $newId = $dataClass->duplicate($id);
            if ($newId > 0) {
                $_REQUEST["declaration_id"] = $newId;
                $message->set(_("Déclaration dupliquée !"));
            } else {
                $message->set(_("Echec de duplication de la déclaration"), true);
                $message->set($dataClass->getErrorData(1));

                $message->setSyslog($dataClass->getErrorData(1));
            }
        }
        $module_coderetour = 1;
        break;
}

?>