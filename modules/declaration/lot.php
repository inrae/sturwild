<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/individu.class.php';
$dataClass = new Lot($bdd,$ObjetBDDParam);
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
			$data["nombre_capture"] = 1;
			$data[$keyName] = $id;
			$smarty->assign("data", $data);
		}
		/*
		 * Lecture des tables de parametre
		*/
		$espece = new Espece($bdd, $ObjetBDDParam);
		$smarty->assign("espece", $espece->getListe(2));
		$devenir = new Devenir($bdd, $ObjetBDDParam);
		$smarty->assign("devenir", $devenir->getListe(1));
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