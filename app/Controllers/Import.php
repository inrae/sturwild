<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Import as LibrariesImport;

class Import extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesImport();
}
function display() {
return $this->lib->display();
}
function control() {
return $this->lib->control();
}
function csvExec() {
return $this->lib->csvExec();
}
function jsonDisplay() {
return $this->lib->jsonDisplay();
}
function jsonControl() {
return $this->lib->jsonControl();
}
function jsonExec() {
return $this->lib->jsonExec();
}
}
