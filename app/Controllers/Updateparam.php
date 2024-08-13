<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Updateparam as LibrariesUpdateparam;

class Updateparam extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesUpdateparam();
    }
    function display()
    {
        return $this->lib->display();
    }
    function exec()
    {
        return $this->lib->exec();
    }
    function gettemplate()
    {
        return $this->lib->gettemplate();
    }
}
