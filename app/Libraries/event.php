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
include_once 'modules/classes/event.class.php';
$this->dataClass = new Event($bdd,$ObjetBDDParam);
$keyName = "event_id";
$this->id = $_REQUEST[$keyName];


	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$this->dataRead( $this->id, "declaration/eventChange.tpl", $_REQUEST["declaration_id"]);
		/*
		 * Lecture de la table des types d'event
		 */
		require_once "modules/classes/param.class.php";
		$event_type = new Param($bdd, "event_type");
		$this->vue->set ( $event_type->getListe(1), "event_type" );
		
		]
	function write(){
		/*
		 * write record in database
		 */
		$this->id = $this->dataWrite( $_REQUEST);
		if ($this->id >= 0) 
			$_REQUEST[$keyName] = $this->id;
		]
	function delete(){
		/*
		 * delete record
		 */
		$this->dataDelete( $this->id);
		]
}

?>