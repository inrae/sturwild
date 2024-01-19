<?php
require_once "modules/classes/sturwildImport.class.php";
include_once "modules/classes/declarationImport.class.php";
require_once "modules/classes/param.class.php";
$import = new DeclarationImport();

switch ($t_module["param"]) {
    case "display":
        /*
         * Display the form
         */
        $vue->set("declaration/importCsv.tpl", "corps");
        printA($vue->get("controlDone"));
        break;
    case "control":
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
                $encodings = array("UTF-8", "iso-8859-1", "iso-8859-15");
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
                $import->institute = new Institute($bdd, $ObjetBDDParam);
                require_once "modules/classes/ices.class.php";
                $import->ices = new Ices($bdd, $ObjetBDDParam);
                $import->verifyBeforeImport();
                if ($import->hasErrors) {
                    $vue->set(1, "hasErrors");
                    unset($_SESSION["importParameters"]);
                } else {
                    /*
                     * Move the file to the temporary folder
                     */
                    $filename = $APPLI_temp . '/' . bin2hex(openssl_random_pseudo_bytes(4));
                    if (!copy($_FILES['upfile']['tmp_name'], $filename)) {
                        $message->set(_("Impossible de recopier le fichier importé dans le dossier temporaire"), true);
                    } else {
                        $_SESSION["importParameters"]["filename"] = $filename;
                        $_SESSION["importParameters"]["name"] = $_FILES['upfile']['name'];
                        $vue->set($_SESSION["importParameters"], "importParameters");
                    }
                    $vue->set(0, "hasErrors");
                }
                $vue->set($import->errors, "errors");
                $vue->set($import->paramToCreate, "parameters");
                $vue->set(1, "controlDone");
            } catch (Exception $e) {
                $message->set($e->getMessage(), true);
                $module_coderetour = -1;
                $vue->set(1, "hasErrors");
            }
        } else {
            $message->set(_("Aucun fichier n'a été téléchargé vers le serveur"), true);
        }
        break;
    case "csvExec":
        if (isset($_SESSION["importParameters"])) {
            if (file_exists($_SESSION["importParameters"]["filename"])) {
                try {
                    /**
                     * Initialize classes
                     */
                    require_once "modules/classes/declaration.class.php";
                    require_once "modules/classes/location.class.php";
                    $import->declaration = new Declaration($bdd, $ObjetBDDParam);
                    $import->location = new Location($bdd, $ObjetBDDParam);
                    include_once "modules/classes/institute.class.php";
                    $import->institute = new Institute($bdd, $ObjetBDDParam);
                    require_once "modules/classes/ices.class.php";
                    $import->ices = new Ices($bdd, $ObjetBDDParam);
                    /*
                     * Start a transaction
                     */
                    $bdd->beginTransaction();
                    $import->initFileCSV($_SESSION["importParameters"]["filename"], $_SESSION["importParameters"]["separator"], $_SESSION["importParameters"]["utf8_encode"]);
                    $import->initParams($bdd);
                    $import->exec($_SESSION["importParameters"]["use_exchange_labels"]);
                    
                    if ($import->recorded == 0) {
                        $message->set(_("Aucune déclaration n'a été importée dans la base de données. Il est possible qu'un problème technique soit survenu"),true);
                        $bdd->rollBack();
                    } else {
                    $bdd->commit();
                    $message->set(_("Importation effectuée"));
                    $message->set(sprintf(_("%1s déclarations importées, dont %2s déclarations mises à jour"), $import->recorded, $import->updated));
                    $message->set(sprintf(_("Id min traité ou généré : %1s, Id max : %2s"), $import->idMin, $import->idMax));
                    $log->setLog($_SESSION["login"],"importDeclarationsCSV", "declaration_id from ".$import->idMin. " to ".$import->idMax);
                    }
                    $module_coderetour = 1;
                } catch (Exception $e) {
                    if ($bdd->inTransaction()) {
                        $bdd->rollBack();
                    }
                    $module_coderetour = -1;
                    $message->set($e->getMessage(), true);
                }
            } else {
                $message->set(_("Le fichier n'est plus disponible dans le serveur : recommencez l'opération"), true);
                $module_coderetour = -1;
            }
        } else {
            $module_coderetour = -1;
            $message->set(_("Une erreur s'est produite, recommencez l'opération"), true);
        }
        break;
}
