<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Param as LibrariesParam;

class Param extends PpciController
{
    protected $lib;

    function list(string $name)
    {
        $this->lib = new LibrariesParam($name);
        return $this->lib->list();
    }
    function change(string $name)
    {
        $this->lib = new LibrariesParam($name);
        return $this->lib->change();
    }
    function write(string $name)
    {
        $this->lib = new LibrariesParam($name);
        return $this->lib->write();
    }
    function delete(string $name)
    {
        $this->lib = new LibrariesParam($name);
        return $this->lib->delete();
    }
}
