<?php

namespace App\Libraries;

use App\Models\Declaration;
use App\Models\Institute as ModelsInstitute;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Institute extends PpciLibrary
{

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new ModelsInstitute();
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
		$this->vue->set($this->dataclass->getList(), "data");
		$this->vue->set("param/instituteList.tpl", "corps");
		$this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataread( $this->id, "param/instituteChange.tpl");
		$this->vue->set($this->dataclass->getAllGroupsFromInstitute($this->id), "groups");
		/**
		 * Search if the institute can be deleted
		 */
		$declaration = new Declaration;
		if ($declaration->getNbDeclarationsByInstitute($this->id) == 0 ) {
			$this->vue->set(1,"canBeDeleted");
		} else {
			$this->vue->set(0,"canBeDeleted");
		}
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
