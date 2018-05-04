<?php
/**
 * Created : 10 août 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
include_once 'modules/classes/document.class.php';
$dataClass = new Document($bdd, $ObjetBDDParam);
$keyName = "document_id";
$id = $_REQUEST[$keyName];
switch ($t_module["param"]) {
    case "get":
        /*
         * Envoi du document au navigateur
         * Generation du nom du document
         */
        try {
            $tmp_name = $dataClass->prepareDocument($id, $_REQUEST["phototype"]);
            if (strlen($tmp_name) > 0 && is_file($tmp_name)) {
                /*
                 * Recuperation du type mime
                 */
                $data = $dataClass->getData($id);
                
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
                $vue->setParam($param);
            } else {
                unset($vue);
                $module_coderetour = - 1;
            }
        } catch (DocumentException $e) {
            unset($vue);
            $module_coderetour = - 1;
            $message->setSyslog($e->getMessage());
        }
        break;
}
?>