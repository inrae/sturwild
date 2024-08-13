<?php namespace App\Models;
use Ppci\Models\PpciModel;
class Institute extends PpciModel
{
    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    public function __construct()
    {

        $this->table = "institute";
        
        $this->fields = array(
            "institute_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "institute_code" => array(
                "type" => 0,
                "requis" => 1
            ),
            "institute_description" => array("type" => 0)
        );
        
        parent::__construct();
    }
    function getIdFromCode(string $code, bool $withCreate = false)
    {
        $id = 0;
        if (strlen($code) > 0) {

            $sql = "select institute_id  as id
                from institute
                where institute_code = :code:";
            $data = $this->lireParamAsPrepared($sql, array("code" => $code));
            if ($data["id"]) {
                $id = $data["id"];
            } else if ($withCreate) {
                $data = array(
                    "id" => 0,
                    "institute_code" => $code
                );
                $id = $this->ecrire($data);
            }
        }
        return $id;
    }
}