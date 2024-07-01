<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * Generic class for all parameters tables with only 2 fields:
 * table name: test
 * field id: test_id
 * field name : field_name
 */
class Param extends PpciModel
{
    public function __construct($tablename)
    {
        $this->table = $tablename;
        $this->fields = array(
            $tablename . "_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue" => 0),
            $tablename . "_name" => array("type" => 0, "requis" => 1),
            $tablename . "_exchange" => array("type" => 0),
            $tablename . "_order" => array("type" => 1, "requis" => 1)
        );
        parent::__construct();
    }
    /**
     * Get the id of a record from the name
     *
     * @param string $name
     * @param boolean $withCreate: if true and the record not exists, the parameter is created
     * @return int
     */
    function getIdFromName(string $name, string $suffix = "_exchange", bool $withCreate = false)
    {
        $id = 0;
        if (strlen($name) > 0) {

            $field = $this->table . $suffix;
            $sql = "select " . $this->table . "_id  as id
                from $this->table
                where $field = :name:
                order by " . $this->table . "_order, " . $this->table . "_id";
            $data = $this->lireParamAsPrepared($sql, array("name" => $name));
            if ($data["id"]) {
                $id = $data["id"];
            } else if ($withCreate) {
                $data = array(
                    $this->table . "_id" => 0,
                    $this->table . "_name" => $name,
                    $this->table . "_exchange" => $name,
                    $this->table . "_order" => 99
                );
                $id = $this->ecrire($data);
            }
        }
        return $id;
    }
    function getParams($suffix = "_name")
    {
        $order = $this->table . "_order," . $this->table . $suffix;
        return $this->getListe($order);
    }
}
