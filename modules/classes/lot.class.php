<?php
/**
 * ORM de gestion de la table lot
 *
 * @author quinton
 *
 */
class Lot extends ObjetBDD
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
		$this->table = "lot";
		$this->id_auto = 0;
		$this->colonnes = array(
			"declaration_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1
			),
			"species_id" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"fate_id" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"etat_capture_lot" => array(
				"type" => 0
			),
			"caught_number" => array(
				"type" => 1,
				"requis" => 1,
				"defaultValue" => 1
			),
			"longueur_gamme" => array(
				"type" => 0
			),
			"weight_gamme" => array(
				"type" => 0
			),
			"handling" => array(
				"type" => 0
			),
			"identification_quality" => array(
				"type" => 1,
				"defaultValue" => 0
			)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}

	/*
	 * function write($data) {
	 * printr($data);
	 * return parent::ecrire($data);
	 * }
	 */
	/**
	 * Retourne le detail d'un lot
	 *
	 * @param int $id
	 * @return array
	 */
	function getDetail(int $id)
	{
		$sql = "select * from lot
					left outer join species using(species_id)
					left outer join fate using (fate_id)
					where declaration_id = :declaration_id";
		return $this->lireParamAsPrepared($sql, array("declaration_id" => $id));
	}
}
