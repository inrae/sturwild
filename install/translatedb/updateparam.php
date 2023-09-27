<?php
//require_once "../../vendor/autoload.php";
require_once "modules/classes/param.class.php";
//use PhpOffice\PhpSpreadsheet\Spreadsheet;
$inputFileName = "install/translatedb/parameters.ods";

$classeur = \PhpOffice\PhpSpreadsheet\IOFactory::load($inputFileName);
$sheetnames = $classeur->getSheetNames();

try {
    foreach ($sheetnames as $sheetname) {
        $sheet = $classeur->getSheetByName($sheetname);
        $message->set("Traitement de la feuille/table $sheetname");
        $param = new Param($bdd, $sheetname);
        $ok = true;
        $row = 2;

        while ($ok) {
            $id = $sheet->getCellByColumnAndRow(1, $row)->getValue();
            if (!empty($id)) {
                $data = array(
                    $sheetname . "_id" => $id,
                    $sheetname . "_name" => $sheet->getCellByColumnAndRow(2, $row)->getValue(),
                    $sheetname . "_exchange" => $sheet->getCellByColumnAndRow(3, $row)->getValue(),
                    $sheetname . "_order" => $sheet->getCellByColumnAndRow(4, $row)->getValue()
                );
                $param->ecrire($data);
                $row ++;
            } else {
                $ok = false;
            }
        }
    }
} catch (Exception $e) {
    $message->set($e->getMessage(), true);
}
$module_coderetour = 1;
