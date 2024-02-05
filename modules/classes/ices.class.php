<?php
/**
 * ORM de gestion de la table ices
 *
 * @author quinton
 *
 */
class Ices extends ObjetBDD
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
        $this->table = "ices";
        $this->id_auto = 1;
        $this->colonnes = array(
            "ices_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "ices_name" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        $param["fullDescription"] = 1;
        parent::__construct($link, $param);
    }

    function getIdFromName(string $name, bool $withCreate = false)
    {
        $id = 0;
        if (strlen($name) > 0) {

            $sql = "select ices_id  as id
                from ices
                where ices_name = :name";
            $data = $this->lireParamAsPrepared($sql, array("name" => $name));
            if ($data["id"]) {
                $id = $data["id"];
            } else if ($withCreate) {
                $data = array(
                    "id" => 0,
                    "ices_name" => $name
                );
                $id = $this->ecrire($data);
            }
        }
        return $id;
    }
}