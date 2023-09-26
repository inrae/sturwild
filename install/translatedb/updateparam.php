<?php
//require_once "../../vendor/autoload.php";
require_once "modules/classes/param.class.php";
//use PhpOffice\PhpSpreadsheet\Spreadsheet;
$inputFileName = "install/translatedb/parameters.ods";

$classeur = \PhpOffice\PhpSpreadsheet\IOFactory::load($inputFileName);
$sheets = $classeur->getAllSheets();
try {
    foreach ($sheets as $sheet) {
        $sheetname = $sheet->getCodeName();
        $param = new Param($bdd, $sheetname);
        $ok = true;
        $row = 2;

        while ($ok) {
            $id = $sheet->getCellByColumnAndRow(1, $row);
            if (!empty($id)) {
                $data = array(
                    $sheetname . "_id" => $id,
                    $sheetname . "_name" => $sheet->getCellByColumnAndRow(2, $row),
                    $sheetname . "_exchange" => $sheet->getCellByColumnAndRow(3, $row),
                    $sheetname . "_order" => $sheet->getCellByColumnAndRow(4, $row)
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
