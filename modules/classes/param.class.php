<?php

/**
 * Generic class for all parameters tables with only 2 fields:
 * table name: test
 * field id: test_id
 * field name : field_name
 */
class Param extends ObjetBDD
{
    /**
     * Constructor
     *
     * @param pdo $bdd
     * @param string $tablename
     */
    function __construct($bdd, $tablename)
    {
        $this->table = $tablename;
        $this->colonnes = array(
            $tablename . "_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue" => 0),
            $tablename . "_name" => array("type" => 0, "requis" => 1),
            $tablename . "_exchange" => array("type" => 0),
            $tablename . "_order"=> array("type"=>1, "requis"=>1)
        );
        parent::__construct($bdd);
    }
    /**
     * Get the id of a record from the name
     *
     * @param string $name
     * @param boolean $withCreate: if true and the record not exists, the parameter is created
     * @return int
     */
    function getIdFromName(string $name, bool $searchByExchange = true, bool $withCreate = false)
    {
        $id = 0;
        if (strlen($name) > 0) {
            if ($searchByExchange) {
                $field = $this->table . "_exchange";
            } else {
                $field = $this->table . "_name";
            }
            $sql = "select " . $this->table . "_id  as id
                from $this->table
                where $field = :name";
            $data = $this->lireParamAsPrepared($sql, array("name" => $name));
            if ($data["id"]) {
                $id = $data["id"];
            } else if ($withCreate) {
                $data = array(
                    "id" => 0,
                    $this->table . "_name" => $name,
                    $this->table . "_exchange" => $name
                );
                $id = $this->ecrire($data);
            }
        }
        return $id;
    }
    function getParams() {
        $order = $this->table."_order,".$this->table."_name";
        return $this->getListe($order);
    }

}