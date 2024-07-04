<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Location as LibrariesLocation;

class Location extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesLocation();
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
