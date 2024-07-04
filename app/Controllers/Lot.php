<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Lot as LibrariesLot;

class Lot extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesLot();
}
function change() {
return $this->lib->change();
}
function write() {
return $this->lib->write();
}
}
