<?php
class Precision extends ObjetBDD {

function __construct($pdo, $param = array()) {
		$this->table = "precision";
		$this->id_auto = 1;
		$this->colonnes = array (
				"precision_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"precision_name" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		parent::__construct ( $pdo, $param );
	}
}
