<?php
include_once 'modules/classes/institute.class.php';
$dataClass = new Institute ( $bdd, $ObjetBDDParam );
$keyName = "institute_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set ( $dataClass->getListe(2), "data" );
		$vue->set ( "param/instituteList.tpl", "corps" );
		
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
        dataRead ( $dataClass, $id, "param/instituteChange.tpl" );
		break;
	case "write":
		/*
		 * Inscrit un enregistrement dans la base
		 */
		if ($id > 0) {
			$_REQUEST [$keyName] = $id;
		}
		dataWrite ( $dataClass, $_REQUEST );
		break;
	case "delete":
		/*
		 * Supprime un enregistrement de la vase
		 */
		dataDelete ( $dataClass, $id );
		break;
}