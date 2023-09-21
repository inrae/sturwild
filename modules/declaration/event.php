<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/event.class.php';
$dataClass = new Event($bdd,$ObjetBDDParam);
$keyName = "event_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "declaration/eventChange.tpl", $_REQUEST["declaration_id"]);
		/*
		 * Lecture de la table des types d'event
		 */
		require_once "modules/classes/param.class.php";
		$event_type = new Param($bdd, "event_type");
		$vue->set ( $event_type->getListe(1), "event_type" );
		
		break;
	case "write":
		/*
		 * write record in database
		 */
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id >= 0) 
			$_REQUEST[$keyName] = $id;
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
}

?>