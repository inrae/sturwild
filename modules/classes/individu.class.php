<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 août 2015
 */

/**
 * ORM de gestion de la table individu
 *
 * @author quinton
 *
 */
class Individu extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->paramori = $param;
		$this->table = "individu";
		$this->id_auto = 1;
		$this->colonnes = array (
				"individu_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"declaration_id" => array (
						"type" => 1,
						"requis" => 1,
						"parentAttrib" => 1
				),
				"espece_id" => array (
						"type" => 1,
						"defaultValue" => 1
				),
				"presence_marque_id" => array (
						"type" => 1
				),
				"devenir_id" => array (
						"type" => 1
				),
				"capture_etat_id" => array (
						"type" => 1
				),
				"masse" => array (
						"type" => 1
				),
				"manipulation" => array (
						"type" => 0
				),
				"numero_marque" => array (
						"type" => 0
				),
				"longueur_individu" => array (
						"type" => 1
				),
				"cohorte_estimee" => array (
						"type" => 1
				),
				"cohorte_validee" => array (
						"type" => 1
				),
				"historique" => array (
						"type" => 0
				),
				"commentaire" => array (
						"type" => 0
				),
				"qualite_identification" => array (
						"type" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
	function supprimer($id) {
		if ($id > 0 && is_numeric ( $id )) {
			/*
			 * Recherche les pieces jointes attachees, et les supprime
			 */
			require_once 'modules/classes/document.class.php';
			$document = new Document ( $this->connection, $this->paramori );
			$document->deleteFromField ( $id, "individu_id" );
			return parent::supprimer ( $id );
		}
	}
	/**
	 * Surcharge de la fonction ecrire pour rajouter l'etat de la declaration dans le lot
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$id = parent::ecrire ( $data );
		if ($id > 0 && is_numeric ( $data ["declaration_id"] )) {
			/*
			 * Recherche si l'etat du lot a ete renseigne
			 */
			require_once 'modules/classes/declaration.class.php';
			$declaration = new Declaration ( $this->connection, $this->paramori );
			$dataDecl = $declaration->lire ( $data ["declaration_id"] );
			if ($dataDecl ["declaration_id"] > 0 && strlen ( $dataDecl ["capture_etat_id"] ) == 0 && $data ["capture_etat_id"] > 0) {
				$dataDecl ["capture_etat_id"] = $data ["capture_etat_id"];
				$declaration->ecrire ( $dataDecl );
			}
		}
		return $id;
	}

	/**
	 * Retourne la liste des individus rattaches a une declaration
	 *
	 * @param int $id
	 * @return tableau|NULL
	 */
	function getListeFromDeclaration($id) {
		if ($id > 0 && is_numeric ( $id )) {
			$sql = "select * from individu
					left outer join espece using (espece_id)
					left outer join devenir using (devenir_id)
					left outer join presence_marque using (presence_marque_id)
					left outer join capture_etat using (capture_etat_id)
					where declaration_id = :declaration_id
					order by individu_id";
			return $this->getListeParamAsPrepared( $sql, array("declaration_id"=>$id) );
		} else
			return null;
	}
	/**
	 * Recherche les poissons associes aux declarations correspondant aux parametres fournis
	 *
	 * @param unknown $param
	 * @return tableau
	 */
	function getDataToExport($param) {
		/*
		 * Lecture des identifiants des declarations
		 */
		require_once 'modules/classes/declaration.class.php';
		$declaration = new Declaration ( $this->connection, $this->paramori );
		$declarations = $declaration->getIdFromParam ( $param );
		if (count ( $declarations ) > 0) {
			$sql = "select individu.*,
				presence_marque_libelle, espece_libelle, capture_etat_libelle, devenir_libelle";
			$from = " from individu
				left outer join espece using (espece_id )
				left outer join capture_etat using (capture_etat_id)
				left outer join presence_marque using (presence_marque_id)
				left outer join devenir using (devenir_id)
				";
			/*
			 * Preparation de la clause where
			 */

			$first = true;
			$dataWhere = "";
			foreach ( $declarations as $value ) {
				$first == true ? $first = false : $dataWhere .= ", ";
				$dataWhere .= $value ["declaration_id"];
			}
			$where = " where declaration_id in ($dataWhere)";
			$order = " order by declaration_id, individu_id";
			/*
			 * Traitement de la commande
			 */
			return $this->getListeParam( $sql . $from . $where . $order );
		}
	}
}

/**
 * ORM de gestion de la table lot
 *
 * @author quinton
 *
 */
class Lot extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "lot";
		$this->id_auto = 0;
		$this->colonnes = array (
				"declaration_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1
				),
				"espece_id" => array (
						"type" => 1,
						"defaultValue" => 1
				),
				"devenir_id" => array (
						"type" => 1,
						"defaultValue" => 1
				),
				"etat_capture_lot" => array (
						"type" => 0
				),
				"nombre_capture" => array (
						"type" => 1,
						"requis" => 1,
						"defaultValue" => 1
				),
				"longueur_gamme" => array (
						"type" => 0
				),
				"masse_gamme" => array (
						"type" => 0
				),
				"manipulation" => array (
						"type" => 0
				),
				"qualite_identification" => array (
						"type" => 1,
						"defaultValue" => 0
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
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
	function getDetail($id) {
		if ($id > 0 && is_numeric ( $id )) {
			$sql = "select * from lot
					left outer join espece using(espece_id)
					left outer join devenir using (devenir_id)
					where declaration_id = :declaration_id";
			return $this->lireParamAsPrepared( $sql, array("declaration_id"=>$id) );
		}
	}
}

/**
 * ORM de gestion de la table espece
 *
 * @author quinton
 *
 */
class Espece extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "espece";
		$this->id_auto = 1;
		$this->colonnes = array (
				"espece_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"espece_libelle" => array (
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

/**
 * ORM de gestion de la table devenir
 *
 * @author quinton
 *
 */
class Devenir extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "devenir";
		$this->id_auto = 1;
		$this->colonnes = array (
				"devenir_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"devenir_libelle" => array (
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

/**
 * ORM de gestion de la table capture_etat
 *
 * @author quinton
 *
 */
class CaptureEtat extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "capture_etat";
		$this->id_auto = 1;
		$this->colonnes = array (
				"capture_etat_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"capture_etat_libelle" => array (
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

/**
 * ORM de gestion de la table presence_marque
 *
 * @author quinton
 *
 */
class Presence_marque extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "presence_marque";
		$this->id_auto = 1;
		$this->colonnes = array (
				"presence_marque_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"presence_marque_libelle" => array (
						"requis" => 1
				)
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}
?>
