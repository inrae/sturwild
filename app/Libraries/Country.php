<?php

namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Country extends PpciLibrary
{
	protected PpciModel $dataclass;

	function __construct()
	{
		parent::__construct();
		$this->dataClass = new \App\Models\Country();
		$keyName = "country_id";
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
		$this->vue->set($this->dataClass->getListe(3), "data");
		$this->vue->set("param/countryList.tpl", "corps");
	}
	function change()
	{
		$this->vue = service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataread($this->id, "param/countryChange.tpl");
	}
	function write()
	{
		$this->dataWrite($_REQUEST);
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
