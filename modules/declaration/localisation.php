<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/localisation.class.php';
$dataClass = new Localisation($bdd,$ObjetBDDParam);
$keyName = "declaration_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		$data = dataRead($dataClass, $id, "declaration/localisationChange.tpl");
		if ($data[$keyName] == "") {
			$data[$keyName] = $id;
			$smarty->assign("data", $data);
		}
		/*
		 * Lecture des tables de parametre
		 */
		$ciem = new Ciem($bdd, $ObjetBDDParam);
		$smarty->assign("ciem", $ciem->getListe(2));
		$pays = new Pays($bdd, $ObjetBDDParam);
		$smarty->assign("pays", $pays->getListe(3));
		$region = new Region($bdd, $ObjetBDDParam);
		$smarty->assign("region", $region->getListe(2));
		$milieu = new Milieu($bdd, $ObjetBDDParam);
		$smarty->assign("milieu", $milieu->getListe(2));
		$milieuDetail = new MilieuDetail($bdd, $ObjetBDDParam);
		$smarty->assign("milieu_detail", $milieuDetail->getListe(2));
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