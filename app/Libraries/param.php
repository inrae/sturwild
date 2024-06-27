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
$tablename = $t_module["tablename"];
include_once 'modules/classes/param.class.php';
$this->dataClass = new Param($bdd, $tablename);
$keyName = $tablename . "_id";
$this->id = $_REQUEST[$keyName];
$description = $t_module["tabledescription"];

if (!function_exists("generateSet")) {
	function generateSet($this->vue, $tablename, $description)
	{
		$this->vue->set($tablename . "_id", "fieldid");
		$this->vue->set($tablename . "_name", "fieldname");
		$this->vue->set($tablename . "_code", "fieldcode");
		$this->vue->set($tablename."_exchange", "fieldexchange");
		$this->vue->set(_($description), "tabledescription");
		$this->vue->set($tablename, "tablename");
		$this->vue->set($tablename."_order", "fieldorder");
	}
}


	function list(){
$this->vue=service('Smarty');
		$this->vue->set($this->dataClass->getParams(), "data");
		$this->vue->set("param/paramList.tpl", "corps");
		generateSet($this->vue, $tablename, $description);
		]
	function display(){
$this->vue=service('Smarty');

		]
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record 
		 */
		$this->dataRead( $this->id, "param/paramChange.tpl");
		generateSet($this->vue, $tablename, $description);
		]
	function write(){
		/*
		 * write record in database
		 */
		$this->id = $this->dataWrite( $_REQUEST);
		if ($this->id > 0) {
			$_REQUEST[$keyName] = $this->id;
		}
		]
	function delete(){
		/*
		 * delete record
		 */
		$this->dataDelete( $this->id);
		]
}
