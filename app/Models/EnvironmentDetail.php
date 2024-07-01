<?php

namespace App\Models;

use Ppci\Models\PpciModel;


/**
 * ORM de gestion de la table environment_detail
 *
 * @author quinton
 *
 */
class EnvironmentDetail extends PpciModel
{
    public function __construct()
    {
        $this->table = "environment_detail";

        $this->fields = array(
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
            "environment_detail_exchange" => array("type" => 0)
        );

        parent::__construct();
    }
}
