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
			$vue->set ( $data, "data" );
			
		}
		/*
		 * Lecture des tables de parametre
		 */
		$ciem = new Ciem($bdd, $ObjetBDDParam);
		$vue->set ( $ciem->getListe(2), "ciem" );
		
		$pays = new Pays($bdd, $ObjetBDDParam);
		$vue->set ( $pays->getListe(3), "pays" );
		
		$region = new Region($bdd, $ObjetBDDParam);
		$vue->set ( $region->getListe(2), "region" );
		
		$milieu = new Milieu($bdd, $ObjetBDDParam);
		$vue->set ( $milieu->getListe(2), "milieu" );
		
		$milieuDetail = new MilieuDetail($bdd, $ObjetBDDParam);
		$vue->set ( $milieuDetail->getListe(2), "milieu_detail" );
		
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