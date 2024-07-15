<?php

namespace App\Models;

use Config\App;
use Ppci\Libraries\PpciException;
use Ppci\Models\PpciModel;

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 */
/**
 * ORM de gestion de la table mime_type
 *
 * @author quinton
 *
 */



/**
 * Orm de gestion de la table document :
 * Stockage des pièces jointes
 *
 * @author quinton
 *
 */
class Document extends PpciModel
{

    public $temp = "temp";
    // Chemin de stockage des images générées à la volée
    /**
     * Constructeur de la classe
     *
     * @param
     *            $bdd
     * @param array $param
     */
    public function __construct()
    {
        /**
         * @var App
         */
        $app = service('AppConfig');
        $this->temp = $app->APP_temp;
        $this->table = "document";
        $this->fields = array(
            "document_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "fish_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "mime_type_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "document_date_import" => array(
                "type" => 2,
                "requis" => 1
            ),
            "document_name" => array(
                "type" => 0,
                "requis" => 1
            ),
            "document_description" => array(
                "type" => 0
            ),
            "data" => array(
                "type" => 0
            ),
            "thumbnail" => array(
                "type" => 0
            ),
            "size" => array(
                "type" => 1,
                "defaultValue" => 0
            )
        );
        parent::__construct();
    }

    /**
     * Recupere les informations d'un document
     *
     * @param int $id
     * @return array
     */
    function getData($id)
    {
        if ($id > 0 && is_numeric($id)) {
            $sql = "select document_id, fish_id, document_name,  content_type, mime_type_id, extension
				from document
				join mime_type using (mime_type_id)
				where document_id = :document_id:";
            return $this->readParam($sql, ["document_id" => $id]);
        } else {
            return [];
        }
    }

    /**
     * Retourne la liste des documents associes a un poisson
     *
     * @param int $id
     * @return array
     */
    function getListFromFish($id)
    {
        if ($id > 0 && is_numeric($id)) {
            $sql = "select document_id, fish_id, document_name, document_description, size, document_date_import, content_type, mime_type_id
				from " . $this->table . "
				join mime_type using (mime_type_id)
				where fish_id = :fish_id: order by document_id";
            return $this->documentSearch($sql, array(
                "fish_id" => $id
            ));
        }
    }

    /**
     * Retourne le nombre de documents associes a une declaration
     *
     * @param int $declaration_id
     * @return array
     */
    function getNbFromDeclaration($declaration_id)
    {
        if (is_numeric($declaration_id) && $declaration_id > 0) {
            $sql = "select count(*) as document_nb
					from document
					natural join fish
					where declaration_id = :declaration_id:";
            return $this->lireParamAsPrepared($sql, array(
                "declaration_id" => $declaration_id
            ));
        }
    }

    /**
     * Retourne la liste des documents associes a une declaration
     *
     * @param int $declaration_id
     * @return array
     */
    function getListFromDeclaration($declaration_id)
    {
        if ($declaration_id > 0 && is_numeric($declaration_id)) {
            $sql = "select document_id, fish_id, document_name, document_description, 
                size, document_date_import, content_type, mime_type_id
				from document
				join mime_type using (mime_type_id)
				join fish using (fish_id)
				where declaration_id = :declaration_id:
				order by fish_id, document_id";
            return $this->documentSearch($sql, array(
                "declaration_id" => $declaration_id
            ));
        }
    }

    /**
     * Fonction permettant de retourner la liste des documents en fonction de la commande
     * sql passee en parametre.
     * Elle stocke les documents ou les photos et vignettes dans le dossier temporaire,
     * et retourne les chemins d'acces a ces documents
     *
     * @param string $sql
     * @return array
     */
    function documentSearch($sql, $param)
    {
        if (strlen($sql) > 0) {
            $data = $this->getListeParamAsPrepared($sql, $param);
            foreach ($data as $key => $value) {
                $data[$key]["photo_name"] = $this->writeFileImage($value["document_id"], 0);
                if (in_array($value["mime_type_id"], array(
                    1,
                    4,
                    5,
                    6,
                    7
                )))
                    $data[$key]["thumbnail_name"] = $this->writeFileImage($value["document_id"], 2);

                if (in_array($value["mime_type_id"], array(
                    4,
                    5,
                    6,
                    7
                )))
                    $data[$key]["photo800_name"] = $this->writeFileImage($value["document_id"], 1);
            }
            return $data;
        }
    }

    /**
     * Ecriture d'un document
     *
     * @param array $file
     *            : tableau contenant les informations sur le fichier importé
     *
     * @param
     *            int fish_id : cle de l'enregistrement pere
     * @param
     *            string description : description du contenu du document
     * @return int
     */
    function documentWrite($file, $fish_id, $description = NULL)
    {
        if ($file["error"] == 0 && $file["size"] > 0 && $fish_id > 0 && is_numeric($fish_id)) {
            /*
             * Recuperation de l'extension
             */
            $extension = substr($file["name"], strrpos($file["name"], ".") + 1);
            $mimeType = new MimeType();
            $mime_type_id = $mimeType->getTypeMime($extension);
            if ($mime_type_id > 0) {
                $data = array();
                $data["document_name"] = $file["name"];
                $data["size"] = $file["size"];
                $data["mime_type_id"] = $mime_type_id;
                $data["document_description"] = $description;
                $data["document_date_import"] = date("d/m/Y");
                $data["fish_id"] = $fish_id;
                $dataDoc = array(
                    "thumbnail" => "",
                    "data" => ""
                );
                /*
                 * Recherche pour savoir s'il s'agit d'une image ou d'un pdf pour créer une vignette
                 */
                $extension = strtolower($extension);
                /*
                 * Ecriture du document
                 */
                $dataBinaire = fread(fopen($file["tmp_name"], "r"), $file["size"]);

                $dataDoc["data"] = pg_escape_bytea($this->db->connID, $dataBinaire);
                if ($extension == "pdf" || $extension == "png" || $extension == "jpg" || $extension == "jpeg") {
                    $image = new \Imagick();
                    $image->readImageBlob($dataBinaire);
                    $image->setiteratorindex(0);
                    $image->resizeimage(200, 200, \imagick::FILTER_LANCZOS, 1, true);
                    $image->setformat("png");
                    $dataDoc["thumbnail"] = pg_escape_bytea($this->db->connID, $image->getimageblob());
                }
                /*
                 * suppression du stockage temporaire
                 */
                unset($file["tmp_name"]);
                /*
                 * Ecriture dans la base de données
                 */
                $id = parent::write($data);
                if ($id > 0) {
                    $dataDoc["document_id"] = $id;
                    $sql = "update document set data = '" . $dataDoc["data"] . "', thumbnail = '" . $dataDoc["thumbnail"] . "' where document_id = " . $id;
                    $this->executeSQL($sql,[], true);
                }
                return $id;
            }
        }
    }

    /**
     * Fonction ecrivant les documents dans le dossier temporaire
     * pour utilisation via un lien
     *
     * @param int $id
     *            : numero du document
     * @param number $type
     *            : 0 : photo plein format, 1 : photo en resolution 800, 2, : vignette
     * @return string
     */
    function writeFileImage($id, $type = 0, $resolution = 800)
    {
        if ($id > 0 && is_numeric($id)) {
            $data = $this->getData($id);
            /*
             * Preparation du nom de la photo
             */
            switch ($type) {
                case 1:
                    $colonne = "data";
                    $filename = $this->temp . '/' . $id . "x" . $resolution . "." . $data["extension"];
                    break;
                case 2:
                    $colonne = "thumbnail";
                    $filename = $this->temp . '/' . $id . '_vignette.png';
                    break;
                default:
                    $colonne = "data";
                    $filename = $this->temp . '/' . $id . "-" . $data["document_name"];
            }

            /*
             * Traitement des photos
             */
            if (!file_exists($filename)) {
                try {
                    $sql = "select $colonne as picture from document where document_id = :id:";
                    $data = $this->readParam($sql, ["id" => $id]);
                    if (empty($data)) {
                        throw new PpciException(_("Le document demandé n'existe pas"));
                    }
                    if (($data["mime_type_id"] == 4 || $data["mime_type_id"] == 5 || $data["mime_type_id"] == 6)) {
                        $image = new \Imagick();
                        try {
                            $image->readImageBlob(pg_unescape_bytea($data["picture"]));
                            if ($type == 1) {
                                $resize = false;
                                $geo = $image->getimagegeometry();
                                if ($geo["width"] > $resolution || $geo["height"] > $resolution) {
                                    $resize = true;
                                    if ($resize) {
                                        /*
                                    * Mise a l'image de la photo
                                    */
                                        $image->resizeImage($resolution, $resolution, \Imagick::FILTER_LANCZOS, 1, true);
                                    }
                                }
                            }
                            /**
                             * Ecriture de la photo
                             */
                            $image->writeImage($filename);
                        } catch (\ImagickException $ie) {
                            throw new PpciException(sprintf(_("Impossible de lire la photo %s : "),  $id) . $ie->getMessage());
                        }
                    } else {
                        /**
                         * Others docs
                         */
                        $handle = fopen($filename, 'wb');
                        fwrite($handle, pg_unescape_bytea($data["picture"]));
                        fclose($handle);
                    }
                } catch (PpciException $e) {
                    throw new PpciException($e->getMessage());
                }
            }
            return $filename;
        }
    }

    /**
     * Envoie un fichier au navigateur, pour affichage
     *
     * @param int $id
     *            : cle de la photo
     * @param int $phototype
     *            : 0 - photo originale, 1 - resolution fournie, 2 - vignette
     * @param boolean $attached
     * @param int $resolution
     *            : resolution pour les photos redimensionnees
     */
    function prepareDocument($id, $phototype = 0, $resolution = 800)
    {
        $filename = $this->generateFileName($id, $phototype, $resolution);
        if (strlen($filename) > 0 && is_numeric($id) && $id > 0) {
            if (!file_exists($filename))
                $this->writeFileImage($id, $phototype, $resolution);
        }
        if (file_exists($filename))
            return $filename;
    }

    /**
     * Calcule le nom de la photo
     *
     * @param int $id
     * @param int $phototype
     *            : type de la photo - 0 : original, 1 : photo reduite, 2 : vignette
     * @param number $resolution
     * @return string
     */
    function generateFileName(int $id, $phototype = 0, $resolution = 800)
    {
        /*
         * Preparation du nom de la photo
         */
        $data = $this->getData($id);
        switch ($phototype) {
            case 0:
                $filename = $this->temp . '/' . $id . "-" . $data["document_name"];
                break;
            case 1:
                $filename = $this->temp . '/' . $id . "x" . $resolution . "." . $data["extension"];
                break;
            case 2:
                $filename = $this->temp . '/' . $id . '_vignette.png';
        }
        return $filename;
    }
}
