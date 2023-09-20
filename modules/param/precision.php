<?php
include_once 'modules/classes/accuracy.class.php';
$dataClass = new Accuracy ( $bdd, $ObjetBDDParam );
$keyName = "accuracy_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		$vue->set ( $dataClass->getListe(), "data" );
		$vue->set ( "param/accuracyList.tpl", "corps" );
		break;
	case "change":
		dataRead ( $dataClass, $id, "param/accuracyChange.tpl" );
		break;
	case "write":
		dataWrite ( $dataClass, $_REQUEST );
		break;
	case "delete":
		dataDelete ( $dataClass, $id );
		break;
}
