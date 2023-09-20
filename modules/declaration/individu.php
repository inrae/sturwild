<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/fish.class.php';
$dataClass = new Fish ( $bdd, $ObjetBDDParam );
$keyName = "fish_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead ( $dataClass, $id, "declaration/fishChange.tpl", $_REQUEST ["declaration_id"] );
		/*
		 * Lecture des tables de parametre
		 */
		require_once 'modules/classes/declaration.class.php';
		$species = new Species ( $bdd, $ObjetBDDParam );
		$vue->set ($species->getListe ( 2 ) , "species" );

		$fate = new Fate ( $bdd, $ObjetBDDParam );
		$vue->set ( $fate->getListe ( 1 ), "fate" );

		$tag_presence = new TagPresence ( $bdd, $ObjetBDDParam );
		$vue->set ( $tag_presence->getListe ( 1 ), "tag_presence" );

		$captureEtat = new Capture_state ( $bdd, $ObjetBDDParam );
		$vue->set ( $captureEtat->getListe ( 2 ), "capture_state" );


		if ($id > 0) {
			require_once 'modules/classes/document.class.php';
			$document = new Document ( $bdd, $ObjetBDDParam );
			try {
			$vue->set ( $document->getListFromFish ( $id ), "dataDoc" );
			} catch (DocumentException $de) {
			    $message->set("Problème(s) rencontré(s) pour afficher les photos ou documents. Contactez l'administrateur du système.");
			    $message->setSyslog($de->getMessage());
			}

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
					$document->documentWrite ( $file, $id, $_REQUEST ["document_description"] );
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
			/*require_once 'modules/classes/export.class.php';
			$export = new Export ();
			$export->exportCSVinit ( "sturwild_fish", "tab" );
			$export->exportCSV ( $dataClass->getDataToExport ( $dataSearch ), true );*/
		    $vue->setFilename("sturwild_fish-".date('d-m-Y' ) . ".csv");
		    $vue->setDelimiter("tab");
		    $vue->set($dataClass->getDataToExport ( $dataSearch ));
		}
		break;
}
?>
