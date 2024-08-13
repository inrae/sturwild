<?php

namespace App\Libraries;

use App\Models\Param as ModelsParam;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;

class Param extends PpciLibrary
{
	protected $tablename;
	protected $keyName;
	function __construct($tablename)
	{
		parent::__construct();
		$this->tablename = $tablename;
		$this->dataClass = new ModelsParam($tablename);
		$this->keyName = $tablename . "_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function generateSet()
	{
		$this->vue->set($this->tablename . "_id", "fieldid");
		$this->vue->set($this->tablename . "_name", "fieldname");
		$this->vue->set($this->tablename . "_code", "fieldcode");
		$this->vue->set($this->tablename . "_exchange", "fieldexchange");
		$this->vue->set($this->dataClass->getDescription(), "tabledescription");
		$this->vue->set($this->tablename, "tablename");
		$this->vue->set($this->tablename . "_order", "fieldorder");
	}
	function list()
	{
		$this->vue = service('Smarty');
		$this->vue->set($this->dataClass->getParams(), "data");
		$this->vue->set("param/paramList.tpl", "corps");
		$this->generateSet();
		return $this->vue->send();
	}

	function change()
	{
		$this->vue = service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record 
		 */
		$this->dataRead($this->id, "param/paramChange.tpl");
		$this->generateSet();
		return $this->vue->send();
	}
	function write()
	{
		/*
		 * write record in database
		 */
		try {
			$this->id = $this->dataWrite($_REQUEST);
			$_REQUEST[$this->keyName] = $this->id;
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
