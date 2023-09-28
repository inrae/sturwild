<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 août 2015
 */

/**
 * ORM de gestion de la table ices
 *
 * @author quinton
 *
 */
class Ices extends ObjetBDD
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
		$this->table = "ices";
		$this->id_auto = 1;
		$this->colonnes = array(
			"ices_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1,
				"defaultValue" => 0
			),
			"ices_name" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}
}

/**
 * ORM de gestion de la table environment
 *
 * @author quinton
 *
 */
class Environment extends ObjetBDD
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
		$this->table = "environment";
		$this->id_auto = 1;
		$this->colonnes = array(
			"environment_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1,
				"defaultValue" => 0
			),
			"environment_name" => array(
				"type" => 0,
				"requis" => 1
			),
			"environment_exchange" => array("type"=>0)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}
}

/**
 * ORM de gestion de la table environment_detail
 *
 * @author quinton
 *
 */
class EnvironmentDetail extends ObjetBDD
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
		$this->table = "environment_detail";
		$this->id_auto = 1;
		$this->colonnes = array(
			"environment_detail_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1,
				"defaultValue" => 0
			),
			"environment_detail_name" => array(
				"type" => 0,
				"requis" => 1
			),
			"environment_detail_exchange" => array("type"=>0)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}
}

/**
 * ORM de gestion de la table country
 *
 * @author quinton
 *
 *
 */
class Country extends ObjetBDD
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
		$this->table = "country";
		$this->id_auto = 1;
		$this->colonnes = array(
			"country_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1,
				"defaultValue" => 0
			),
			"country_name" => array(
				"type" => 0,
				"requis" => 1
			),
			"country_order" => array(
				"type" => 1,
				"requis" => 1
			)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}
}

/**
 * ORM de gestion de la table location
 *
 * @author quinton
 *
 */
class Location extends ObjetBDD
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
		$this->table = "location";
		$this->id_auto = 0;
		$this->colonnes = array(
			"declaration_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1
			),
			"country_id" => array(
				"type" => 1
			),
			"ices_id" => array(
				"type" => 1
			),
			"environment_id" => array(
				"type" => 1
			),
			"environment_detail_id" => array(
				"type" => 1
			),
			"area_detail" => array(
				"type" => 0
			),
			"longitude_gps" => array(
				"type" => 0
			),
			"latitude_gps" => array(
				"type" => 0
			),
			"longitude_declared_dd" => array(
				"type" => 1
			),
			"latitude_declared_dd" => array(
				"type" => 1
			),
			"longitude_estimated_dd" => array(
				"type" => 1
			),
			"latitude_estimated_dd" => array(
				"type" => 1
			),
			"longitude_dd" => array(
				"type" => 1
			),
			"latitude_dd" => array(
				"type" => 1
			),
			"geom" => array("type" => 4),
			"accuracy_id" => array("type" => 1)
		);
		$this->srid = 4326;
		$param["srid"] = 4326;
		parent::__construct($link, $param);
	}

	/**
	 * Retourne le detail de la localisation
	 * @param int $id
	 * @return array
	 */
	function getDetail(int $id)
	{
		$sql = "select * from location
					left outer join ices using (ices_id)
					left outer join country using (country_id)
					left outer join environment using (environment_id)
					left outer join environment_detail using (environment_detail_id)
					left outer join accuracy using (accuracy_id)
					where declaration_id = :declaration_id";
		return $this->lireParamAsPrepared($sql, array("declaration_id" => $id));
	}

	/**
	 * Fonction permettant de dupliquer une location
	 * pour creation a partir d'une autre declaration
	 * @param int $id
	 * @param int $idNew
	 */
	function duplicate($id, $idNew)
	{
		if (is_numeric($id) && $id > 0 && $idNew > 0 && is_numeric($idNew)) {
			$data = $this->lire($id);
			$dataNew = array(
				"declaration_id" => $idNew,
				"country_id" => $data["country_id"],
				"ices_id" => $data["ices_id"],
				"environment_id" => $data["environment_id"],
				"environment_detaille_id" => $data["environment_detaille_id"],
				"accuracy_id" => $data["accuracy_id"]
			);
			$this->ecrire($dataNew);
		}
	}

	/**
	 * Surcharge de la fonction ecrire pour preparer le point geographique
	 * (non-PHPdoc)
	 * @see ObjetBDD::write()
	 */
	function ecrire($data)
	{
		if (strlen($data["longitude_dd"]) > 0 && strlen($data["latitude_dd"]) > 0) {
			$data["geom"] = "POINT(" . $data["longitude_dd"] . " " . $data["latitude_dd"] . ")";
		}
		return parent::ecrire($data);
	}
}