<?php
namespace App\Libraries;

use App\Models\Institute;
use Ppci\Libraries\PpciLibrary;
class PostLogin extends PpciLibrary {
    static function index() {
        /**
         * Generate the list of institutes associated with the login
         */
        $groupsId = [];
        foreach ($_SESSION["groupes"] as $group) {
            $groupsId[] = $group["aclgroup_id"];
        }
        if (!empty ($groupsId)) {
            $institute = new Institute;
            $_SESSION["institutes"] = $institute->getListFromGroups($groupsId);
        }
    }
}