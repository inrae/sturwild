<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Xx extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $this->dataClass;

    function __construct()
    {
        parent::__construct();
        $this->dataClass = new \App\Models\XXX();
        $keyName = "xxx_id";
        if (isset($_REQUEST[$keyName])) {
            $this->id = $_REQUEST[$keyName];
        }
    }
require_once "modules/classes/sturwildImport.class.php";
include_once "modules/classes/declarationImport.class.php";
require_once "modules/classes/param.class.php";
$import = new DeclarationImport();


    function display(){
$this->vue=service('Smarty');
        /*
         * Display the form
         */
        $this->vue->set("declaration/importCsv.tpl", "corps");
        ]
    case "control() {
        /*
         * Lancement des controles
         */
        unset($_SESSION["filename"]);
        if (file_exists($_FILES['upfile']['tmp_name'])) {
            try {
                /**
                 * Verify the encoding
                 */
                $module_coderetour = 1;
                $encodings = array("UTF-8", "iso-8859-1", "iso-8859-15", "windows-1252");
                $currentEncoding = mb_detect_encoding(file_get_contents($_FILES['upfile']['tmp_name']), $encodings, true);
                if ($currentEncoding != "UTF-8" && $_REQUEST["utf8_encode"] == 0 || $currentEncoding == "UTF-8" && $_REQUEST["utf8_encode"] == 1) {
                    throw new SturwildImportException(_("L'encodage du fichier ne correspond pas à celui que vous avez indiqué"));
                }
                /*
                 * start of control
                 */
                $_SESSION["importParameters"] = array(
                    "separator" => $_REQUEST["separator"],
                    "utf8_encode" => $_REQUEST["utf8_encode"],
                    "use_exchange_labels" => $_REQUEST["use_exchange_labels"]
                );
                $import->initFileCSV($_FILES['upfile']['tmp_name'], $_REQUEST["separator"], $_REQUEST["utf8_encode"]);
                $import->initParams($bdd);
                include_once "modules/classes/institute.class.php";
                $import->institute = new Institute();
                require_once "modules/classes/ices.class.php";
                $import->ices = new Ices();
                $_REQUEST["use_exchange_labels"] ? $suffix = "_exchange() { $suffix = "_name";
                $import->verifyBeforeImport($suffix);
                if ($import->hasErrors) {
                    $this->vue->set(1, "hasErrors");
                    unset($_SESSION["importParameters"]);
                } else {
                    /*
                     * Move the file to the temporary folder
                     */
                    $filename = $APPLI_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                    if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                        $this->message->set(_("Impossible de recopier le fichier importé dans le dossier temporaire"), true);
                    } else {
                        $_SESSION["importParameters"]["filename"] = $filename;
                        $_SESSION["importParameters"]["name"] = $_FILES['upfile']['name'];
                        $this->vue->set($_SESSION["importParameters"], "importParameters");
                    }
                    $this->vue->set(0, "hasErrors");
                }
                $this->vue->set($import->errors, "errors");
                $this->vue->set($import->paramToCreate, "parameters");
                $this->vue->set(1, "controlDone");
            } catch (Exception $e) {
                $this->message->set($e->getMessage(), true);
                $module_coderetour = -1;
                $this->vue->set(1, "hasErrors");
            }
        } else {
            $this->message->set(_("Aucun fichier n'a été téléchargé vers le serveur"), true);
        }
        ]
    case "csvExec() {
        if (isset($_SESSION["importParameters"])) {
            if (file_exists($_SESSION["importParameters"]["filename"])) {
                try {
                    /**
                     * Initialize classes
                     */
                    require_once "modules/classes/declaration.class.php";
                    require_once "modules/classes/location.class.php";
                    $import->declaration = new Declaration();
                    $import->location = new Location();
                    include_once "modules/classes/institute.class.php";
                    $import->institute = new Institute();
                    require_once "modules/classes/ices.class.php";
                    $import->ices = new Ices();
                    /*
                     * Start a transaction
                     */
                    $bdd->beginTransaction();
                    $import->initFileCSV($_SESSION["importParameters"]["filename"], $_SESSION["importParameters"]["separator"], $_SESSION["importParameters"]["utf8_encode"]);
                    $import->initParams($bdd);
                    $_SESSION["importParameters"]["use_exchange_labels"] ? $suffix = "_exchange() { $suffix = "_name";
                    $import->exec($suffix);

                    if ($import->recorded == 0) {
                        $this->message->set(_("Aucune déclaration n'a été importée dans la base de données. Il est possible qu'un problème technique soit survenu"), true);
                        $bdd->rollBack();
                    } else {
                        $bdd->commit();
                        $this->message->set(_("Importation effectuée"));
                        $this->message->set(sprintf(_("%1s déclarations importées, dont %2s déclarations mises à jour"), $import->recorded, $import->updated));
                        $this->message->set(sprintf(_("Id min traité ou généré : %1s, Id max : %2s"), $import->idMin, $import->idMax));
                        $log->setLog($_SESSION["login"], "importDeclarationsCSV", "declaration_id from " . $import->idMin . " to " . $import->idMax);
                    }
                    $module_coderetour = 1;
                } catch (Exception $e) {
                    if ($bdd->inTransaction()) {
                        $bdd->rollBack();
                    }
                    $module_coderetour = -1;
                    $this->message->set($e->getMessage(), true);
                }
            } else {
                $this->message->set(_("Le fichier n'est plus disponible dans le serveur : recommencez l'opération"), true);
                $module_coderetour = -1;
            }
        } else {
            $module_coderetour = -1;
            $this->message->set(_("Une erreur s'est produite, recommencez l'opération"), true);
        }
        ]
        case "jsonDisplay() {
            $this->vue->set("declaration/importJson.tpl", "corps");
            ]
    case "jsonControl() {
        unset($_SESSION["filename"]);
        if (file_exists($_FILES['upfile']['tmp_name'])) {
            try {
                /**
                 * Verify the encoding
                 */
                $module_coderetour = 1;
                $encodings = array("UTF-8", "iso-8859-1", "iso-8859-15", "windows-1252");
                $currentEncoding = mb_detect_encoding(file_get_contents($_FILES['upfile']['tmp_name']), $encodings, true);
                if ($currentEncoding != "UTF-8" && $_REQUEST["utf8_encode"] == 0 || $currentEncoding == "UTF-8" && $_REQUEST["utf8_encode"] == 1) {
                    throw new SturwildImportException(_("L'encodage du fichier ne correspond pas à celui que vous avez indiqué"));
                }
                /*
                 * start of control
                 */
                $_SESSION["importParameters"] = array(
                    "utf8_encode" => $_REQUEST["utf8_encode"],
                    "use_exchange_labels" => $_REQUEST["use_exchange_labels"]
                );
                $import->initFileJson($_FILES['upfile']['tmp_name'], $_REQUEST["utf8_encode"]);
                $import->initParams($bdd);
                include_once "modules/classes/institute.class.php";
                $import->institute = new Institute();
                require_once "modules/classes/ices.class.php";
                $import->ices = new Ices();
                require_once "modules/classes/fishImport.class.php";
                $fishImport = new FishImport();
                $_REQUEST["use_exchange_labels"] ? $suffix = "_exchange() { $suffix = "_name";
                $import->verifyBeforeImport($suffix);
                $fishImport->initParams($bdd);
                /**
                 * Verify for fish
                 */
                foreach ($import->getFileContent() as $decl) {
                    foreach ($decl["fishes"] as $fishRow) {
                        $fishImport->rowSearchParameters($fishRow,$suffix,false);
                    }
                }
                if ($import->hasErrors) {
                    $this->vue->set(1, "hasErrors");
                    unset($_SESSION["importParameters"]);
                } else {
                    /*
                     * Move the file to the temporary folder
                     */
                    $filename = $APPLI_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                    if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                        $this->message->set(_("Impossible de recopier le fichier importé dans le dossier temporaire"), true);
                    } else {
                        $_SESSION["importParameters"]["filename"] = $filename;
                        $_SESSION["importParameters"]["name"] = $_FILES['upfile']['name'];
                        $this->vue->set($_SESSION["importParameters"], "importParameters");
                    }
                    $this->vue->set(0, "hasErrors");
                }
                $this->vue->set($import->errors, "errors");
                $this->vue->set($import->paramToCreate, "parameters");
                $this->vue->set(1, "controlDone");
            } catch (Exception $e) {
                $this->message->set($e->getMessage(), true);
                $module_coderetour = -1;
                $this->vue->set(1, "hasErrors");
            }
        } else {
            $this->message->set(_("Aucun fichier n'a été téléchargé vers le serveur"), true);
        }
        ]

    case "jsonExec() {
        if (isset($_SESSION["importParameters"])) {
            if (file_exists($_SESSION["importParameters"]["filename"])) {
                try {
                    /**
                     * Initialize classes
                     */
                    require_once "modules/classes/declaration.class.php";
                    require_once "modules/classes/location.class.php";
                    $import->declaration = new Declaration();
                    $import->location = new Location();
                    include_once "modules/classes/institute.class.php";
                    $import->institute = new Institute();
                    require_once "modules/classes/ices.class.php";
                    $import->ices = new Ices();
                    require_once "modules/classes/fish.class.php";
                    
                    require_once "modules/classes/fishImport.class.php";
                    $import->fishImport = new FishImport();
                    $import->fishImport->fish = new Fish();
                    /*
                     * Start a transaction
                     */
                    $bdd->beginTransaction();
                    $import->initFileJson($_SESSION["importParameters"]["filename"], $_SESSION["importParameters"]["utf8_encode"]);
                    $import->initParams($bdd);
                    $import->fishImport->initParams($bdd);
                    $_SESSION["importParameters"]["use_exchange_labels"] ? $suffix = "_exchange() { $suffix = "_name";
                    $import->exec($suffix);
                    if ($import->recorded == 0) {
                        $this->message->set(_("Aucune déclaration n'a été importée dans la base de données. Il est possible qu'un problème technique soit survenu"), true);
                        $bdd->rollBack();
                    } else {
                        $bdd->commit();
                        $this->message->set(_("Importation effectuée"));
                        $this->message->set(sprintf(_("%1s déclarations importées, dont %2s déclarations mises à jour"), $import->recorded, $import->updated));
                        $this->message->set(sprintf(_("Id min traité ou généré : %1s, Id max : %2s"), $import->idMin, $import->idMax));
                        $log->setLog($_SESSION["login"], "importDeclarationsJSON", "declaration_id from " . $import->idMin . " to " . $import->idMax);
                    }
                    $module_coderetour = 1;
                } catch (Exception $e) {
                    if ($bdd->inTransaction()) {
                        $bdd->rollBack();
                    }
                    $module_coderetour = -1;
                    $this->message->set($e->getMessage(), true);
                }
            } else {
                $this->message->set(_("Le fichier n'est plus disponible dans le serveur : recommencez l'opération"), true);
                $module_coderetour = -1;
            }
        } else {
            $module_coderetour = -1;
            $this->message->set(_("Une erreur s'est produite, recommencez l'opération"), true);
        }
        ]

}
