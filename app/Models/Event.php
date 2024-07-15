<?php

namespace App\Models;

use app\Libraries\SendMail;
use Ppci\Models\LoginGestion;
use Ppci\Models\PpciModel;


/**
 * ORM de gestion de la table event
 *
 * @author quinton
 *
 */
class Event extends PpciModel
{
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	public function __construct()
	{
		$this->table = "event";

		$this->fields = array(
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
				"defaultValue" => $_SESSION["login"]
			)
		);

		parent::__construct();
	}

	/**
	 * Surcharge de la fonction write pour mettre a niveau le status de
	 * la declaration en fonction de l'event cree
	 * (non-PHPdoc)
	 * @see ObjetBDD::write()
	 */
	function write(array $data): int
	{
		$id = parent::write($data);
		if ($id > 0) {
			/*
			 * Mise a niveau du status de la declaration en fonction du type d'event
			 */
			$declaration = new Declaration();
			$dataDecl = $declaration->lire($data["declaration_id"]);
			if ($dataDecl["status_id"] < $data["event_type_id"] && $data["event_type_id"] < 5) {
				$dataDecl["status_id"] = $data["event_type_id"];
				$declaration->ecrire($dataDecl);
				/*
				 * Traitement de l'envoi des mails
				 */
				if (in_array($data["event_type_id"], array(3, 4))) {
					$mail = new SendMail();
					$mail->send($data["declaration_id"]);
				}
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
	function getListeFromDeclaration(int $id)
	{
		if ($id > 0 && is_numeric($id)) {
			$sql = "select * from event
					left outer join event_type using (event_type_id)
					where declaration_id = :declaration_id:
					order by event_date desc, event_type_id desc";
			$data = $this->getListeParamAsPrepared($sql, array("declaration_id" => $id));
			/*
			 * Recherche des des utilisateurs ayant cree les events
			 */
			$loginGestion = new LoginGestion();
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
