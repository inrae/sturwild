<?php namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * Generic class for all parameters tables with only 2 fields:
 * table name: test
 * field id: test_id
 * field name : field_name
 */
class Status extends PpciModel
{
    /**
     * Constructor
     *
     * @param pdo $bdd
     * @param array $param
     */
    public function __construct()
    {
        $this->table = "status";
        $this->fields = array(
            "status_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue" => 0),
            "status_name" => array("type" => 0, "requis" => 1),
            "status_exchange" => array("type" => 0),
            "status_order"=> array("type"=>1, "requis"=>1)
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
    function getIdFromName(string $name, bool $searchByExchange = true, bool $withCreate = false)
    {
        $id = 0;
        if (!empty($name)) {
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
            }
        }
        return $id;
    }
    function getParams() {
        $order = "status_id";
        return $this->getListe($order);
    }

}