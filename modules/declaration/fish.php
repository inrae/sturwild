<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/fish.class.php';
$dataClass = new Fish($bdd, $ObjetBDDParam);
$keyName = "fish_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "declaration/fishChange.tpl", $_REQUEST["declaration_id"]);
		/*
		 * Lecture des tables de parametre
		 */
		require_once 'modules/classes/declaration.class.php';
		require_once "modules/classes/param.class.php";
		$species = new Param($bdd, 'species');
		$vue->set($species->getListe(2), "species");

		$fate = new Param($bdd, "fate");
		$vue->set($fate->getListe(1), "fate");

		$tag_presence = new Param($bdd, "tag_presence");
		$vue->set($tag_presence->getListe(1), "tag_presence");

		$captureEtat = new Param($bdd, "capture_state");
		$vue->set($captureEtat->getListe(2), "capture_state");

		/**
		 * Handlings
		 */
		$vue->set($dataClass->getHandlings($id), "handlings");

		if ($id > 0) {
			require_once 'modules/classes/document.class.php';
			$document = new Document($bdd, $ObjetBDDParam);
			try {
				$vue->set($document->getListFromFish($id), "dataDoc");
			} catch (DocumentException $de) {
				$message->set(_("Problème(s) rencontré(s) pour afficher les photos ou documents. Contactez l'administrateur du système."), true);
				$message->setSyslog($de->getMessage());
			}

		}
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id > 0) {
			$_REQUEST[$keyName] = $id;

			/*
			 * Traitement des photos associees
			 */
			require_once 'modules/classes/document.class.php';
			$document = new Document($bdd, $ObjetBDDParam);
			/*
			 * Preparation de files
			 */
			$files = array();
			$fdata = $_FILES['documentName'];
			if (is_array($fdata['name'])) {
				for ($i = 0; $i < count($fdata['name']); ++$i) {
					$files[] = array(
						'name' => $fdata['name'][$i],
						'type' => $fdata['type'][$i],
						'tmp_name' => $fdata['tmp_name'][$i],
						'error' => $fdata['error'][$i],
						'size' => $fdata['size'][$i]
					);
				}
			} else {
				$files[] = $fdata;
			}
			foreach ($files as $file) {
				if (strlen($file['name']) > 0)
					$document->documentWrite($file, $id, $_REQUEST["document_description"]);
			}
			$log->setLog($_SESSION["login"], get_class($dataClass) . "-write", $id);
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
	case "documentDelete":
		/*
		 * Supprime le document
		 */
		require_once 'modules/classes/document.class.php';
		$document = new Document($bdd, $ObjetBDDParam);
		dataDelete($document, $_REQUEST["document_id"]);
		break;
	case "export":
		/*
		 * Exporte la liste des poissons au format CSV
		 */
		$_SESSION["searchDeclaration"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchDeclaration"]->getParam();
		if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
			$vue->setFilename("sturwild_fish-" . date('d-m-Y') . ".csv");
			$vue->setDelimiter("tab");
			$vue->set($dataClass->getDataToExport($dataSearch));
		}
		break;
	case "exportCSV":
		if (isset($_POST["declaration_ids"]) && count($_POST["declaration_ids"]) > 0) {
			$data = $dataClass->getDataForExport($_POST["declaration_ids"], $_POST["use_exchange_labels"]);
			if (!empty($data)) {
				$vue->setFilename("sturwild_fishes-" . date('Y-m-d') . ".csv");
				$vue->setDelimiter(",");
				$vue->set($data);
			} else {
				unset($vue);
				$module_coderetour = -1;
				$message->set(_("Aucune des déclarations sélectionnées ne peut être exportée : elles doivent avoir été validées au préalable"), true);
			}
		} else {
			unset($vue);
			$module_coderetour = -1;
			$message->set(_("Aucune déclaration n'a été sélectionnée"), true);
		}
		break;
		case "csvExec":
			if (isset($_SESSION["importParameters"])) {
				if (file_exists($_SESSION["importParameters"]["filename"])) {
					try {
						/**
						 * Initialize classes
						 */
						require_once "modules/classes/declaration.class.php";
						require_once "modules/classes/fish.class.php";
						$import->declaration = new Declaration($bdd, $ObjetBDDParam);
						$import->fish = new Fish($bdd, $ObjetBDDParam);
						/*
						 * Start a transaction
						 */
						$bdd->beginTransaction();
						$import->initFileCSV($_SESSION["importParameters"]["filename"], $_SESSION["importParameters"]["separator"], $_SESSION["importParameters"]["utf8_encode"]);
						$import->initParams($bdd);
						$import->exec($_SESSION["importParameters"]["use_exchange_labels"]);
						if ($import->recorded == 0) {
							$message->set(_("Aucun poisson n'a été importé dans la base de données. Il est possible qu'un problème technique soit survenu"),true);
							$bdd->rollBack();
						} else {
						$bdd->commit();
						$message->set(_("Importation effectuée"));
						$message->set(sprintf(_("%1s poissons importés, dont %2s poissons mis à jour"), $import->recorded, $import->updated));
						$message->set(sprintf(_("Id min traité ou généré : %1s, Id max : %2s"), $import->idMin, $import->idMax));
						$log->setLog($_SESSION["login"],"importDeclarationsCSV", "declaration_id from ".$import->idMin. " to ".$import->idMax);
						}
						$module_coderetour = 1;
					} catch (Exception $e) {
						if ($bdd->inTransaction()) {
							$bdd->rollBack();
						}
						$module_coderetour = -1;
						$message->set($e->getMessage(), true);
					}
				} else {
					$message->set(_("Le fichier n'est plus disponible dans le serveur : recommencez l'opération"), true);
					$module_coderetour = -1;
				}
			} else {
				$module_coderetour = -1;
				$message->set(_("Une erreur s'est produite, recommencez l'opération"), true);
			}
			break;	
}
