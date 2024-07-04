<?php

namespace App\Libraries;

use App\Models\Document as ModelsDocument;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Document extends PpciLibrary
{
    /**
     * @var ModelsDocument
     */
    protected PpciModel $dataClass;

    function __construct()
    {
        parent::__construct();
        $this->dataClass = new ModelsDocument();
        $keyName = "document_id";
        if (isset($_REQUEST[$keyName])) {
            $this->id = $_REQUEST[$keyName];
        }
    }

    function get()
    {
        /*
         * Envoi du document au navigateur
         * Generation du nom du document
         */
        try {
            $this->vue = service('BinaryView');
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
                return $this->vue->send();
            }
        } catch (PpciException $e) {
            $this->message->setSyslog($e->getMessage());
        }
    }
}
