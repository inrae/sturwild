<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 août 2015
 */
include_once 'modules/classes/evenement.class.php';
$dataClass = new Evenement($bdd,$ObjetBDDParam);
$keyName = "evenement_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
	case "change":
		/*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
		dataRead($dataClass, $id, "declaration/evenementChange.tpl", $_REQUEST["declaration_id"]);
		/*
		 * Lecture de la table des types d'evenement
		 */
		$evenement_type = new Evenement_type($bdd, $ObjetBDDParam);
		$smarty->assign("evenement_type", $evenement_type->getListe(1));
		break;
	case "write":
		/*
		 * write record in database
		 */
		/*
		 * Recherche le statut initial de la declaration
		 */
		require_once 'modules/classes/declaration.class.php';
		$declaration_id = $_REQUEST["declaration_id"];
		if ($declaration_id == 0) {
			$statutOld = 0;
		} else {
			$declaration = new Declaration($bdd, $ObjetBDDParam);
			$dataStatut = $declaration->lire ( $id );
			$statutOld = $dataStatut ["statut_id"];
		}
		$id = dataWrite($dataClass, $_REQUEST);
		if ($id >= 0) {
			$_REQUEST[$keyName] = $id;
			/*
			 * Traitement du changement de statut : envoi d'un message si le statut vaut 3 ou 4
			 */
			if (($_REQUEST ["evenement_type_id"] == 3 || $_REQUEST ["evenement_type_id"] == 4) && statutOld != $_REQUEST ["evenement_type_id"]) {
				sendMail($declaration_id);
			}
				
		}
		break;
	case "delete":
		/*
		 * delete record
		 */
		dataDelete($dataClass, $id);
		break;
}

?>