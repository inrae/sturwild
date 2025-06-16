<?php

namespace App\Libraries;

use App\Models\Event as ModelsEvent;
use App\Models\Param;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;
use App\Models\Declaration as ModelsDeclaration;

class Event extends PpciLibrary
{
	/**
	 * @var ModelsEvent
	 */
	protected PpciModel $dataclass;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsEvent();
		$keyName = "event_id";
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
		$this->dataRead($this->id, "declaration/eventChange.tpl", $_REQUEST["declaration_id"]);
		/*
		 * Lecture de la table des types d'event
		 */
		$event_type = new Param("event_type");
		$this->vue->set($event_type->getListe(1), "event_type");
		return $this->vue->send();
	}
	function write()
	{
		$declaration = new Declaration();
		$decl = new ModelsDeclaration;
		if (!$decl->isGranted($_REQUEST["declaration_id"])) {
			$this->message->set(_("Vous ne disposez pas des droits nécessaires pour modifier cet événement"), true);
			return $declaration->display();
		}
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST["event_id"] = $this->id;
			return $declaration->display();
		} catch (PpciException $e) {
			$this->message->set($e->getMessage(), true);
			return $this->change();
		}
	}
	function delete()
	{
		$declaration = new Declaration();
		try {
			$decl = new ModelsDeclaration;
			if (!$decl->isGranted($_REQUEST["declaration_id"])) {
				$this->message->set(_("Vous ne disposez pas des droits nécessaires pour supprimer cet événement"), true);
				return $declaration->display();
			}
			$this->dataDelete($this->id);
		} catch (PpciException $e) {
			return $this->change();
		}
	}
}
