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


    function display(){
$this->vue=service('Smarty');
        $this->vue->set("param/translateDb.tpl", "corps");
        ]
    case "exec() {
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
                $this->message->set(sprintf(_("Traitement de la feuille/table %s"), $sheetname));
                $param = new Param($bdd, $sheetname);
                $ok = true;
                $row = 2;

                while ($ok) {
                    $exchangeName = $sheet->getCellByColumnAndRow(3, $row)->getValue();
                    if (!empty($exchangeName)) {
                        /**
                         * Search from existent exchange name
                         */
                        $this->id = $param->getIdFromName($exchangeName);
                        $data = array(
                            $sheetname . "_id" => $this->id,
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
            $this->message->set($e->getMessage(), true);
            $module_coderetour = -1;
        }
        $module_coderetour = 1;
        ]
    case "gettemplate() {
        $this->vue->setParam(
            [
                "filename" => "parameters_en.ods", /* nom du fichier tel qu'il apparaitra dans le navigateur */
                "disposition" => "attachment", /* attachment : le fichier est telecharge, inline : le fichier est affiche */
                "content_type" => "application/vnd.oasis.opendocument.spreadsheet", /* type mime */
                "tmp_name" => "install/translatedb/parameters_en.ods"
            ]
        );
        ]
}
