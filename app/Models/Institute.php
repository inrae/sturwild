<?php

namespace App\Models;

use Ppci\Libraries\PpciException;
use Ppci\Models\Aclgroup;
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
    function getListFromGroups(array $groups): array
    {
        $in = "";
        $i = 0;
        $data = [];
        foreach ($groups as $id) {
            if ($i > 0) {
                $in .= ",";
            }
            $in .= ":id" . $i . ":";
            $data["id" . $i] = $id;
            $i++;
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
    function getInstitutesEnabled(): array
    {
        $sql = "select institute_id, institute_code, institute_description
                from institute";
        $data = [];
        if ($_SESSION["userRights"]["param"] == 1) {
            $where = "";
        } else {

            $in = "";
            $i = 0;
            foreach ($_SESSION["institutes"] as $institute_id) {
                if ($i > 0) {
                    $in .= ",";
                }
                $in .= ":id" . $i . ":";
                $data["id" . $i] = $institute_id;
                $i++;
            }
            $where = " where institute_id in ($in)";
        }
        $order = " order by institute_code";
        return $this->getListParam($sql . $where . $order, $data);
    }
    /**
     * Get the list of groups enabled to edit declarations attached to the institute
     *
     * @param integer $institute_id
     * @return array
     */
    function getGroupsFromInstitute(int $institute_id)
    {
        $data = array();
        if ($institute_id > 0) {
            $sql = "select aclgroup_id, groupe from institute_aclgroup
					join aclgroup using (aclgroup_id)
					where institute_id = :institute_id:";
            $var["institute_id"] = $institute_id;
            $data = $this->getListParam($sql, $var);
        }
        return $data;
    }
    function getAllGroupsFromInstitute($institute_id)
    {
        if ($institute_id > 0 && is_numeric($institute_id)) {
            $data = $this->getGroupsFromInstitute($institute_id);
            $dataGroup = array();
            foreach ($data as $value) {
                $dataGroup[$value["aclgroup_id"]] = 1;
            }
        }
        $aclgroup = new Aclgroup;
        $groupes = $aclgroup->getListe(2);
        foreach ($groupes as $key => $value) {
            $groupes[$key]["checked"] = $dataGroup[$value["aclgroup_id"]];
        }
        return $groupes;
    }
    function write(array $row): int
    {
        $id = parent::write($row);
        $this->writeTableNN("institute_aclgroup", "institute_id", "aclgroup_id", $id, $row["groups"]);
        $this->initInstitutes();
        return $id;
    }
    /**
     * Generate the list of institutes associated with the login
     */
    function initInstitutes()
    {
        $groupsId = [];
        foreach ($_SESSION["groupes"] as $group) {
            $groupsId[] = $group["aclgroup_id"];
        }
        if (!empty($groupsId)) {
            $_SESSION["institutes"] = $this->getListFromGroups($groupsId);
        }
    }
    function supprimer($id)
    {
        /**
         * Verify if declarations are attached to the institute
         */
        $declaration = new Declaration;
        if ($declaration->getNbDeclarationsByInstitute($id) > 0) {
            throw new PpciException(_("Des déclarations sont attachées à cet institut, sa suppression n'est pas possible"));
        }
        $sql = "DELETE from institute_aclgroup where institute_id = :id:";
        $this->executeQuery($sql, ["id" => $id], true);
        parent::supprimer($id);
    }

    function getList(string $order = ""): array
    {
        $sql = "SELECT institute_id, institute_code, institute_description
                ,getGroupsFromInstitute(institute_id) as groups
                from institute";
        if (strlen($order) > 0) {
            $order = " order by $order";
        } else {
            $order = "";
        }
        return $this->getListParam($sql . $order);
    }
}
