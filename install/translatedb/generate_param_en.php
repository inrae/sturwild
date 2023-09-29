<?php
$inputFileName = "install/translatedb/parameters_en.ods";
$sqlfilename = "install/translatedb/param_en.sql";
$sqlfile = fopen($sqlfilename, "w");
$classeur = \PhpOffice\PhpSpreadsheet\IOFactory::load($inputFileName);
$sheetnames = $classeur->getSheetNames();

try {
    foreach ($sheetnames as $sheetname) {
        $sheet = $classeur->getSheetByName($sheetname);
        $message->set("Traitement de la feuille $sheetname");
        $radical = "insert into sturwild.$sheetname (".
            $sheetname."_name,". $sheetname."_exchange,".$sheetname."_order)".   PHP_EOL .
            " values ".PHP_EOL;
            fwrite($sqlfile, $radical);
            $content = "";
        $ok = true;
        $row = 2;

        while ($ok) {
            $id = $sheet->getCellByColumnAndRow(1, $row)->getValue();

            $data = array(
                "id" => $id,
                "name" => $sheet->getCellByColumnAndRow(2, $row)->getValue(),
                "exchange" => $sheet->getCellByColumnAndRow(3, $row)->getValue(),
                "order" => $sheet->getCellByColumnAndRow(4, $row)->getValue()
            );
            if (!empty ($content)) {
                $content = ",".PHP_EOL;
            }
            if (!empty($data["name"])) {
                $content .= "('".$data["name"]."','".$data["exchange"]."',".$data["order"].")";
                fwrite($sqlfile,$sql.$content);
                $row++;
            } else {
                $ok = false;
                fwrite($sqlfile,";".PHP_EOL);
            }
        }
    }
    fclose($sqlfile);
} catch (Exception $e) {
    $message->set($e->getMessage(), true);
}
$module_coderetour = 1;