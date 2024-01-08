<?php
include_once "modules/classes/declarationImport.class.php";
require_once "modules/classes/param.class.php";
$import = new DeclarationImport();

switch ($t_module["param"]) {
    case "change":
        /*
         * Affichage du masque de selection du fichier a importer
         */
        $vue->set(1, "onlyCollectionSearch");
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
                $encodings = array("UTF-8", "iso-8859-1", "iso-8859-15");
                $currentEncoding = mb_detect_encoding(file_get_contents($_FILES['upfile']['tmp_name']), $encodings, true);
                if ($currentEncoding != "UTF-8" && $_REQUEST["utf8_encode"] == 0 || $currentEncoding == "UTF-8" && $_REQUEST["utf8_encode"] == 1) {
                    throw new DeclarationImportException(_("L'encodage du fichier ne correspond pas à celui que vous avez indiqué"));
                }
                /*
                 * Lancement du controle
                 */
                $import->initFileCSV($_FILES['upfile']['tmp_name'], $_REQUEST["separator"], $_REQUEST["utf8_encode"]);

            } catch (Exception $e) {
                $message->set($e->getMessage(), true);
            }
        }
        $import->fileClose();
        $module_coderetour = 1;
        $vue->set($_REQUEST["separator"], "separator");
        $vue->set($_REQUEST["utf8_encode"], "utf8_encode");
        $vue->set($_REQUEST["onlyCollectionSearch"], "onlyCollectionSearch");
        break;
    case "import":
        if (isset($_SESSION["filename"])) {
            if (file_exists($_SESSION["filename"])) {
            }
        }
        break;
}
