<?php
class Institute extends ObjetBDD
{
    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    function __construct($link, $param = NULL)
    {
        if (!is_array($param))
            $param = array();
        $this->table = "institute";
        $this->id_auto = 1;
        $this->colonnes = array(
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
        $param["fullDescription"] = 1;
        parent::__construct($link, $param);
    }
    function getIdFromCode(string $code, bool $withCreate = false)
    {
        $id = 0;
        if (strlen($code) > 0) {

            $sql = "select institute_id  as id
                from institute
                where institute_code = :code";
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