<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 août 2015
 */

include_once 'modules/classes/individu.class.php';
$dataClass = new Devenir( $bdd, $ObjetBDDParam );
$keyName = "devenir_id";
$id = $_REQUEST [$keyName];

switch ($t_module ["param"]) {
	case "list":
		/*
		 * Display the list of all records of the table
		 */
		$smarty->assign ( "data", $dataClass->getListe(2) );
		$smarty->assign ( "corps", "param/devenirList.tpl" );
		break;
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead ( $dataClass, $id, "param/devenirChange.tpl" );
		break;
	case "write":
		dataWrite ( $dataClass, $_REQUEST );
		break;
	case "delete":
		dataDelete ( $dataClass, $id );
		break;
}
?>
