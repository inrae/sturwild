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
require_once 'modules/classes/evenement.class.php';
require_once 'modules/classes/individu.class.php';
require_once 'modules/classes/localisation.class.php';
require_once 'modules/classes/document.class.php';

class Declaration extends ObjetBDD
{
    private $paramSearch = array();
    private $fromSearch = " from declaration
				join statut using (statut_id)
				left outer join localisation using (declaration_id)
				left outer join espece using (espece_id)
				left outer join pays using (pays_id)
				left outer join ciem using (ciem_id)
				left outer join milieu using (milieu_id)
				left outer join milieu_detail using (milieu_detail_id)
				left outer join region using (region_id)
				left outer join engin_type using (engin_type_id)
				left outer join capture_mode using (capture_mode_id)
				left outer join capture_type using (capture_type_id)
				left outer join capture_etat using (capture_etat_id)
				left outer join devenir using (devenir_id)";

    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    function __construct($link, $param = NULL)
    {
        if (! is_array($param))
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
            "statut_id" => array(
                "type" => 0,
                "requis" => 1,
                "defaultValue" => 1
            ),
            "capture_mode_id" => array(
                "type" => 1
            ),
            "capture_type_id" => array(
                "type" => 1
            ),
            "capture_etat_id" => array(
                "type" => 1
            ),
            "capture_date" => array(
                "type" => 2
            ),
            "annee" => array(
                "type" => 1,
                "defaultValue" => "getAnnee"
            ),
            "capture_date_estimee" => array(
                "type" => 0
            ),
            "engin_type_id" => array(
                "type" => 1
            ),
            "engin_maille" => array(
                "type" => 0
            ),
            "espece_ciblee" => array(
                "type" => 0
            ),
            "profondeur" => array(
                "type" => 1
            ),
            "pecheur_code" => array(
                "type" => 0
            ),
            "interlocuteur" => array(
                "type" => 0
            ),
            "interlocuteur_coord" => array(
                "type" => 0
            ),
            "navire_port" => array(
                "type" => 0
            ),
            "declaration_mode" => array(
                "type" => 0
            ),
            "observation" => array(
                "type" => 0
            ),
            "espece_id" => array(
                "type" => 1,
                "defaultValue" => 1
            ),
            "qualite_identification" => array(
                "type" => 1
            ),
            "prof_min" => array(
                "type" => 1
            ),
            "prof_max" => array(
                "type" => 1
            ),
            "lt_min" => array(
                "type" => 1
            ),
            "lt_max" => array(
                "type" => 1
            ),
            "masse_min" => array(
                "type" => 1
            ),
            "masse_max" => array(
                "type" => 1
            ),
            "nombre_capture" => array(
                "type" => 1,
                "requis" => 1,
                "defaultValue" => 1
            ),
            "manipulation" => array(
                "type" => 0
            ),
            "devenir_id" => array(
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
                    "annee" => $data["annee"],
                    "capture_type_id" => $data["capture_type_id"],
                    "capture_mode_id" => $data["capture_mode_id"],
                    "pecheur_code" => $data["pecheur_code"],
                    "interlocuteur" => $data["interlocuteur"],
                    "interlocuteur_coord" => $data["interlocuteur_coord"],
                    "navire_port" => $data["navire_port"],
                    "declaration_mode" => $data["declaration_mode"],
                    "statut_id" => 1,
                    "nombre_capture" => 1,
                    "espece_id" => 1,
                    "qualite_identification" => 1
                );
                /*
                 * Creation de la nouvelle declaration
                 */
                $idNew = $this->ecrire($dataNew);
                if ($idNew > 0) {
                    /*
                     * creation de l'evenement associe
                     */
                    $evenement = new Evenement($this->connection, $this->paramori);
                    $dataEvenement = $evenement->lire(0, true, $idNew);
                    $evenement->ecrire($dataEvenement);
                    /*
                     * Duplication de la localisation
                     */
                    $localisation = new Localisation($this->connection, $this->paramori);
                    $localisation->duplicate($id, $idNew);
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
        $sql = "select declaration.declaration_id, statut_id, statut_libelle, 
				capture_date, annee, capture_date_estimee,
				pecheur_code, interlocuteur,
				pays_libelle, ciem_libelle, milieu_libelle, region_libelle,
				nombre_capture, espece_libelle,
				capture_etat_libelle, engin_type_libelle
				";
        $where = $this->getWhere($param);
        $order = " order by declaration_id desc";
        $data = $this->getListeParamAsPrepared($sql . $this->fromSearch . $where . $order,$this->paramSearch);
        /*
         * Rajout du nombre de photos associees
         */
        $document = new Document($this->connection, $this->paramori);
        foreach ($data as $key => $value) {
            $dataNb = $document->getNbFromDeclaration($value["declaration_id"]);
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
        $param = $this->encodeData($param);
        $this->paramSearch = array();
        $and = "";
        /*
         * Preparation de la requete where
         */
        if (is_numeric($param["annee_debut"]) && is_numeric($param["annee_fin"])) {
            $where = " where annee between :annee_debut and :annee_fin";
            $this->paramSearch["annee_debut"] = $param["annee_debut"];
            $this->paramSearch["annee_fin"] = $param["annee_fin"];
            $and = " and ";
        }
        if ($param["statut_id"] > 0 && is_numeric($param["statut_id"])) {
            $where .= " $and statut_id = :statut_id";
            $and = " and ";
            $this->paramSearch["statut_id"] = $param["statut_id"];
            
        }
        if ($param["ciem_id"] > 0 && is_numeric($param["ciem_id"])) {
            $where .= " $and ciem_id = :ciem_id";
            $and = " and ";
            $this->paramSearch["ciem_id"] = $param["ciem_id"];
            
        }
        if ($param["pays_id"] > 0 && is_numeric($param["pays_id"])) {
            $where .= " $and pays_id = :pays_id";
            $and = " and ";
            $this->paramSearch["pays_id"] = $param["pays_id"];
            
        }
        if ($param["region_id"] > 0 && is_numeric($param["region_id"])) {
            $where .= " $and region_id = :region_id";
            $and = " and ";
            $this->paramSearch["region_id"] = $param["region_id"];
            
        }
        if ($param["milieu_id"] > 0 && is_numeric($param["milieu_id"])) {
            $where .= " $and milieu_id = :milieu_id";
            $and = " and ";
            $this->paramSearch["milieu_id"] = $param["milieu_id"];
            
        }
        if ($param["capture_etat_id"] > 0 && is_numeric($param["capture_etat_id"])) {
            $where .= " $and capture_etat_id = :capture_etat_id";
            $and = " and ";
            $this->paramSearch["capture_etat_id"] = $param["capture_etat_id"];
            
        }
        if ($param["espece_id"] > 0 && is_numeric($param["espece_id"])) {
            $where .= " $and espece_id = :espece_id";
            $and = " and ";
            $this->paramSearch["espece_id"] = $param["espece_id"];
            
        }
        if ($param["engin_type_id"] > 0 && is_numeric($param["engin_type_id"])) {
            $where .= " $and engin_type_id = :engin_type_id";
            $and = " and ";
            $this->paramSearch["engin_type_id"] = $param["engin_type_id"];
            
        }
        if (strlen($param["libelle"]) > 0) {
            $libelle = "%".$param["libelle"]."%";
            $this->paramSearch["libelleText1"] =$libelle;
            $this->paramSearch["libelleText2"] = $libelle;
                                    $where .= " $and (upper(pecheur_code) like upper(:libelleText1)";
            $where .= " or upper(interlocuteur) like upper(:libelleText2)";
            if (is_numeric($param["libelle"])) {
                $where .= " or declaration_id = :libelle";
                $this->paramSearch["libelle"] = $param["libelle"];
            }
            $where .= ")";
        }
        return $where;
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
				pays_libelle, ciem_libelle, milieu_libelle, region_libelle, milieu_detail_libelle,
				zone_detail,
				capture_mode_libelle, capture_type_libelle, capture_etat_libelle,
				statut_libelle, engin_type_libelle,
				longitude_dd, latitude_dd, devenir_libelle, qualite_identification
				from declaration
				join statut using (statut_id)
				left outer join localisation using (declaration_id)
				left outer join espece using (espece_id)
				left outer join pays using (pays_id)
				left outer join ciem using (ciem_id)
				left outer join milieu using (milieu_id)
				left outer join milieu_detail using (milieu_detail_id)
				left outer join region using (region_id)
				left outer join engin_type using (engin_type_id)
				left outer join capture_mode using (capture_mode_id)
				left outer join capture_type using (capture_type_id)
				left outer join capture_etat using (capture_etat_id)
				left outer join devenir using (devenir_id)
				";
        $where = $this->getWhere($param);
        $order = " order by declaration.declaration_id desc";
        $data = $this->getListeParamAsPrepared($sql . $where . $order, $this->paramSearch);
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
     * Retourne l'annee courante
     *
     * @return int
     */
    function getAnnee()
    {
        return date('Y');
    }

    /**
     * Calcule le nombre d'esturgeons d'Europe captures par annee
     * 
     * @return array
     */
    function getNbSturioByYear()
    {
        $sql = "select annee, sum(nombre_capture) as nombre_capture 
				from declaration
				where espece_id = 1
				group by annee
				order by annee";
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
            $sql = "select * 
					from declaration
					join statut using (statut_id)
					left outer join capture_mode using (capture_mode_id)
					left outer join capture_type using (capture_type_id)
					left outer join engin_type using (engin_type_id)
					left outer join espece using (espece_id)
					left outer join capture_etat using (capture_etat_id)
					left outer join devenir using (devenir_id)
					where declaration_id = :declaration_id";
            return $this->lireParamAsPrepared($sql, array("declaration_id"=>$id));
        }
    }

    /**
     * Surcharge de la fonction write pour creer un evenement de saisie
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
        
        if ($id > 0 && is_numeric($id) && $creation == true) {
            /*
             * Generation de l'evenement de saisie
             */
            $evenement = new Evenement($this->connection, $this->paramori);
            $dataEvnmt = $evenement->getDefaultValue($id);
            $evenement->ecrire($dataEvnmt);
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
            $evenement = new Evenement($this->connection, $this->paramori);
            $evenement->deleteFromField($id, "declaration_id");
            /*
             * $lot = new Lot ( $this->connection, $this->paramori );
             * $lot->supprimer ( $id );
             */
            $individu = new Individu($this->connection, $this->paramori);
            $individu->supprimerChamp($id, "declaration_id");
            $localisation = new Localisation($this->connection, $this->paramori);
            $localisation->supprimer($id);
            return parent::supprimer($id);
        } else
            return - 1;
    }
}

