<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Event as LibrariesEvent;

class Event extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesEvent();
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
