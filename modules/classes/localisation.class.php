<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 août 2015
 */

/**
 * ORM de gestion de la table ciem
 *
 * @author quinton
 *
 */
class Ciem extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "ciem";
		$this->id_auto = 1;
		$this->colonnes = array (
				"ciem_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"ciem_libelle" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

/**
 * ORM de gestion de la table milieu
 *
 * @author quinton
 *
 */
class Milieu extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "milieu";
		$this->id_auto = 1;
		$this->colonnes = array (
				"milieu_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"milieu_libelle" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

/**
 * ORM de gestion de la table milieu_detail
 *
 * @author quinton
 *
 */
class MilieuDetail extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "milieu_detail";
		$this->id_auto = 1;
		$this->colonnes = array (
				"milieu_detail_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"milieu_detail_libelle" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

/**
 * ORM de gestion de la table pays
 *
 * @author quinton
 *
 *
 */
class Pays extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "pays";
		$this->id_auto = 1;
		$this->colonnes = array (
				"pays_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"pays_libelle" => array (
						"type" => 0,
						"requis" => 1
				),
				"pays_order" => array (
						"type" => 1,
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

/**
 * ORM de gestion de la table localisation
 *
 * @author quinton
 *
 */
class Localisation extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "localisation";
		$this->id_auto = 0;
		$this->colonnes = array (
				"declaration_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1
				),
				"pays_id" => array (
						"type" => 1
				),
				"ciem_id" => array (
						"type" => 1
				),
				"milieu_id" => array (
						"type" => 1
				),
				"milieu_detail_id" => array(
						"type" => 1
				),
				"zone_detail" => array (
						"type" => 0
				),
				"longitude_gps" => array (
						"type" => 0
				),
				"latitude_gps" => array (
						"type" => 0
				),
				"longitude_declaree_dd" => array (
						"type" => 1
				),
				"latitude_declaree_dd" => array (
						"type" => 1
				),
				"longitude_estimee_dd" => array (
						"type" => 1
				),
				"latitude_estimee_dd" => array (
						"type" => 1
				),
				"longitude_dd" => array (
						"type" => 1
				),
				"latitude_dd" => array (
						"type" => 1
				),
				"geom" => array ("type"=>4),
				"precision_id"=>array("type"=>1)
		);
		$this->srid = 4326;
		$param["srid"] = 4326;
		parent::__construct ( $link, $param );
	}

	/**
	 * Retourne le detail de la localisation
	 * @param int $id
	 * @return array
	 */
	function getDetail ($id) {
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from localisation
					left outer join ciem using (ciem_id)
					left outer join pays using (pays_id)
					left outer join milieu using (milieu_id)
					left outer join milieu_detail using (milieu_detail_id)
					left outer join precision using (precision_id)
					where declaration_id = :declaration_id";
			return $this->lireParamAsPrepared($sql, array("declaration_id"=>$id));
		}
	}

	/**
	 * Fonction permettant de dupliquer une localisation
	 * pour creation a partir d'une autre declaration
	 * @param int $id
	 * @param int $idNew
	 */
	function duplicate($id, $idNew) {
		if (is_numeric($id) && $id > 0 && $idNew > 0 && is_numeric($idNew)) {
			$data = $this->lire($id);
			$dataNew = array (
					"declaration_id"=>$idNew,
					"pays_id"=>$data["pays_id"],
					"ciem_id"=>$data["ciem_id"],
					"milieu_id"=>$data["milieu_id"],
					"milieu_detaille_id"=>$data["milieu_detaille_id"],
					"precision_id"=>$data["precision_id"]
			);
			$this->ecrire($dataNew);
		}
	}

	/**
	 * Surcharge de la fonction ecrire pour preparer le point geographique
	 * (non-PHPdoc)
	 * @see ObjetBDD::write()
	 */
	function ecrire($data) {
		if (strlen ($data["longitude_dd"]) > 0 && strlen($data["latitude_dd"]) > 0 ) {
			$data["geom"] = "POINT(".$data["longitude_dd"]." ".$data["latitude_dd"].")";
		}
		return parent::ecrire($data);
	}
}
