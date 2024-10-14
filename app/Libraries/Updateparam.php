<?php

namespace App\Libraries;

use App\Models\Param;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Updateparam extends PpciLibrary
{

    protected PpciModel $dataclass;


    function display()
    {
        $this->vue = service('Smarty');
        $this->vue->set("param/translateDb.tpl", "corps");
        $this->vue->send();
    }
    function exec()
    {
        try {
            if (!file_exists($_FILES['upfile']['tmp_name'])) {
                throw new PpciException(_("Le fichier n'a pas pu être téléchargé"));
            }
            $classeur = \PhpOffice\PhpSpreadsheet\IOFactory::load($_FILES['upfile']['tmp_name']);
            $sheetnames = $classeur->getSheetNames();
            foreach ($sheetnames as $sheetname) {
                $sheet = $classeur->getSheetByName($sheetname);
                $this->message->set(sprintf(_("Traitement de la feuille/table %s"), $sheetname));
                $param = new Param( $sheetname);
                $ok = true;
                $row = 2;

                while ($ok) {
                    $exchangeName = $sheet->getCell([3, $row])->getValue();
                    if (!empty($exchangeName)) {
                        /**
                         * Search from existent exchange name
                         */
                        $this->id = $param->getIdFromName($exchangeName);
                        $data = array(
                            $sheetname . "_id" => $this->id,
                            $sheetname . "_name" => $sheet->getCell([2, $row])->getValue(),
                            $sheetname . "_exchange" => $exchangeName,
                            $sheetname . "_order" => $sheet->getCell([4, $row])->getValue()
                        );
                        $param->write($data);
                        $row++;
                    } else {
                        $ok = false;
                    }
                }
            }
        } catch (\Exception $e) {
            $this->message->set($e->getMessage(), true);
        }
        return $this->display();
    }
    function gettemplate()
    {
        $this->vue = service("BinaryView");
        $this->vue->setParam(
            [
                "filename" => "parameters_en.ods", /* nom du fichier tel qu'il apparaitra dans le navigateur */
                "disposition" => "attachment", /* attachment : le fichier est telecharge, inline : le fichier est affiche */
                "content_type" => "application/vnd.oasis.opendocument.spreadsheet", /* type mime */
                "tmp_name" => "install/translatedb/parameters_en.ods"
            ]
        );
        return $this->vue->send();
    }
}
