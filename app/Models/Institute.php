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
    /**
     * Get the list of institutes attached to the list of furnished groups
     *
     * @param array $groups
     * @return array
     */
    function getListFromGroups(array $groups):array {
        $in = "";
        $i = 0;
        $data = [];
        foreach ($groups as $id) {
            if ($i > 0) {
                $in .=",";
            }
            $in .= ":id".$i.":";
            $data["id".$i] = $id;
            $i ++;
        }
        $sql = "select distinct institute_id
                from institute
                join institute_aclgroup using (institute_id)
                where aclgroup_id in ($in)";
        $list = $this->getListeParam($sql, $data);
        $result = [];
        foreach ($list as $row) {
            $result[] = $row["institute_id"];
        }
        return $result;
    }
    function getInstitutesEnabled():array {
        $sql = "select institute_id, institude_code, institute_description
                from institute";
                $data = [];
        if ($_SESSION["userRights"]["param"] == 1) {
            $where = "";
        } else {
            
            $in = "";
            $i = 0;
            foreach($_SESSION["institutes"] as $institute_id) {
            if ($i > 0) {
                $in .=",";
            }
            $in .= ":id".$i.":";
            $data["id".$i] = $institute_id;
            $i ++;
            }
            $where = " where institute_id in ($in)";
        }
        $order = " order by institute_code";
        return $this->getListParam($sql.$where.$order, $data);
    }
}