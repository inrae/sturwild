<?php

namespace App\Libraries;

use App\Models\Document;
use App\Models\Fish as ModelsFish;
use App\Models\FishImport;
use App\Models\Param;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Fish extends PpciLibrary
{
	/**
	 * @var ModelsFish
	 */
	protected PpciModel $dataClass;

	function __construct()
	{
		parent::__construct();
		$this->dataClass = new ModelsFish();
		$keyName = "fish_id";
		if (isset($_REQUEST[$keyName])) {
			$this->id = $_REQUEST[$keyName];
		}
	}

	function change()
	{
		$this->vue = service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead($this->id, "declaration/fishChange.tpl", $_REQUEST["declaration_id"]);
		/*
		 * Lecture des tables de parametre
		 */
		$species = new Param('species');
		$this->vue->set($species->getListe(2), "species");
		$fate = new Param("fate");
		$this->vue->set($fate->getListe(1), "fate");
		$tag_presence = new Param("tag_presence");
		$this->vue->set($tag_presence->getListe(1), "tag_presence");
		$captureEtat = new Param("capture_state");
		$this->vue->set($captureEtat->getListe(2), "capture_state");

		/**
		 * Handlings
		 */
		$this->vue->set($this->dataClass->getHandlings($this->id), "handlings");
		/**
		 * Documents
		 */
		if ($this->id > 0) {
			$document = new Document();
			try {
				$this->vue->set($document->getListFromFish($this->id), "dataDoc");
			} catch (PpciException $de) {
				$this->message->set(_("Problème(s) rencontré(s) pour afficher les photos ou documents. Contactez l'administrateur du système."), true);
				$this->message->setSyslog($de->getMessage());
			}
		}
		$this->vue->send();
	}
	function write()
	{
		/*
		 * write record in database
		 */
		$this->id = $this->dataWrite($_REQUEST);
		if ($this->id > 0) {
			$_REQUEST["fish_id"] = $this->id;

			/*
			 * Treatment of pictures
			 */
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
			$declaration = new Declaration;
			return $declaration->display();
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
			$declaration = new Declaration;
			return $declaration->display();
		} catch (PpciException $e) {
			return $this->change();
		}
	}
	function documentDelete()
	{
		/*
		 * Supprime le document
		 */
		$document = new Document();
		$document->dataDelete($document, $_REQUEST["document_id"]);
		$declaration = new Declaration;
		return $declaration->display();
	}
	function export()
	{
		/*
		 * Exporte la liste des poissons au format CSV
		 */
		$this->vue = service('CsvView');
		$_SESSION["searchDeclaration"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchDeclaration"]->getParam();
		if ($_SESSION["searchDeclaration"]->isSearch() == 1) {
			$this->vue->setFilename("sturwild_fish-" . date('d-m-Y') . ".csv");
			$this->vue->setDelimiter("tab");
			$this->vue->set($this->dataClass->getDataToExport($dataSearch));
			$this->vue->send();
		} else {
			$declaration = new Declaration;
			return $declaration->list();
		}
	}
	function exportCSV()
	{
		if (isset($_POST["declaration_ids"]) && count($_POST["declaration_ids"]) > 0) {
			$data = $this->dataClass->getDataForExport($_POST["declaration_ids"], $_POST["use_exchange_labels"]);
			if (!empty($data)) {
				$this->vue->setFilename("sturwild_fishes-" . date('Y-m-d') . ".csv");
				$this->vue->setDelimiter(",");
				$this->vue->set($data);
			} else {
				unset($this->vue);
				$this->message->set(_("Aucune des déclarations sélectionnées ne peut être exportée : elles doivent avoir été validées au préalable"), true);
				$declaration = new Declaration;
				return $declaration->list();
			}
		} else {
			unset($this->vue);
			$this->message->set(_("Aucune déclaration n'a été sélectionnée"), true);
			$declaration = new Declaration;
			return $declaration->list();
		}
	}
	function csvExec()
	{
		if (isset($_SESSION["importParameters"])) {
			if (file_exists($_SESSION["importParameters"]["filename"])) {
				try {
					/**
					 * Initialize classes
					 */
					$import = new FishImport;
					$import->declaration = new Declaration();
					$import->fish = new Fish();
					$import->initFileCSV($_SESSION["importParameters"]["filename"], $_SESSION["importParameters"]["separator"], $_SESSION["importParameters"]["utf8_encode"]);
					$import->initParams();
					$import->exec($_SESSION["importParameters"]["use_exchange_labels"]);
					if ($import->recorded == 0) {
						$this->message->set(_("Aucun poisson n'a été importé dans la base de données. Il est possible qu'un problème technique soit survenu"), true);
					} else {
						$this->message->set(_("Importation effectuée"));
						$this->message->set(sprintf(_("%1s poissons importés, dont %2s poissons mis à jour"), $import->recorded, $import->updated));
						$this->message->set(sprintf(_("Id min traité ou généré : %1s, Id max : %2s"), $import->idMin, $import->idMax));
						$this->log->setLog($_SESSION["login"], "importDeclarationsCSV", "declaration_id from " . $import->idMin . " to " . $import->idMax);
					}
					$declaration = new Declaration;
					return $declaration->list();
				} catch (\Exception $e) {
					$this->message->set($e->getMessage(), true);
					$declaration = new Declaration;
					return $declaration->list();
				}
			} else {
				$this->message->set(_("Le fichier n'est plus disponible dans le serveur : recommencez l'opération"), true);
				$declaration = new Declaration;
				return $declaration->list();
			}
		} else {
			$this->message->set(_("Une erreur s'est produite, recommencez l'opération"), true);
			$declaration = new Declaration;
			return $declaration->list();
		}
	}
}
