<?php
include_once 'modules/classes/precision.class.php';
$dataClass = new Precision ( $bdd, $ObjetBDDParam );
$keyName = "precision_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		$vue->set ( $dataClass->getListe(), "data" );
		$vue->set ( "param/precisionList.tpl", "corps" );
		break;
	case "change":
		dataRead ( $dataClass, $id, "param/precisionChange.tpl" );
		break;
	case "write":
		dataWrite ( $dataClass, $_REQUEST );
		break;
	case "delete":
		dataDelete ( $dataClass, $id );
		break;
}
