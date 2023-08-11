<?php
/**
 * Affiche un fond d'ecran par defaut, parametrable par langue (a la racine de templates)
 */
if (file_exists($SMARTY_template . '/main_' . $langue . '.tpl')) {
    $corps = 'main_' . $langue . '.tpl';
} else {
    $corps = "main.tpl";
}
$vue->set($corps, "corps");

if (file_exists("modules/default.php")) {
    include "modules/default.php";
}