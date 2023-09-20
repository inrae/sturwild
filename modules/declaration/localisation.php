<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/location.class.php';
$dataClass = new Location($bdd,$ObjetBDDParam);
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
			$vue->set ( $data, "data" );

		}
		/**
		 * Lecture des tables de parametre
		 */
		$ices = new Ices($bdd, $ObjetBDDParam);
		$vue->set ( $ices->getListe(2), "ices" );

		$country = new Country($bdd, $ObjetBDDParam);
		$vue->set ( $country->getListe(3), "country" );

		$environment = new Environment($bdd, $ObjetBDDParam);
		$vue->set ( $environment->getListe(2), "environment" );

		$environmentDetail = new EnvironmentDetail($bdd, $ObjetBDDParam);
		$vue->set ( $environmentDetail->getListe(2), "environment_detail" );
		require_once "modules/classes/accuracy.class.php";
		$accuracy = new Accuracy($bdd, $ObjetBDDParam);
		$vue->set($accuracy->getListe(1), "accuracys");
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
