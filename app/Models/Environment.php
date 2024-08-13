<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table environment
 *
 * @author quinton
 *
 */
class Environment extends PpciModel
{
	public function __construct()
	{
		$this->table = "environment";

		$this->fields = array(
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
			"environment_exchange" => array("type" => 0)
		);

		parent::__construct();
	}
}
