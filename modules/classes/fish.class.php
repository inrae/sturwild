<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 août 2015
 */

/**
 * ORM de gestion de la table fish
 *
 * @author quinton
 *
 */
class Fish extends ObjetBDD
{
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL)
	{
		if (!is_array($param))
			$param = array();
		$this->paramori = $param;
		$this->table = "fish";
		$this->id_auto = 1;
		$this->colonnes = array(
			"fish_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1,
				"defaultValue" => 0
			),
			"declaration_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"species_id" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"presence_tag_d" => array(
				"type" => 1
			),
			"fate_id" => array(
				"type" => 1
			),
			"capture_state_id" => array(
				"type" => 1
			),
			"weight" => array(
				"type" => 1
			),
			"handling" => array(
				"type" => 0
			),
			"tag_number" => array(
				"type" => 0
			),
			"fish_length" => array(
				"type" => 1
			),
			"estimated_cohort" => array(
				"type" => 1
			),
			"validated_cohort" => array(
				"type" => 1
			),
			"background" => array(
				"type" => 0
			),
			"remarks" => array(
				"type" => 0
			),
			"identification_quality" => array(
				"type" => 1
			)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}
	function supprimer($id)
	{
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Recherche les pieces jointes attachees, et les supprime
			 */
			require_once 'modules/classes/document.class.php';
			$document = new Document($this->connection, $this->paramori);
			$document->deleteFromField($id, "fish_id");
			return parent::supprimer($id);
		}
	}
	/**
	 * Surcharge de la fonction ecrire pour rajouter l'etat de la declaration dans le lot
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data)
	{
		$id = parent::ecrire($data);
		if ($id > 0 && is_numeric($data["declaration_id"])) {
			/*
			 * Recherche si l'etat du lot a ete renseigne
			 */
			require_once 'modules/classes/declaration.class.php';
			$declaration = new Declaration($this->connection, $this->paramori);
			$dataDecl = $declaration->lire($data["declaration_id"]);
			if ($dataDecl["declaration_id"] > 0 && strlen($dataDecl["capture_state_id"]) == 0 && $data["capture_state_id"] > 0) {
				$dataDecl["capture_state_id"] = $data["capture_state_id"];
				$declaration->ecrire($dataDecl);
			}
		}
		return $id;
	}

	/**
	 * Retourne la liste des fishs rattaches a une declaration
	 *
	 * @param int $id
	 * @return tableau|NULL
	 */
	function getListeFromDeclaration($id)
	{
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from fish
					left outer join species using (species_id)
					left outer join fate using (fate_id)
					left outer join tag_presence using (presence_tag_d)
					left outer join capture_state using (capture_state_id)
					where declaration_id = :declaration_id
					order by fish_id";
			return $this->getListeParamAsPrepared($sql, array("declaration_id" => $id));
		} else
			return null;
	}
	/**
	 * Recherche les poissons associes aux declarations correspondant aux parametres fournis
	 *
	 * @param unknown $param
	 * @return tableau
	 */
	function getDataToExport($param)
	{
		/*
		 * Lecture des identifiants des declarations
		 */
		require_once 'modules/classes/declaration.class.php';
		$declaration = new Declaration($this->connection, $this->paramori);
		$declarations = $declaration->getIdFromParam($param);
		if (count($declarations) > 0) {
			$sql = "select fish.*,
				tag_presence_name, species_name, capture_state_name, fate_name";
			$from = " from fish
				left outer join species using (species_id )
				left outer join capture_state using (capture_state_id)
				left outer join tag_presence using (presence_tag_d)
				left outer join fate using (fate_id)
				";
			/*
			 * Preparation de la clause where
			 */

			$first = true;
			$dataWhere = "";
			foreach ($declarations as $value) {
				$first == true ? $first = false : $dataWhere .= ", ";
				$dataWhere .= $value["declaration_id"];
			}
			$where = " where declaration_id in ($dataWhere)";
			$order = " order by declaration_id, fish_id";
			/*
			 * Traitement de la commande
			 */
			return $this->getListeParam($sql . $from . $where . $order);
		}
	}
}
