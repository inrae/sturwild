<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Declaration as LibrariesDeclaration;

class Declaration extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesDeclaration();
    }
    function list()
    {
        return $this->lib->list();
    }
    function display()
    {
        return $this->lib->display();
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
    function export()
    {
        return $this->lib->export();
    }
    function sturioByYear()
    {
        return $this->lib->sturioByYear();
    }
    function duplicate()
    {
        return $this->lib->duplicate();
    }
    function exportCSV()
    {
        return $this->lib->exportCSV();
    }
    function exportJSON()
    {
        return $this->lib->exportJSON();
    }
}
