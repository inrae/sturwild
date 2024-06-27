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
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/lot.class.php';
$this->dataClass = new Lot();
$keyName = "declaration_id";
$this->id = $_REQUEST[$keyName];


	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead( $this->id, "declaration/lotChange.tpl");
		if ($data[$keyName] == "") {
			$data["caught_number"] = 1;
			$data[$keyName] = $this->id;
			$this->vue->set($data, "data");

		}
		/*
		 * Lecture des tables de parametre
		 */
		require_once "modules/classes/param.class.php";
		$species = new Param($bdd, "species");
		$this->vue->set($species->getListe(2), "species");

		$fate = new Param($bdd, "fate");
		$this->vue->set($fate->getListe(1), "fate");

		}
	function write(){
		/*
		 * write record in database
		 */
		$this->id = $this->dataWrite( $_REQUEST);
		if ($this->id >= 0) {
			$_REQUEST[$keyName] = $this->id;
		}
		}
}

?>