<?php

namespace App\Libraries;

use App\Models\Event as ModelsEvent;
use App\Models\Param;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Event extends PpciLibrary
{
	/**
	 * @var ModelsEvent
	 */
	protected PpciModel $dataClass;

	function __construct()
	{
		parent::__construct();
		$this->dataClass = new ModelsEvent();
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
		try {
			$this->id = $this->$this->dataWrite($_REQUEST);
			$_REQUEST["event_id"] = $this->id;
			return $declaration->display();
		} catch (PpciException $e) {
			$this->message->set($e->getMessage(), true);
			return $this->change();
		}
	}
	function delete()
	{
		try {
			$this->dataDelete($this->id);
			$declaration = new Declaration();
			return $declaration->display();
		} catch (PpciException $e) {
			return $this->change();
		}
	}
}
