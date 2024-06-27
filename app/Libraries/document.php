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
/**
 * Created : 10 août 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
include_once 'modules/classes/document.class.php';
$this->dataClass = new Document();
$keyName = "document_id";
$this->id = $_REQUEST[$keyName];

    case "get() {
        /*
         * Envoi du document au navigateur
         * Generation du nom du document
         */
        try {
            $tmp_name = $this->dataClass->prepareDocument($this->id, $_REQUEST["phototype"]);
            if (strlen($tmp_name) > 0 && is_file($tmp_name)) {
                /*
                 * Recuperation du type mime
                 */
                $data = $this->dataClass->getData($this->id);
                
                $param = array(
                    "tmp_name" => $tmp_name,
                    "content_type" => $data["content_type"]
                );
                if ($_REQUEST["attached"] == 1) {
                    $param["disposition"] = "attachment";
                    $fn = explode('/', $tmp_name);
                    $param["filename"] = $fn[count($fn) - 1];
                } else
                    $param["disposition"] = "inline";
                $this->vue->setParam($param);
            } else {
                unset($this->vue);
                $module_coderetour = - 1;
            }
        } catch (DocumentException $e) {
            unset($this->vue);
            $module_coderetour = - 1;
            $this->message->setSyslog($e->getMessage());
        }
        ]
}
?>