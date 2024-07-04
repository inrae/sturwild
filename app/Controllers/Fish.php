<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Fish as LibrariesFish;

class Fish extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesFish();
}
function change() {
return $this->lib->change();
}
function write() {
return $this->lib->write();
}
function delete() {
return $this->lib->delete();
}
function export() {
return $this->lib->export();
}
function exportCSV() {
return $this->lib->exportCSV();
}
function documentDelete() {
return $this->lib->documentDelete();
}
}