/**
 * ORM de gestion de la table statut
 *
 * @author quinton
 *        
 */
class Statut extends ObjetBDD
{

    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    function __construct($link, $param = NULL)
    {
        if (! is_array($param))
            $param = array();
        $this->table = "statut";
        $this->id_auto = 1;
        $this->colonnes = array(
            "statut_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "statut_libelle" => array(
                "requis" => 1
            )
        );
        $param["fullDescription"] = 1;
        parent::__construct($link, $param);
    }
}

/**
 * ORM de gestion de la table statut
 *
 * @author quinton
 *        
 */
class Capture_mode extends ObjetBDD
{

    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    function __construct($link, $param = NULL)
    {
        if (! is_array($param))
            $param = array();
        $this->table = "capture_mode";
        $this->id_auto = 1;
        $this->colonnes = array(
            "capture_mode_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "capture_mode_libelle" => array(
                "requis" => 1
            )
        );
        $param["fullDescription"] = 1;
        parent::__construct($link, $param);
    }
}

/**
 * ORM de gestion de la table capture_type
 *
 * @author quinton
 *        
 */
class Capture_type extends ObjetBDD
{

    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    function __construct($link, $param = array())
    {
        $this->table = "capture_type";
        $this->id_auto = 1;
        $this->colonnes = array(
            "capture_type_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "capture_type_libelle" => array(
                "requis" => 1
            )
        );
        $param["fullDescription"] = 1;
        parent::__construct($link, $param);
    }
}

