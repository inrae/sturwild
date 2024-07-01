<?php

namespace App\Models;

use Ppci\Models\PpciModel;

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
class Fish extends PpciModel
{
	public Declaration $declaration;
	public Document $document;
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	public function __construct()
	{
		$this->table = "fish";

		$this->fields = array(
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
			"tag_presence_id" => array(
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

		parent::__construct();
	}
	function supprimer($id)
	{
		/*
		 * Recherche les pieces jointes attachees, et les supprime
		 */
		if (!isset($this->document)) {
			$this->document = $this->classInstanciate("Document", "document.class.php");
		}
		$this->document->deleteFromField($id, "fish_id");
		$this->ecrireTableNN("fish_handling", "fish_id", "handling_id", $id, array());
		return parent::supprimer($id);
	}
	/**
	 * Surcharge de la fonction ecrire pour rajouter l'etat de la declaration dans le lot
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write(array $data): int
	{
		$id = parent::write($data);
		/**
		 * Add the handlings
		 */
		$this->ecrireTableNN("fish_handling", "fish_id", "handling_id", $id, $data["handlings"]);

		/*
		 * Recherche si l'etat du lot a ete renseigne
		 */
		if (!isset($this->declaration)) {
			$this->declaration = new Declaration();
		}
		$dataDecl = $this->declaration->lire($data["declaration_id"]);
		if ($dataDecl["declaration_id"] > 0 && strlen($dataDecl["capture_state_id"]) == 0 && $data["capture_state_id"] > 0) {
			$dataDecl["capture_state_id"] = $data["capture_state_id"];
			$this->declaration->ecrire($dataDecl);
		}
		return $id;
	}

	/**
	 * Retourne la liste des fishs rattaches a une declaration
	 *
	 * @param int $id
	 * @return array
	 */
	function getListeFromDeclaration(int $id)
	{
		$sql = "select * from fish
					left outer join species using (species_id)
					left outer join fate using (fate_id)
					left outer join tag_presence using (tag_presence_id)
					left outer join capture_state using (capture_state_id)
					left outer join v_fish_handlings using (fish_id)
					where declaration_id = :declaration_id:
					order by fish_id";
		return $this->getListeParamAsPrepared($sql, array("declaration_id" => $id));
	}
	/**
	 * Recherche les poissons associes aux declarations correspondant aux parametres fournis
	 *
	 * @param array $param
	 * @return array
	 */
	function getDataToExport(array $param)
	{
		/*
		 * Lecture des identifiants des declarations
		 */
		if (!isset($this->declaration)) {
			$this->declaration = new Declaration();
		}
		$declarations = $this->declaration->getIdFromParam($param);
		if (count($declarations) > 0) {
			$sql = "select fish.*,
				tag_presence_name, species_name, capture_state_name, fate_name";
			$from = " from fish
				left outer join species using (species_id )
				left outer join capture_state using (capture_state_id)
				left outer join tag_presence using (tag_presence_id)
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
		} else {
			return array();
		}
	}

	/**
	 * Get the list of handlings attached or not to a fish
	 *
	 * @param int $fish_id
	 * @return array
	 */
	function getHandlings($fish_id)
	{
		$sql = "select h.handling_id, handling_name, 
            case when fish_id is not null then 1 else 0 end as is_selected
            from handling h
            left outer join fish_handling fh on (h.handling_id = fh.handling_id and fh.fish_id = :fish_id:)
            order by handling_order";
		return $this->getListeParamAsPrepared($sql, array("fish_id" => $fish_id));
	}

	function getDataForExport(array $ids, bool $withExchangeLabel = true, bool $withParentIdentifier = true, bool $searchParentByUuid = false): array
	{
		$data = array();
		if (count($ids) > 0) {
			$localCode = $_SESSION["APPLI_code"];
			$withExchangeLabel ? $suffix = "_exchange" : $suffix = "_name";
			$withParentIdentifier ? $parentIdentifier = ", declaration_uuid, case when origin_identifier is not null then origin_identifier else '$localCode' || ':' || declaration_id::varchar end as origin_identifier" : $parentIdentifier = "";
			$sql = "select fish_uuid, species$suffix, tag_presence$suffix, capture_state$suffix, fate$suffix, weight, handlings$suffix
			,tag_number, fish_length, estimated_cohort, validated_cohort, background
			,f.handling ,f.remarks, f.identification_quality
			$parentIdentifier
			from fish f
			join declaration using (declaration_id)
			left outer join species s on  (f.species_id = s.species_id)
			left outer join fate fa on (f.fate_id = fa.fate_id)
			left outer join capture_state cs on (f.capture_state_id = cs.capture_state_id)
			left outer join tag_presence using (tag_presence_id)
			left outer join v_fish_handlings using (fish_id)
			";
			if ($searchParentByUuid) {
				$where = " where declaration_uuid in (";
			} else {
				$where = " where declaration_id in (";
			}
			$comma = "";
			$i = 1;
			$param = array();
			foreach ($ids as $id) {
				$where .= $comma . ":id$i:";
				$param["id$i"] = $id;
				$comma = ",";
				$i++;
			}
			$where .= ") and (status_id >= 3 )";
			$order = " order by declaration_id";
			$data = $this->getListeParamAsPrepared($sql . $where . $order, $param);
		}
		return $data;
	}
	/**
	 * Get the id of a fish from UUID
	 *
	 * @param string $uuid
	 * @return int
	 */
	function getIdByUUID(string $uuid): int
	{
		$id = 0;
		if (!empty($uuid)) {
			$sql = "select fish_id from fish where fish_uuid = :uuid:";
			$data = $this->lireParamAsPrepared($sql, array("uuid" => $uuid));
			if ($data["fish_id"] > 0) {
				$id = $data["fish_id"];
			}
		}
		return $id;
	}
}
