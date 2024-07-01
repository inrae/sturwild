<?php
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table country
 *
 * @author quinton
 *
 *
 */
class Country extends PpciModel
{
	/**
	 * Constructeur
	 *
	 * @param PDO $link
	 * @param array $param
	 */
	public function __construct()
	{
		$this->table = "country";
		
		$this->fields = array(
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
		
		parent::__construct();
	}
}
