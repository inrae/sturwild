<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 août 2015
 */
include_once 'modules/classes/declaration.class.php';
$dataClass = new Declaration ( $bdd, $ObjetBDDParam );
$keyName = "declaration_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$_SESSION ["searchDeclaration"]->setParam ( $_REQUEST );
		$dataSearch = $_SESSION ["searchDeclaration"]->getParam ();
		if ($_SESSION ["searchDeclaration"]->isSearch () == 1) {
			$data = $dataClass->search ( $dataSearch );
			$smarty->assign ( "data", $data );
			$smarty->assign ( "isSearch", 1 );
		}
		/*
		 * Integration des listes de selection de la boite de recherche
		 */
		include 'modules/declaration/declarationSearch.php';
		$smarty->assign ( "dataSearch", $dataSearch );
		$smarty->assign ( "corps", "declaration/declarationList.tpl" );
		break;
	case "display":
		/*
		 * Display the detail of the record
		 */
		$smarty->assign ( "data", $dataClass->getDetail ( $id ) );
		$smarty->assign ( "corps", "declaration/declarationDisplay.tpl" );
		/*
		 * Recuperation des autres informations a afficher
		 */
		require_once 'modules/classes/localisation.class.php';
		$localisation = new Localisation ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "localisation", $localisation->getDetail ( $id ) );
		require_once 'modules/classes/individu.class.php';
		/*
		 * $lot = new Lot($bdd, $ObjetBDDParam);
		 * $smarty->assign("dataLot", $lot->getDetail($id));
		 */
		$individu = new Individu ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "individus", $individu->getListeFromDeclaration ( $id ) );
		require_once 'modules/classes/evenement.class.php';
		$evenement = new Evenement ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "evenements", $evenement->getListeFromDeclaration ( $id ) );
		require_once 'modules/classes/document.class.php';
		$document = new Document ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "dataDoc", $document->getListFromDeclaration ( $id ) );
		/*
		 * Ajout des coordonnees pour l'affichage de la carte
		 */
		$smarty->assign("MAPS_url", $MAPS_url);
		$smarty->assign("MAPS_enabled", $MAPS_enabled);
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "declaration/declarationChange.tpl" );
		/*
		 * Lecture des tables de parametres
		 */
		require_once "modules/classes/individu.class.php";
		$statut = new Statut ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "statut", $statut->getListe ( 1 ) );
		$captureMode = new Capture_mode ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "capture_mode", $captureMode->getListe ( 2 ) );
		$captureType = new Capture_type ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "capture_type", $captureType->getListe ( 2 ) );
		$enginType = new Engin_type ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "engin_type", $enginType->getListe ( 2 ) );
		$espece = new Espece ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "espece", $espece->getListe ( 2 ) );
		$devenir = new Devenir ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "devenir", $devenir->getListe ( 1 ) );
		$captureEtat = new Capture_etat ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "capture_etat", $captureEtat->getListe ( 2 ) );
		/*
		 * Recuperation de la liste des annees
		 */
		$smarty->assign ( "annees", $_SESSION ["searchDeclaration"]->getListeAnnee () );
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
			$dataStatut = $dataClass->lire ( $id );
			$statutOld = $dataStatut ["statut_id"];
		}
		$id = dataWrite ( $dataClass, $_REQUEST );
		if ($id >= 0) {
			$_REQUEST [$keyName] = $id;
			/*
			 * Traitement du changement de statut : envoi d'un message si le statut vaut 3 ou 4
			 */
			if (($_REQUEST ["statut_id"] == 3 || $_REQUEST ["statut_id"] == 4) && statutOld != $_REQUEST ["statut_id"]) {
				sendMail($id);
			}
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete ( $dataClass, $id );
		break;
	case "export":
		/*
		 * Exporte la liste des captures accidentelles au format CSV
		 */
		$_SESSION ["searchDeclaration"]->setParam ( $_REQUEST );
		$dataSearch = $_SESSION ["searchDeclaration"]->getParam ();
		if ($_SESSION ["searchDeclaration"]->isSearch () == 1) {
			require_once 'modules/classes/export.class.php';
			$export = new Export ();
			$export->exportCSVinit ( "sturwild_declaration", "tab" );
			$export->exportCSV ( $dataClass->getDataToExport ( $dataSearch ), true );
		}
		break;
	case "sturioByYear":
		/*
		 * Recherche du nombre d'esturgeons captures par annee
		 */
		$smarty->assign ( "data", $dataClass->getNbSturioByYear () );
		$smarty->assign ( "corps", "declaration/nbSturioByYear.tpl" );
		break;
	case "duplicate":
		/*
		 * Duplication de la fiche courante
		 */
		if ($id > 0) {
			$newId = $dataClass->duplicate($id);
			if ($newId > 0) {
				$_REQUEST["declaration_id"] = $newId;
				$message = "Déclaration dupliquée !";
			}else {
				$message = "Echec de duplication de la déclaration<br>".$dataClass->getErrorData(1);
			}
		}
		$module_coderetour = 1;
		break;
}

?>