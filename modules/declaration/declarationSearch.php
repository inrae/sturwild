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
$ices = new Ciem($bdd, $ObjetBDDParam);
$vue->set ($ices->getListe(2) , "ices" );

$country = new Pays($bdd, $ObjetBDDParam);
$vue->set ( $country->getListe(3), "country" );

$environment = new Milieu($bdd, $ObjetBDDParam);
$vue->set ( $environment->getListe(2), "environment" );

$species = new Espece($bdd, $ObjetBDDParam);
$vue->set ( $species->getListe(2), "species" );

$capture_state = new Capture_etat($bdd, $ObjetBDDParam);
$vue->set ( $capture_state->getListe(2), "capture_state" );

$gear_type = new Engin_type($bdd, $ObjetBDDParam);
$vue->set ( $gear_type->getListe(2), "gear_type" );

$status = new Statut($bdd, $ObjetBDDParam);
$vue->set ( $status->getListe(1), "status" );
$vue->set ( $_SESSION["searchDeclaration"]->isSearch(), "isSearch" );
$vue->set ($_SESSION["searchDeclaration"]->getListeAnnee() , "years" );

?>