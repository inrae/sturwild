<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 5 août 2015
 */
require_once 'modules/classes/declaration.class.php';
/**
 * ORM de gestion de la table event
 *
 * @author quinton
 *
 */
class Event extends ObjetBDD
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
		$this->table = "event";
		$this->id_auto = 1;
		$this->colonnes = array(
			"event_id" => array(
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

			"event_type_id" => array(
				"type" => 1,
				"defaultValue" => 1
			),
			"event_date" => array(
				"type" => 2,
				"defaultValue" => "getDateJour"
			),
			"event_remarks" => array(
				"type" => 0
			),
			"login" => array(
				"type" => 0,
				"defaultValue" => "getLogin"
			)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}

	/**
	 * Surcharge de la fonction write pour mettre a niveau le status de
	 * la declaration en fonction de l'event cree
	 * (non-PHPdoc)
	 * @see ObjetBDD::write()
	 */
	function ecrire($data)
	{
		$id = parent::ecrire($data);
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Mise a niveau du status de la declaration en fonction du type d'event
			 */
			$declaration = new Declaration($this->connection, $this->paramori);
			$dataDecl = $declaration->lire($data["declaration_id"]);
			if ($dataDecl["status_id"] < $data["event_type_id"] && $data["event_type_id"] < 5) {
				$dataDecl["status_id"] = $data["event_type_id"];
				$declaration->ecrire($dataDecl);
				/*
				 * Traitement de l'envoi des mails
				 */
				if (in_array($data["event_type_id"], array(3, 4)))
					sendMail($data["declaration_id"]);
			}
		}
		return $id;
	}

	/**
	 * Retourne la liste des events rattaches a une declaration
	 *
	 * @param int $id
	 * @return array
	 */
	function getListeFromDeclaration($id)
	{
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from event
					left outer join event_type using (event_type_id)
					where declaration_id = :declaration_id
					order by event_date desc, event_type_id desc";
			$data = $this->getListeParamAsPrepared($sql, array("declaration_id" => $id));
			/*
			 * Recherche des des utilisateurs ayant cree les events
			 */
			global $bdd_gacl;
			require_once 'framework/identification/loginGestion.class.php';
			$loginGestion = new LoginGestion($bdd_gacl, $this->paramori);
			foreach ($data as $key => $value) {
				if (strlen($value["login"]) > 0) {
					$dataLogin = $loginGestion->lireByLogin($value["login"]);
					strlen($dataLogin["nom"]) > 0 ? $data[$key]["utilisateur"] = $dataLogin["nom"] . " " . $dataLogin["prenom"] : $data[$key]["utilisateur"] = $value["login"];
				}
			}
			return $data;
		} else {
			return array();
		}
	}
}

/**
 * ORM de gestion de la table event_type
 *
 * @author quinton
 *
 */
class Event_type extends ObjetBDD
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
		$this->table = "event_type";
		$this->id_auto = 1;
		$this->colonnes = array(
			"event_type_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1,
				"defaultValue" => 0
			),
			"event_type_name" => array(
				"requis" => 1
			)
		);
		$param["fullDescription"] = 1;
		parent::__construct($link, $param);
	}
}
