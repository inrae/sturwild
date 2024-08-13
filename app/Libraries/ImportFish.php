<?php

namespace App\Libraries;

use App\Models\Declaration;
use App\Models\Fish;
use App\Models\FishImport;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class ImportFish extends PpciLibrary
{

    protected FishImport $import;
    function __construct()
    {
        parent::__construct();
        $this->import = new FishImport();
    }

    function display()
    {
        $this->vue = service('Smarty');
        /*
         * Display the form
         */
        $this->vue->set("declaration/importFishCsv.tpl", "corps");
        $this->vue->send();
    }
    function control()
    {
        $this->vue = service('Smarty');
        /*
         * Lancement des controles
         */
        unset($_SESSION["filename"]);
        if (file_exists($_FILES['upfile']['tmp_name'])) {
            try {
                /**
                 * Verify the encoding
                 */
                $encodings = array("UTF-8", "iso-8859-1", "iso-8859-15");
                $currentEncoding = mb_detect_encoding(file_get_contents($_FILES['upfile']['tmp_name']), $encodings, true);
                if ($currentEncoding != "UTF-8" && $_REQUEST["utf8_encode"] == 0 || $currentEncoding == "UTF-8" && $_REQUEST["utf8_encode"] == 1) {
                    throw new PpciException(_("L'encodage du fichier ne correspond pas à celui que vous avez indiqué"));
                }
                /*
                 * start of control
                 */
                $_SESSION["importParameters"] = array(
                    "separator" => $_REQUEST["separator"],
                    "utf8_encode" => $_REQUEST["utf8_encode"],
                    "use_exchange_labels" => $_REQUEST["use_exchange_labels"]
                );
                $this->import->initFileCSV($_FILES['upfile']['tmp_name'], $_REQUEST["separator"], $_REQUEST["utf8_encode"]);
                $this->import->initParams();
                $this->import->declaration = new Declaration;
                $_REQUEST["use_exchange_labels"] ? $suffix = "_exchange" : $suffix = "_name";
                $this->import->verifyBeforeImport($suffix);
                if ($this->import->hasErrors) {
                    $this->vue->set(1, "hasErrors");
                    unset($_SESSION["importParameters"]);
                } else {
                    /*
                     * Move the file to the temporary folder
                     */
                    $filename = $this->appConfig->APP_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                    if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                        $this->message->set(_("Impossible de recopier le fichier importé dans le dossier temporaire"), true);
                    } else {
                        $_SESSION["importParameters"]["filename"] = $filename;
                        $_SESSION["importParameters"]["name"] = $_FILES['upfile']['name'];
                        $this->vue->set($_SESSION["importParameters"], "importParameters");
                    }
                    $this->vue->set(0, "hasErrors");
                }
                $this->vue->set($this->import->errors, "errors");
                $this->vue->set($this->import->paramToCreate, "parameters");
                $this->vue->set(1, "controlDone");
            } catch (PpciException $e) {
                $this->message->set($e->getMessage(), true);
                $this->vue->set(1, "hasErrors");
            }
        } else {
            $this->message->set(_("Aucun fichier n'a été téléchargé vers le serveur"), true);
        }
        return $this->display();
    }
    function csvExec()
    {
        if (isset($_SESSION["importParameters"])) {
            if (file_exists($_SESSION["importParameters"]["filename"])) {
                try {
                    /**
                     * Initialize classes
                     */
                    $this->import->declaration = new Declaration();
                    $this->import->fish = new Fish();
                    $_SESSION["importParameters"]["use_exchange_labels"] ? $suffix = "_exchange" : $suffix = "_name";
                    /*
                     * Start a transaction
                     */
                    $db = $this->import->declaration->db;
                    $db->transBegin();
                    $this->import->initFileCSV($_SESSION["importParameters"]["filename"], $_SESSION["importParameters"]["separator"], $_SESSION["importParameters"]["utf8_encode"]);
                    $this->import->initParams();
                    $this->import->exec($suffix);

                    if ($this->import->recorded == 0) {
                        $this->message->set(_("Aucun poisson n'a été importé dans la base de données. Il est possible qu'un problème technique soit survenu"), true);
                        $db->transRollback();
                    } else {
                        $db->transCommit();
                        $this->message->set(_("Importation effectuée"));
                        $this->message->set(sprintf(_("%1s poissons importés, dont %2s poissons mis à jour"), $this->import->recorded, $this->import->updated));
                        $this->message->set(sprintf(_("Id min traité ou généré : %1s, Id max : %2s"), $this->import->idMin, $this->import->idMax));
                        $this->log->setLog($_SESSION["login"], "importFishCSV", "fish_id from " . $this->import->idMin . " to " . $this->import->idMax);
                    }
                } catch (PpciException $e) {
                    if ($db->transEnabled) {
                        $db->transRollback();
                    }
                    $this->message->set($e->getMessage(), true);
                }
            } else {
                $this->message->set(_("Le fichier n'est plus disponible dans le serveur : recommencez l'opération"), true);
            }
        } else {
            $this->message->set(_("Une erreur s'est produite, recommencez l'opération"), true);
        }
        return $this->display();
    }
}
