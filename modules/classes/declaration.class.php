<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 août 2015
 */
/**
 * ORM de gestion de la table declaration
 *
 * @author quinton
 *
 */


class Declaration extends ObjetBDD
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
        left outer join v_declaration_handlings using (declaration_id)";

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
    $this->paramori = $param;
    $this->table = "declaration";
    $this->id_auto = 1;
    $this->colonnes = array(
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
      "contact_coordonates" => array(
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
      )
    );
    $param["fullDescription"] = 1;
    parent::__construct($link, $param);
  }

  function duplicate($id)
  {
    $idNew = 0;
    if (is_numeric($id) && $id > 0) {
      /*
       * Lecture des donnees a dupliquer
       */
      $data = $this->lire($id);
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
          "status_id" => 1,
          "caught_number" => 1,
          "species_id" => 1,
          "identification_quality" => 1
        );
        /*
         * Creation de la nouvelle declaration
         */
        $idNew = $this->ecrire($dataNew);
        if ($idNew > 0) {
          /*
           * creation de l'event associe
           */
          if (!isset($this->event)) {
            $this->event = $this->classInstanciate("Event", "event.class.php");
          }
          $dataEvent = $this->event->lire(0, true, $idNew);
          $this->event->ecrire($dataEvent);
          /*
           * Duplication de la location
           */
          if (!isset($this->location)) {
            $this->location = $this->classInstanciate("Location", "location.class.php");
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
				";
    $where = $this->getWhere($param);
    $order = " order by declaration_id desc";
    $data = $this->getListeParamAsPrepared($sql . $this->fromSearch . $where . $order, $this->paramSearch);
    /*
     * Rajout du nombre de photos associees
     */
    if (!isset($this->document)) {
      $this->document = $this->classInstanciate("Document", "document.class.php");
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
      $where = " where year between :year_debut and :year_fin";
      $this->paramSearch["year_debut"] = $param["year_debut"];
      $this->paramSearch["year_fin"] = $param["year_fin"];
      $and = " and ";
    }
    if (!empty($param["status_id"])) {
      $where .= " $and status_id = :status_id";
      $and = " and ";
      $this->paramSearch["status_id"] = $param["status_id"];
    }
    if (!empty($param["ices_id"])) {
      $where .= " $and ices_id = :ices_id";
      $and = " and ";
      $this->paramSearch["ices_id"] = $param["ices_id"];
    }
    if ( !empty($param["country_id"])) {
      $where .= " $and country_id = :country_id";
      $and = " and ";
      $this->paramSearch["country_id"] = $param["country_id"];
    }
    if (!empty($param["environment_id"])) {
      $where .= " $and environment_id = :environment_id";
      $and = " and ";
      $this->paramSearch["environment_id"] = $param["environment_id"];
    }
    if (!empty($param["capture_state_id"])) {
      $where .= " $and capture_state_id = :capture_state_id";
      $and = " and ";
      $this->paramSearch["capture_state_id"] = $param["capture_state_id"];
    }
    if (!empty($param["species_id"])) {
      $where .= " $and species_id = :species_id";
      $and = " and ";
      $this->paramSearch["species_id"] = $param["species_id"];
    }
    if ( !empty($param["gear_type_id"])) {
      $where .= " $and gear_type_id = :gear_type_id";
      $and = " and ";
      $this->paramSearch["gear_type_id"] = $param["gear_type_id"];
    }
    if (!empty($param["libelle"])) {
      $libelle = "%" . $param["libelle"] . "%";
      $this->paramSearch["libelleText1"] = $libelle;
      $this->paramSearch["libelleText2"] = $libelle;
      $where .= " $and (upper(fisher_code) like upper(:libelleText1)";
      $where .= " or upper(contact) like upper(:libelleText2)";
      if (is_numeric($param["libelle"])) {
        $where .= " or declaration_id = :libelle";
        $this->paramSearch["libelle"] = $param["libelle"];
      }
      $where .= ")";
    }
    return $where;
  }

  /**
   * Get the list of handlings attached or not to a declaration
   *
   * @param int $declaration_id
   * @return array
   */
  function getHandlings( $declaration_id) {
    $sql = "select h.handling_id, handling_name, 
            case when declaration_id is not null then 1 else 0 end as is_selected
            from handling h
            left outer join declaration_handling dh on (h.handling_id = dh.handling_id and dh.declaration_id = :declaration_id)
            order by handling_order";
            return $this->getListeParamAsPrepared($sql, array("declaration_id"=>$declaration_id));
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
  function getDetail($id)
  {
    if ($id > 0 && is_numeric($id)) {
      $sql = "select * ";
      $where = " where declaration_id = :declaration_id";
      return $this->lireParamAsPrepared($sql . $this->fromSearch . $where, array("declaration_id" => $id));
    }
  }

  /**
   * Surcharge de la fonction write pour creer un event de saisie
   * lors de la creation
   * (non-PHPdoc)
   *
   * @see ObjetBDD::write()
   */
  function ecrire($data)
  {
    /*
     * Teste s'il s'agit d'une creation
     */
    $data["declaration_id"] == 0 ? $creation = true : $creation = false;
    $id = parent::ecrire($data);
    /**
     * Add the handlings
     */
    $this->ecrireTableNN("declaration_handling","declaration_id", "handling_id", $id, $data["handlings"]);

    if ( $creation) {
      /*
       * Generation de l'event de saisie
       */
      if (!isset($this->event)) {
        $this->event = $this->classInstanciate("Event", "event.class.php");
      }
      $dataEvnmt = $this->event->getDefaultValue($id);
      $dataEvnmt["event_type_id"] = $data["status_id"];
      $this->event->ecrire($dataEvnmt);
    }
    return $id;
  }

  /**
   * Surcharge de la fonction supprimer pour effacer les enregistrements lies
   * (non-PHPdoc)
   *
   * @see ObjetBDD::supprimer()
   */
  function supprimer($id)
  {
    if ($id > 0 && is_numeric($id)) {
      /*
       * Suppression des informations liees
       */
      if (!isset($this->event)) {
        $this->event = $this->classInstanciate("Event", "event.class.php");
      }
      $this->event->deleteFromField($id, "declaration_id");
      if (!isset($this->fish)) {
        $this->fish = $this->classInstanciate("Fish", "fish.class.php");
      }
      $this->fish->supprimerChamp($id, "declaration_id");
      if (!isset($this->location)) {
        $this->location = $this->classInstanciate("Location", "location.class.php");
      }
      $this->location->supprimer($id);
      return parent::supprimer($id);
    } else
      return -1;
  }
}