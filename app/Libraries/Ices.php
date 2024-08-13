<?php

namespace App\Libraries;

use App\Models\Ices as ModelsIces;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Ices extends PpciLibrary
{
	function __construct()
	{
		parent::__construct();
		$this->dataClass = new ModelsIces();
		$keyName = "ices_id";
		if (isset($_REQUEST[$keyName])) {
			$this->id = $_REQUEST[$keyName];
		}
	}

	function list()
	{
		$this->vue = service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		$this->vue->set($this->dataClass->getListe(2), "data");
		$this->vue->set("param/icesList.tpl", "corps");
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataread( $this->id, "param/icesChange.tpl");
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST["ices_id"] = $this->id;
			return $this->list();
		} catch (PpciException $e) {
			return $this->change();
		}
	}
	function delete()
	{
		try {
			$this->dataDelete($this->id);
			return $this->list();
		} catch (PpciException $e) {
			return $this->change();
		}
	}
}
