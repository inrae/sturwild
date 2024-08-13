<?php

namespace App\Models;

use App\Models\Fish;
use Ppci\Models\PpciModel;




class Declaration extends PpciModel
{
    public Document $document;
    public Location $location;
    public Fish $fish;
    public Event $event;

    private $paramSearch = array();
    private $fromSearch = " from declaration
				join status using (status_id)
				left outer join location using (declaration_id)
				left outer join species using (species_id)
				left outer join country using (country_id)
				left outer join ices using (ices_id)
				left outer join environment using (environment_id)
				left outer join environment_detail using (environment_detail_id)
				left outer join gear_type using (gear_type_id)
				left outer join capture_method using (capture_method_id)
				left outer join origin using (origin_id)
				left outer join capture_state using (capture_state_id)
				left outer join fate using (fate_id)
                left outer join accuracy using (accuracy_id)
                left outer join v_declaration_handlings using (declaration_id)
                left outer join target_species using (target_species_id)
                left outer join institute using (institute_id)";


    public function __construct()
    {

        $this->table = "declaration";

        $this->fields = array(
            "declaration_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "status_id" => array(
                "type" => 0,
                "requis" => 1,
                "defaultValue" => 1
            ),
            "capture_method_id" => array(
                "type" => 1
            ),
            "origin_id" => array(
                "type" => 1
            ),
            "capture_state_id" => array(
                "type" => 1
            ),
            "capture_date" => array(
                "type" => 2
            ),
            "year" => array(
                "type" => 1,
                "defaultValue" => "getAnnee"
            ),
            "estimated_capture_date" => array(
                "type" => 0
            ),
            "gear_type_id" => array(
                "type" => 1
            ),
            "gear_mesh" => array(
                "type" => 0
            ),
            "target_species" => array(
                "type" => 0
            ),
            "depth" => array(
                "type" => 1
            ),
            "fisher_code" => array(
                "type" => 0
            ),
            "contact" => array(
                "type" => 0
            ),
            "contact_coordinates" => array(
                "type" => 0
            ),
            "harbour_vessel" => array(
                "type" => 0
            ),
            "declaration_mode" => array(
                "type" => 0
            ),
            "remarks" => array(
                "type" => 0
            ),
            "species_id" => array(
                "type" => 1,
                "defaultValue" => 1
            ),
            "identification_quality" => array(
                "type" => 1
            ),
            "depth_min" => array(
                "type" => 1
            ),
            "depth_max" => array(
                "type" => 1
            ),
            "length_min" => array(
                "type" => 1
            ),
            "length_max" => array(
                "type" => 1
            ),
            "weight_min" => array(
                "type" => 1
            ),
            "weight_max" => array(
                "type" => 1
            ),
            "caught_number" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 1
            ),
            "handling" => array(
                "type" => 0
            ),
            "fate_id" => array(
                "type" => 1,
                "defaultValue" => 1
            ),
            "target_species_id" => array("type" => 1),
            "origin_identifier" => array("type" => 0),
            "declaration_uuid" => array("type" => 0, "defaultValue" => "getUUID"),
            "institute_id" => array("type" => 1)
        );

        parent::__construct();
    }

    function duplicate(int $id)
    {
        $idNew = 0;
        if ($id > 0) {
            /*
             * Lecture des donnees a dupliquer
             */
            $data = $this->read($id);
            if ($data["declaration_id"] > 0) {

                $dataNew = array(
                    "declaration_id" => 0,
                    "year" => $data["year"],
                    "origin_id" => $data["origin_id"],
                    "capture_method_id" => $data["capture_method_id"],
                    "fisher_code" => $data["fisher_code"],
                    "contact" => $data["contact"],
                    "contact_coord" => $data["contact_coord"],
                    "harbour_vessel" => $data["harbour_vessel"],
                    "declaration_mode" => $data["declaration_mode"],
                    "target_species_id" => $data["target_species_id"],
                    "status_id" => 1,
                    "caught_number" => 1,
                    "species_id" => 1,
                    "identification_quality" => 1
                );
                /*
                 * Creation de la nouvelle declaration
                 */
                $idNew = $this->write($dataNew);
                if ($idNew > 0) {
                    /*
                     * creation de l'event associe
                     */
                    if (!isset($this->event)) {
                        $this->event = new Event();
                    }
                    $dataEvent = $this->event->lire(0, true, $idNew);
                    $this->event->ecrire($dataEvent);
                    /*
                     * Duplication de la localisation
                     */
                    if (!isset($this->location)) {
                        $this->location = new Location();
                    }
                    $this->location->duplicate($id, $idNew);
                }
            }
        }
        return $idNew;
    }

    /**
     * Recherche la liste des declarations selon les criteres de recherche fournis
     *
     * @param array $param
     * @return array
     */
    function search(array $param)
    {
        $sql = "select declaration.declaration_id, status_id, status_name,
				capture_date, year, estimated_capture_date,
				fisher_code, contact,
				country_name, ices_name, environment_name,
				caught_number, species_name,
				capture_state_name, gear_type_name
                ,longitude_dd,latitude_dd
                ,institute_code
				";
        $where = $this->getWhere($param);
        $order = " order by declaration_id desc";
        $data = $this->getListeParamAsPrepared($sql . $this->fromSearch . $where . $order, $this->paramSearch);
        /*
         * Rajout du nombre de photos associees
         */
        if (!isset($this->document)) {
            $this->document = new Document();
        }
        foreach ($data as $key => $value) {
            $dataNb = $this->document->getNbFromDeclaration($value["declaration_id"]);
            $data[$key]["document_nb"] = $dataNb["document_nb"];
        }
        return $data;
    }

    /**
     * Prepare la requete where a partir des criteres de recherche fournis
     *
     * @param array $param
     * @return string
     */
    function getWhere($param)
    {
        $this->paramSearch = array();
        $and = "";
        /*
         * Preparation de la requete where
         */
        if (!empty($param["year_debut"]) && !empty($param["year_fin"])) {
            $where = " where year between :year_debut: and :year_fin:";
            $this->paramSearch["year_debut"] = $param["year_debut"];
            $this->paramSearch["year_fin"] = $param["year_fin"];
            $and = " and ";
        }
        if (!empty($param["status_id"])) {
            $where .= " $and status_id = :status_id:";
            $and = " and ";
            $this->paramSearch["status_id"] = $param["status_id"];
        }
        if (!empty($param["ices_id"])) {
            $where .= " $and ices_id = :ices_id:";
            $and = " and ";
            $this->paramSearch["ices_id"] = $param["ices_id"];
        }
        if (!empty($param["country_id"])) {
            $where .= " $and country_id = :country_id:";
            $and = " and ";
            $this->paramSearch["country_id"] = $param["country_id"];
        }
        if (!empty($param["environment_id"])) {
            $where .= " $and environment_id = :environment_id:";
            $and = " and ";
            $this->paramSearch["environment_id"] = $param["environment_id"];
        }
        if (!empty($param["capture_state_id"])) {
            $where .= " $and capture_state_id = :capture_state_id:";
            $and = " and ";
            $this->paramSearch["capture_state_id"] = $param["capture_state_id"];
        }
        if (!empty($param["species_id"])) {
            $where .= " $and species_id = :species_id:";
            $and = " and ";
            $this->paramSearch["species_id"] = $param["species_id"];
        }
        if (!empty($param["gear_type_id"])) {
            $where .= " $and gear_type_id = :gear_type_id:";
            $and = " and ";
            $this->paramSearch["gear_type_id"] = $param["gear_type_id"];
        }
        if (!empty($param["libelle"])) {
            $libelle = "%" . $param["libelle"] . "%";
            $this->paramSearch["libelleText1"] = $libelle;
            $this->paramSearch["libelleText2"] = $libelle;
            $where .= " $and (upper(fisher_code) like upper(:libelleText1:)";
            $where .= " or upper(contact) like upper(:libelleText2:)";
            if (is_numeric($param["libelle"])) {
                $where .= " or declaration_id = :libelle:";
                $this->paramSearch["libelle"] = $param["libelle"];
            }
            $where .= ")";
            $and = " and ";
        }
        if (!empty($param["institute_id"])) {
            $where .= "$and institute_id = :institute_id:";
            $this->paramSearch["institute_id"] = $param["institute_id"];
            $and = " and ";
        }
        return $where;
    }

    /**
     * Get the list of handlings attached or not to a declaration
     *
     * @param int $declaration_id
     * @return array
     */
    function getHandlings($declaration_id)
    {
        $sql = "select h.handling_id, handling_name, 
            case when declaration_id is not null then 1 else 0 end as is_selected
            from handling h
            left outer join declaration_handling dh on (h.handling_id = dh.handling_id and dh.declaration_id = :declaration_id:)
            order by handling_order";
        return $this->getListeParamAsPrepared($sql, array("declaration_id" => $declaration_id));
    }

    /**
     * Recupere les donnees pour export
     *
     * @param array $param
     * @return array
     */
    function getDataToExport($param)
    {
        $sql = "select declaration.*,
				country_name, ices_name, environment_name, environment_detail_name,
				area_detail,
				capture_method_name, origin_name, capture_state_name,
				status_name, gear_type_name,
				longitude_dd, latitude_dd, fate_name, identification_quality
				";
        $where = $this->getWhere($param);
        $order = " order by declaration.declaration_id desc";
        $data = $this->getListeParamAsPrepared($sql . $this->fromSearch . $where . $order, $this->paramSearch);
        return $data;
    }

    /**
     * Retourne la liste des identifiants des declarations correspondants aux criteres de recherche
     *
     * @param array $param
     * @return array
     */
    function getIdFromParam($param)
    {
        $sql = "select declaration_id ";
        $where = $this->getWhere($param);
        return $this->getListeParamAsPrepared($sql . $this->fromSearch . $where, $this->paramSearch);
    }

    /**
     * Retourne l'year courante
     *
     * @return int
     */
    function getAnnee()
    {
        return date('Y');
    }

    /**
     * Calcule le nombre d'esturgeons d'Europe captures par year
     *
     * @return array
     */
    function getNbSturioByYear()
    {
        $sql = "select year, species_name, sum(caught_number) as caught_number
				from declaration
        join species using (species_id)
				group by year, species_name
				order by year, species_name";
        return $this->getListeParam($sql);
    }

    /**
     * Retourne le detail d'une declaration
     *
     * @param int $id
     * @return array
     */
    function getDetail(int $id)
    {
        $sql = "select * ";
        $where = " where declaration_id = :declaration_id:";
        return $this->lireParamAsPrepared($sql . $this->fromSearch . $where, array("declaration_id" => $id));
    }


    function write(array $data): int
    {
        /*
         * Teste s'il s'agit d'une creation
         */
        $data["declaration_id"] == 0 ? $creation = true : $creation = false;
        $id = parent::write($data);
        /**
         * Add the handlings
         */
        $this->ecrireTableNN("declaration_handling", "declaration_id", "handling_id", $id, $data["handlings"]);

        if ($creation) {
            /*
             * Generation de l'event de saisie
             */
            if (!isset($this->event)) {
                $this->event = new Event();
            }
            $dataEvnmt = $this->event->getDefaultValues($id);
            $dataEvnmt["event_type_id"] = $data["status_id"];
            $this->event->write($dataEvnmt);
        }
        return $id;
    }


    function delete($id = null, bool $purge = false)
    {
        if ($id > 0 && is_numeric($id)) {
            /*
             * Suppression des informations liees
             */
            if (!isset($this->event)) {
                $this->event = new Event();
            }
            $this->event->deleteFromField($id, "declaration_id");
            if (!isset($this->fish)) {
                $this->fish = new Fish();
            }
            $this->fish->deleteFromField($id, "declaration_id");
            if (!isset($this->location)) {
                $this->location = new Location();
            }
            $this->location->supprimer($id);
            parent::delete($id);
        }
    }
    /**
     * Get the declaration_id from a field 
     *
     * @param string $fieldName
     * @param $value
     * @return integer
     */
    function getIdByField(string $fieldName, $value): int
    {
        $id = 0;
        if (strlen($value) > 0) {
            $sql = "select declaration_id from declaration where $fieldName = :value:";
            $data = $this->lireParamAsPrepared($sql, array("value" => $value));
            if ($data["declaration_id"] > 0) {
                $id = $data["declaration_id"];
            }
        }
        return $id;
    }

    /**
     * Get the list of declarations with all data
     *
     * @param array $ids
     * @param boolean $withExchangeLabel
     * @return array
     */
    function getDataForExport(array $ids, bool $withExchangeLabel = true): array
    {
        $data = array();
        if (count($ids) > 0) {
            $localCode = $_SESSION["dbparams"]["APPLI_code"];
            $withExchangeLabel ? $suffix = "_exchange" : $suffix = "_name";
            $sql = "select declaration_uuid, status$suffix, capture_method$suffix, origin$suffix, gear_type$suffix, species$suffix, capture_state$suffix,
        fate$suffix, capture_date, year, caught_number, estimated_capture_date,
        gear_mesh, target_species, depth, depth_min, depth_max length_min, length_max, weight_min, weight_max,
        fisher_code, contact, contact_coordinates, harbour_vessel,
        declaration_mode, remarks, handling, identification_quality, 
        target_species$suffix, handlings$suffix,
        case when origin_identifier is not null then origin_identifier else '$localCode' || ':' || declaration_id::varchar end as origin_identifier,
        country$suffix, ices_name, environment$suffix, environment_detail$suffix, 
        longitude_gps, latitude_gps, longitude_declared_dd, latitude_declared_dd, 
        longitude_estimated_dd, latitude_estimated_dd, longitude_dd, latitude_dd, 
        accuracy$suffix, 
        case when institute_code is not null then institute_code else '$localCode' end as institute_code
        ";
            $where = " where declaration_id in (";
            $comma = "";
            $i = 1;
            $param = array();
            foreach ($ids as $id) {
                $where .= $comma . ":id$i:";
                $param["id$i"] = $id;
                $comma = ",";
                $i++;
            }
            $where .= ") and (status_id >= 3 )";
            $order = " order by declaration_id";
            $data = $this->getListeParamAsPrepared($sql . $this->fromSearch . $where . $order, $param);
        }
        return $data;
    }
}
