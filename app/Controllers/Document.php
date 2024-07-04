<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Document as LibrariesDocument;

class Document extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesDocument();
    }
    function get()
    {
        return $this->lib->get();
    }
}
