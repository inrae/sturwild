<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\ImportFish as LibrariesImportFish;

class ImportFish extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesImportFish();
    }
    function display()
    {
        return $this->lib->display();
    }
    function control()
    {
        return $this->lib->control();
    }
    function csvExec()
    {
        return $this->lib->csvExec();
    }
}
