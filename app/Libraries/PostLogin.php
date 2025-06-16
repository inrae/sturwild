<?php

namespace App\Libraries;

use App\Models\Institute;
use Ppci\Libraries\PpciLibrary;

class PostLogin extends PpciLibrary
{
    static function index()
    {
        $institute = new Institute;
        $institute->initInstitutes();
    }
}
