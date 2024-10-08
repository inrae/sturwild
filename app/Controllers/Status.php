<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Status as LibrariesStatus;

class Status extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesStatus();
    }
    function list()
    {
        return $this->lib->list();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        return $this->lib->write();
    }
}
