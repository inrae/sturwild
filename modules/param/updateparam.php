<?php

switch ($t_module["param"]) {
    case "display":
        $vue->set("param/translateDb.tpl", "corps");
        break;
    case "exec":
        //require_once "../../vendor/autoload.php";
        require_once "modules/classes/param.class.php";
        //use PhpOffice\PhpSpreadsheet\Spreadsheet;
        try {
            if (!file_exists($_FILES['upfile']['tmp_name'])) {
                throw new Exception(_("Le fichier n'a pas pu être téléchargé"));
            }
            //$inputFileName = "install/translatedb/parameters_en.ods";

            $classeur = \PhpOffice\PhpSpreadsheet\IOFactory::load($_FILES['upfile']['tmp_name']);
            $sheetnames = $classeur->getSheetNames();
            foreach ($sheetnames as $sheetname) {
                $sheet = $classeur->getSheetByName($sheetname);
                $message->set(sprintf(_("Traitement de la feuille/table %s"), $sheetname));
                $param = new Param($bdd, $sheetname);
                $ok = true;
                $row = 2;

                while ($ok) {
                    $exchangeName = $sheet->getCellByColumnAndRow(3, $row)->getValue();
                    if (!empty($exchangeName)) {
                        /**
                         * Search from existent exchange name
                         */
                        $id = $param->getIdFromName($exchangeName);
                        $data = array(
                            $sheetname . "_id" => $id,
                            $sheetname . "_name" => $sheet->getCellByColumnAndRow(2, $row)->getValue(),
                            $sheetname . "_exchange" => $exchangeName,
                            $sheetname . "_order" => $sheet->getCellByColumnAndRow(4, $row)->getValue()
                        );
                        $param->ecrire($data);
                        $row++;
                    } else {
                        $ok = false;
                    }
                }
            }
        } catch (Exception $e) {
            $message->set($e->getMessage(), true);
            $module_coderetour = -1;
        }
        $module_coderetour = 1;
        break;
}
