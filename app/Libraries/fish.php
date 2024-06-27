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
 *  Creation 7 août 2015
 */
include_once 'modules/classes/fish.class.php';
$this->dataClass = new Fish();
$keyName = "fish_id";
$this->id = $_REQUEST[$keyName];


	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead( $this->id, "declaration/fishChange.tpl", $_REQUEST["declaration_id"]);
		/*
		 * Lecture des tables de parametre
		 */
		require_once 'modules/classes/declaration.class.php';
		require_once "modules/classes/param.class.php";
		$species = new Param($bdd, 'species');
		$this->vue->set($species->getListe(2), "species");

		$fate = new Param($bdd, "fate");
		$this->vue->set($fate->getListe(1), "fate");

		$tag_presence = new Param($bdd, "tag_presence");
		$this->vue->set($tag_presence->getListe(1), "tag_presence");

		$captureEtat = new Param($bdd, "capture_state");
		$this->vue->set($captureEtat->getListe(2), "capture_state");

		/**
		 * Handlings
		 */
		$this->vue->set($this->dataClass->getHandlings($this->id), "handlings");

		if ($this->id > 0) {
			require_once 'modules/classes/document.class.php';
			$document = new Document();
			try {
				$this->vue->set($document->getListFromFish($this->id), "dataDoc");
			} catch (DocumentException $de) {
				$this->message->set(_("Problème(s) rencontré(s) pour afficher les photos ou documents. Contactez l'administrateur du système."), true);
				$this->message->setSyslog($de->getMessage());
			}

		}
		}
	function write(){
		/*
		 * write record in database
		 */
		$this->id = $this->dataWrite( $_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;

			/*
			 * Traitement des photos associees
			 */
			require_once 'modules/classes/document.class.php';
			$document = new Document();
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
					$document->documentWrite($file, $this->id, $_REQUEST["document_description"]);
			}
			$log->setLog($_SESSION["login"], get_class($this->dataClass) . "-write", $this->id);
		}
		}
	function delete(){
		/*
		 * delete record
		 */
		$this->dataDelete( $this->id);
		}
	case "documentDelete() {
		/*
		 * Supprime le document
		 */
		require_once 'modules/classes/document.class.php';
		$document = new Document();
		dataDelete($document, $_REQUEST["document_id"]);
		}
	case "export() {
		/*
		 * Exporte la liste des poissons au format CSV
		 */
		$_SESSION["searchDeclaration"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchDeclaration"]->getParam();
		if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
			$this->vue->setFilename("sturwild_fish-" . date('d-m-Y') . ".csv");
			$this->vue->setDelimiter("tab");
			$this->vue->set($this->dataClass->getDataToExport($dataSearch));
		}
		}
	case "exportCSV() {
		if (isset($_POST["declaration_ids"]) && count($_POST["declaration_ids"]) > 0) {
			$data = $this->dataClass->getDataForExport($_POST["declaration_ids"], $_POST["use_exchange_labels"]);
			if (!empty($data)) {
				$this->vue->setFilename("sturwild_fishes-" . date('Y-m-d') . ".csv");
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
		}
		case "csvExec() {
			if (isset($_SESSION["importParameters"])) {
				if (file_exists($_SESSION["importParameters"]["filename"])) {
					try {
						/**
						 * Initialize classes
						 */
						require_once "modules/classes/declaration.class.php";
						require_once "modules/classes/fish.class.php";
						$import->declaration = new Declaration();
						$import->fish = new Fish();
						/*
						 * Start a transaction
						 */
						$bdd->beginTransaction();
						$import->initFileCSV($_SESSION["importParameters"]["filename"], $_SESSION["importParameters"]["separator"], $_SESSION["importParameters"]["utf8_encode"]);
						$import->initParams($bdd);
						$import->exec($_SESSION["importParameters"]["use_exchange_labels"]);
						if ($import->recorded == 0) {
							$this->message->set(_("Aucun poisson n'a été importé dans la base de données. Il est possible qu'un problème technique soit survenu"),true);
							$bdd->rollBack();
						} else {
						$bdd->commit();
						$this->message->set(_("Importation effectuée"));
						$this->message->set(sprintf(_("%1s poissons importés, dont %2s poissons mis à jour"), $import->recorded, $import->updated));
						$this->message->set(sprintf(_("Id min traité ou généré : %1s, Id max : %2s"), $import->idMin, $import->idMax));
						$log->setLog($_SESSION["login"],"importDeclarationsCSV", "declaration_id from ".$import->idMin. " to ".$import->idMax);
						}
						$module_coderetour = 1;
					} catch (Exception $e) {
						if ($bdd->inTransaction()) {
							$bdd->rollBack();
						}
						$module_coderetour = -1;
						$this->message->set($e->getMessage(), true);
					}
				} else {
					$this->message->set(_("Le fichier n'est plus disponible dans le serveur : recommencez l'opération"), true);
					$module_coderetour = -1;
				}
			} else {
				$module_coderetour = -1;
				$this->message->set(_("Une erreur s'est produite, recommencez l'opération"), true);
			}
			]	
}
