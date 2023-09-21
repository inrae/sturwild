<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 août 2015
 *  Script de preparation des boites de selection pour les criteres de recherche
 */

require_once 'modules/classes/location.class.php';
require_once 'modules/classes/fish.class.php';
require_once 'modules/classes/param.class.php';
$ices = new Ices($bdd, $ObjetBDDParam);
$vue->set($ices->getListe(2), "ices");

$country = new Country($bdd, $ObjetBDDParam);
$vue->set($country->getListe(3), "country");

$environment = new Param($bdd, "environment");
$vue->set($environment->getListe(2), "environment");

$species = new Param($bdd, "species");
$vue->set($species->getListe(2), "species");

$capture_state = new Param($bdd, "capture_state");
$vue->set($capture_state->getListe(2), "capture_state");

$gear_type = new Param($bdd, "gear_type");
$vue->set($gear_type->getListe(2), "gear_type");

$status = new Param($bdd, "status");
$vue->set($status->getListe(1), "status");
$vue->set($_SESSION["searchDeclaration"]->isSearch(), "isSearch");
$vue->set($_SESSION["searchDeclaration"]->getListeAnnee(), "years");