<?php

namespace App\Libraries;

use App\Models\Institute as ModelsInstitute;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Institute extends PpciLibrary
{

	function __construct()
	{
		parent::__construct();
		$this->dataClass = new ModelsInstitute();
		$keyName = "institute_id";
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
		$this->vue->set("param/instituteList.tpl", "corps");
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
		$this->dataread( $this->id, "param/instituteChange.tpl");
		$this->vue->send();
	}
	function write()
	{
		try {
            $this->id = $this->dataWrite($_REQUEST);
            $_REQUEST["institute_id"] = $this->id;
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
