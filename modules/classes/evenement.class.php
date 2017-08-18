<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 août 2015
 */
require_once 'modules/classes/declaration.class.php';
/**
 * ORM de gestion de la table evenement
 *
 * @author quinton
 *        
 */
class Evenement extends ObjetBDD {
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
		$this->table = "evenement";
		$this->id_auto = 1;
		$this->colonnes = array (
				"evenement_id" => array (
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
				
				"evenement_type_id" => array (
						"type" => 1,
						"defaultValue" => 1 
				),
				"evenement_date" => array (
						"type" => 2,
						"defaultValue" => "getDateJour" 
				),
				"evenement_commentaire" => Array (
						"type" => 0 
				),
				"login" => array (
						"type" => 0,
						"defaultValue" => "getLogin" 
				) 
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}

	/**
	 * Surcharge de la fonction write pour mettre a niveau le statut de
	 * la declaration en fonction de l'evenement cree
	 * (non-PHPdoc)
	 * @see ObjetBDD::write()
	 */
	function ecrire($data) {
		$id = parent::ecrire($data);
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Mise a niveau du statut de la declaration en fonction du type d'evenement
			 */
			$declaration = new Declaration($this->connection, $this->paramori);
			$dataDecl = $declaration->lire($data["declaration_id"]);
			if ($dataDecl["statut_id"] < $data["evenement_type_id"] && $data["evenement_type_id"] < 5) {
				$dataDecl["statut_id"] = $data["evenement_type_id"];
				$declaration->ecrire($dataDecl);
				/*
				 * Traitement de l'envoi des mails
				 */
				if (in_array($data["evenement_type_id"], array (3, 4)))
				    sendMail($data["declaration_id"]);
			}
		}
		return $id;
		
	}
	
	/**
	 * Retourne la liste des evenements rattaches a une declaration
	 *
	 * @param int $id        	
	 * @return tableau|NULL
	 */
	function getListeFromDeclaration($id) {
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from evenement
					left outer join evenement_type using (evenement_type_id)
					where declaration_id = :declaration_id
					order by evenement_date desc, evenement_type_id desc";
			$data = $this->getListeParamAsPrepared( $sql, array("declaration_id"=>$id) );
			/*
			 * Recherche des des utilisateurs ayant cree les evenements
			 */
			global $bdd_gacl;
			require_once 'framework/identification/identification.class.php';
			$loginGestion = new LoginGestion ( $bdd_gacl, $this->paramori );
			foreach ( $data as $key => $value ) {
				if (strlen ( $value ["login"] ) > 0) {
					$dataLogin = $loginGestion->lireByLogin ( $value["login"] );
					strlen ( $dataLogin ["nom"] ) > 0 ? $data [$key] ["utilisateur"] = $dataLogin ["nom"] . " " . $dataLogin ["prenom"] : $data [$key] ["utilisateur"] = $value ["login"];
				}
			}
			return $data;
		} else
			return null;
	}
	
	/**
	 * Retourne le login, pour creer la valeur par defaut
	 * 
	 * @return string
	 */
	function getLogin() {
		if (isset ( $_SESSION ["login"] ))
			return $_SESSION ["login"];
	}
}

/**
 * ORM de gestion de la table evenement_type
 * 
 * @author quinton
 *        
 */
class Evenement_type extends ObjetBDD {
	/**
	 * Constructeur
	 *
	 * @param PDO $link        	
	 * @param array $param        	
	 */
	function __construct($link, $param = NULL) {
		if (! is_array ( $param ))
			$param = array ();
		$this->table = "evenement_type";
		$this->id_auto = 1;
		$this->colonnes = array (
				"evenement_type_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0 
				),
				"evenement_type_libelle" => array (
						"requis" => 1 
				) 
		);
		$param ["fullDescription"] = 1;
		parent::__construct ( $link, $param );
	}
}

?>