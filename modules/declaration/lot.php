<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/lot.class.php';
$dataClass = new Lot($bdd, $ObjetBDDParam);
$keyName = "declaration_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "declaration/lotChange.tpl");
		if ($data[$keyName] == "") {
			$data["caught_number"] = 1;
			$data[$keyName] = $id;
			$vue->set($data, "data");

		}
		/*
		 * Lecture des tables de parametre
		 */
		require_once "modules/classes/param.class.php";
		$species = new Param($bdd, "species");
		$vue->set($species->getListe(2), "species");

		$fate = new Param($bdd, "fate");
		$vue->set($fate->getListe(1), "fate");

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

?>