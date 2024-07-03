<?php

namespace App\Libraries;

use App\Models\Status as ModelsStatus;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Status extends PpciLibrary
{

	protected ModelsStatus $dataClass;

	function __construct()
	{
		parent::__construct();
		$this->dataClass = new ModelsStatus();
		$keyName = "status_id";
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
		$this->vue->set($this->dataClass->getList(2), "data");
		$this->vue->set("param/statusList.tpl", "corps");
		$this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataread($this->dataClass, $this->id, "param/statusChange.tpl");
		$this->vue->send();
	}
	function write()
	{
		try {
            $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST["status_id"] = $this->id;
            return $this->list();
        } catch (PpciException $e) {
            return $this->change();
        }
	}
}
