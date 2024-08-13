<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Ices as LibrariesIces;

class Ices extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesIces();
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
    function delete()
    {
        return $this->lib->delete();
    }
}
