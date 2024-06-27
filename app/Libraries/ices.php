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
include_once 'modules/classes/ices.class.php';
$this->dataClass = new Ices (  );
$keyName = "ices_id";
$this->id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	function list(){
$this->vue=service('Smarty');
		/*
		 * Display the list of all records of the table
		 */
		$this->vue->set ( $this->dataClass->getListe(2), "data" );
		$this->vue->set ( "param/icesList.tpl", "corps" );
		
		}
	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $this->dataClass, $this->id, "param/icesChange.tpl" );
		}
	function write(){
		/*
		 * Inscrit un enregistrement dans la base
		 */
		if ($this->id > 0) {
			$_REQUEST [$keyName] = $this->id;
		}
		dataWrite ( $this->dataClass, $_REQUEST );
		}
	function delete(){
		/*
		 * Supprime un enregistrement de la vase
		 */
		dataDelete ( $this->dataClass, $this->id );
		}
}
?>