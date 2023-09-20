<?php
class Precision extends ObjetBDD {

function __construct($pdo, $param = array()) {
		$this->table = "accuracy";
		$this->id_auto = 1;
		$this->colonnes = array (
				"accuracy_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1,
						"defaultValue" => 0
				),
				"accuracy_name" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		parent::__construct ( $pdo, $param );
	}
}
