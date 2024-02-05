<?php
include_once 'modules/classes/status.class.php';
$dataClass = new Status ( $bdd, $ObjetBDDParam );
$keyName = "status_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set ( $dataClass->getListe(2), "data" );
		$vue->set ( "param/statusList.tpl", "corps" );
		
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "param/statusChange.tpl" );
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
}