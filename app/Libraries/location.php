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
include_once 'modules/classes/location.class.php';
$this->dataClass = new Location();
$keyName = "declaration_id";
$this->id = $_REQUEST[$keyName];


	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead( $this->id, "declaration/locationChange.tpl");
		if ($data[$keyName] == "") {
			$data[$keyName] = $this->id;
			$this->vue->set($data, "data");

		}
		/**
		 * Lecture des tables de parametre
		 */
		require_once "modules/classes/ices.class.php";
		$ices = new Ices();
		$this->vue->set($ices->getListe(2), "ices");

		$country = new Country();
		$this->vue->set($country->getListe(3), "country");
		require_once "modules/classes/param.class.php";
		$environment = new Param($bdd, "Environment");
		$this->vue->set($environment->getListe(2), "environment");

		$environmentDetail = new Param($bdd, "environment_detail");
		$this->vue->set($environmentDetail->getListe(2), "environment_detail");

		$accuracy = new Param($bdd, "accuracy");
		$this->vue->set($accuracy->getListe(1), "accuracys");

		/**
		 * Map
		 */
		$this->vue->set($MAPS_url, "MAPS_url");
        $this->vue->set($MAPS_enabled, "MAPS_enabled");
		$this->vue->set($data,"location");
		$this->vue->set("1","mapIsChange");
		]
	function write(){
		/*
		 * write record in database
		 */
		$this->id = $this->dataWrite( $_REQUEST);
		if ($this->id >= 0) {
			$_REQUEST[$keyName] = $this->id;
		}
		]
}