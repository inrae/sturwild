<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 24 sept. 2015
 */
 
include_once 'modules/classes/declaration.class.php';
$dataClass = new Capture_etat( $bdd, $ObjetBDDParam );
$keyName = "capture_etat_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$vue->set ( $dataClass->getListe(2), "data" );
		$vue->set ( "param/captureEtatList.tpl", "corps" );
		
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "param/captureEtatChange.tpl" );
		break;
	case "write":
		dataWrite ( $dataClass, $_REQUEST );
		break;
	case "delete":
		dataDelete ( $dataClass, $id );
		break;
}
?>