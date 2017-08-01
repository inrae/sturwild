<?php
include_once 'modules/classes/localisation.class.php';
$dataClass = new Ciem ( $bdd, $ObjetBDDParam );
$keyName = "ciem_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$smarty->assign ( "data", $dataClass->getListe(2) );
		$smarty->assign ( "corps", "param/ciemList.tpl" );
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "param/ciemChange.tpl" );
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
?>