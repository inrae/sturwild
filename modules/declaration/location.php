<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/location.class.php';
$dataClass = new Location($bdd, $ObjetBDDParam);
$keyName = "declaration_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "declaration/locationChange.tpl");
		if ($data[$keyName] == "") {
			$data[$keyName] = $id;
			$vue->set($data, "data");

		}
		/**
		 * Lecture des tables de parametre
		 */
		$ices = new Ices($bdd, $ObjetBDDParam);
		$vue->set($ices->getListe(2), "ices");

		$country = new Country($bdd, $ObjetBDDParam);
		$vue->set($country->getListe(3), "country");
		require_once "modules/classes/param.class.php";
		$environment = new Param($bdd, "Environment");
		$vue->set($environment->getListe(2), "environment");

		$environmentDetail = new Param($bdd, "environment_detail");
		$vue->set($environmentDetail->getListe(2), "environment_detail");

		$accuracy = new Param($bdd, "accuracy");
		$vue->set($accuracy->getListe(1), "accuracys");

		/**
		 * Map
		 */
		$vue->set($MAPS_url, "MAPS_url");
        $vue->set($MAPS_enabled, "MAPS_enabled");
		$vue->set($data,"location");
		$vue->set("1","mapIsChange");
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id >= 0) {
			$_REQUEST[$keyName] = $id;
		}
		break;
}