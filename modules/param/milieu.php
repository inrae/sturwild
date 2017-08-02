<?php
include_once 'modules/classes/localisation.class.php';
$dataClass = new Milieu( $bdd, $ObjetBDDParam );
$keyName = "milieu_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set ( $dataClass->getListe(2), "data" );
		$vue->set ( "param/milieuList.tpl", "corps" );
		
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "param/milieuChange.tpl");
		break;
	case "write":
		dataWrite ( $dataClass, $_REQUEST );
		break;
	case "delete":
		dataDelete ( $dataClass, $id );
		break;
}
?>