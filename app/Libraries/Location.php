<?php 
namespace App\Libraries;

use App\Models\Country;
use App\Models\Ices;
use App\Models\Location as ModelsLocation;
use App\Models\Param;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Location extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $dataClass;

    function __construct()
    {
        parent::__construct();
        $this->dataClass = new ModelsLocation();
        $keyName = "declaration_id";
        if (isset($_REQUEST[$keyName])) {
            $this->id = $_REQUEST[$keyName];
        }
    }

	function change(){
$this->vue=service('Smarty');
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = $this->dataRead( $this->id, "declaration/locationChange.tpl");
		$data["declaration_id"] = $this->id;
		/**
		 * Lecture des tables de parametre
		 */
		$ices = new Ices();
		$this->vue->set($ices->getListe(2), "ices");

		$country = new Country();
		$this->vue->set($country->getListe(3), "country");
		$environment = new Param( "environment");
		$this->vue->set($environment->getListe(2), "environment");

		$environmentDetail = new Param("environment_detail");
		$this->vue->set($environmentDetail->getListe(2), "environment_detail");

		$accuracy = new Param( "accuracy");
		$this->vue->set($accuracy->getListe(1), "accuracys");

		/**
		 * Map
		 */
		//$this->vue->set($MAPS_url, "MAPS_url");
        //$this->vue->set($MAPS_enabled, "MAPS_enabled");
		$this->vue->set($data,"location");
		$this->vue->set("1","mapIsChange");
		$this->vue->send();
		}
	function write(){
		try {
            $this->dataWrite($_REQUEST);
            $declaration = new Declaration;
			return $declaration->display();
        } catch (PpciException $e) {
            return $this->change();
        }
	}
}