/**
 * ORM de gestion de la table capture_etat
 *
 * @author quinton
 *        
 */
class Capture_etat extends ObjetBDD
{

    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    function __construct($link, $param = NULL)
    {
        if (! is_array($param))
            $param = array();
        $this->table = "capture_etat";
        $this->id_auto = 1;
        $this->colonnes = array(
            "capture_etat_id" => array(
                "etat" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "capture_etat_libelle" => array(
                "requis" => 1
            )
        );
        $param["fullDescription"] = 1;
        parent::__construct($link, $param);
    }
}

/**
 * ORM de gestion de la table engin_type
 *
 * @author quinton
 *        
 */
class Engin_type extends ObjetBDD
{

    /**
     * Constructeur
     *
     * @param PDO $link
     * @param array $param
     */
    function __construct($link, $param = NULL)
    {
        if (! is_array($param))
            $param = array();
        $this->table = "engin_type";
        $this->id_auto = 1;
        $this->colonnes = array(
            "engin_type_id" => array(
                "type" => 1,
                "requis" => 1,
                "key" => 1,
                "defaultValue" => 0
            ),
            "engin_type_libelle" => array(
                "requis" => 1
            )
        );
        $param["fullDescription"] = 1;
        parent::__construct($link, $param);
    }
}
?>