<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/individu.class.php';
$dataClass = new Individu ( $bdd, $ObjetBDDParam );
$keyName = "individu_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead ( $dataClass, $id, "declaration/individuChange.tpl", $_REQUEST ["declaration_id"] );
		/*
		 * Lecture des tables de parametre
		 */
		require_once 'modules/classes/declaration.class.php';
		$espece = new Espece ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "espece", $espece->getListe ( 2 ) );
		$devenir = new Devenir ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "devenir", $devenir->getListe ( 1 ) );
		$presence_marque = new Presence_marque ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "presence_marque", $presence_marque->getListe ( 1 ) );
		$captureEtat = new Capture_etat ( $bdd, $ObjetBDDParam );
		$smarty->assign ( "capture_etat", $captureEtat->getListe ( 2 ) );
		
		if ($id > 0) {
			require_once 'modules/classes/document.class.php';
			$document = new Document ( $bdd, $ObjetBDDParam );
			$smarty->assign ( "dataDoc", $document->getListFromIndividu ( $id ) );
		}
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite ( $dataClass, $_REQUEST );
		if ($id >= 0) {
			$_REQUEST [$keyName] = $id;
			
			/*
			 * Traitement des photos associees
			 */
			require_once 'modules/classes/document.class.php';
			$document = new Document ( $bdd, $ObjetBDDParam );
			/*
			 * Preparation de files
			 */
			$files = array ();
			$fdata = $_FILES ['documentName'];
			if (is_array ( $fdata ['name'] )) {
				for($i = 0; $i < count ( $fdata ['name'] ); ++ $i) {
					$files [] = array (
							'name' => $fdata ['name'] [$i],
							'type' => $fdata ['type'] [$i],
							'tmp_name' => $fdata ['tmp_name'] [$i],
							'error' => $fdata ['error'] [$i],
							'size' => $fdata ['size'] [$i] 
					);
				}
			} else
				$files [] = $fdata;
			foreach ( $files as $file ) {
				if (strlen ( $file ['name'] ) > 0)
					$document->ecrire ( $file, $id, $_REQUEST ["document_description"] );
			}
			$log->setLog ( $_SESSION ["login"], get_class ( $dataClass ) . "-write", $id );
		}
		break;
	case "delete":
			/*
			 * delete record
			 */
			dataDelete ( $dataClass, $id );
		break;
	case "documentDelete" :
		/*
		 * Supprime le document
		 */
		require_once 'modules/classes/document.class.php';
		$document = new Document ( $bdd, $ObjetBDDParam );
		dataDelete ( $document, $_REQUEST ["document_id"] );
		break;
	case "export":
		/*
		 * Exporte la liste des poissons au format CSV
		 */
		$_SESSION ["searchDeclaration"]->setParam ( $_REQUEST );
		$dataSearch = $_SESSION ["searchDeclaration"]->getParam ();
		if ($_SESSION ["searchDeclaration"]->isSearch () == 1) {
			require_once 'modules/classes/export.class.php';
			$export = new Export ();
			$export->exportCSVinit ( "sturwild_individu", "tab" );
			$export->exportCSV ( $dataClass->getDataToExport ( $dataSearch ), true );
		}
		break;
}
?>