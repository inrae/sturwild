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
        require_once 'modules/classes/localisation.class.php';
        $localisation = new Localisation($bdd, $ObjetBDDParam);
        $vue->set($localisation->getDetail($id), "localisation");
        
        require_once 'modules/classes/individu.class.php';
        /*
         * $lot = new Lot($bdd, $ObjetBDDParam);
         * $smarty->assign("dataLot", $lot->getDetail($id));
         */
        $individu = new Individu($bdd, $ObjetBDDParam);
        $vue->set($individu->getListeFromDeclaration($id), "individus");
        
        require_once 'modules/classes/evenement.class.php';
        $evenement = new Evenement($bdd, $ObjetBDDParam);
        $vue->set($evenement->getListeFromDeclaration($id), "evenements");
        
        require_once 'modules/classes/document.class.php';
        $document = new Document($bdd, $ObjetBDDParam);
        $vue->set($document->getListFromDeclaration($id), "dataDoc");
        
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
        require_once "modules/classes/individu.class.php";
        $statut = new Statut($bdd, $ObjetBDDParam);
        $vue->set($statut->getListe(1), "statut");
        $captureMode = new Capture_mode($bdd, $ObjetBDDParam);
        $vue->set($captureMode->getListe(2), "capture_mode");
        $captureType = new Capture_type($bdd, $ObjetBDDParam);
        $vue->set($captureType->getListe(2), "capture_type");
        $enginType = new Engin_type($bdd, $ObjetBDDParam);
        $vue->set($enginType->getListe(2), "engin_type");
        $espece = new Espece($bdd, $ObjetBDDParam);
        $vue->set($espece->getListe(2), "espece");
        $devenir = new Devenir($bdd, $ObjetBDDParam);
        $vue->set($devenir->getListe(1), "devenir");
        $captureEtat = new Capture_etat($bdd, $ObjetBDDParam);
        $vue->set($captureEtat->getListe(2), "capture_etat");
        /*
         * Recuperation de la liste des annees
         */
        $vue->set($_SESSION["searchDeclaration"]->getListeAnnee(), "annees");
        
        break;
    case "write":
		/*
		 * write record in database
		 */
		/*
		 * Recherche de l'ancien statut
		 */
		if ($id == 0) {
            $statutOld = 0;
        } else {
            $dataStatut = $dataClass->lire($id);
            $statutOld = $dataStatut["statut_id"];
        }
        $id = dataWrite($dataClass, $_REQUEST);
        if ($id >= 0) {
            $_REQUEST[$keyName] = $id;
            /*
             * Traitement du changement de statut : envoi d'un message si le statut vaut 3 ou 4
             */
            if (($_REQUEST["statut_id"] == 3 || $_REQUEST["statut_id"] == 4) && statutOld != $_REQUEST["statut_id"]) {
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
            require_once 'modules/classes/export.class.php';
            $export = new Export();
            $export->exportCSVinit("sturwild_declaration", "tab");
            $export->exportCSV($dataClass->getDataToExport($dataSearch), true);
        }
        break;
    case "sturioByYear":
		/*
		 * Recherche du nombre d'esturgeons captures par annee
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
                $message->set("Déclaration dupliquée !");
            } else {
                $textMessage = "Echec de duplication de la déclaration<br>" . $dataClass->getErrorData(1);
                $message->set($textMessage);
                $message->setSyslog($textMessage);
            }
        }
        $module_coderetour = 1;
        break;
}

?>