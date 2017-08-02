<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 6 août 2015
 *  Script de preparation des boites de selection pour les criteres de recherche
 */
 
require_once 'modules/classes/localisation.class.php';
require_once 'modules/classes/individu.class.php';
$ciem = new Ciem($bdd, $ObjetBDDParam);
$vue->set ($ciem->getListe(2) , "ciem" );

$pays = new Pays($bdd, $ObjetBDDParam);
$vue->set ( $pays->getListe(3), "pays" );

$region = new Region($bdd, $ObjetBDDParam);
$vue->set ( $region->getListe(2), "region" );

$milieu = new Milieu($bdd, $ObjetBDDParam);
$vue->set ( $milieu->getListe(2), "milieu" );

$espece = new Espece($bdd, $ObjetBDDParam);
$vue->set ( $espece->getListe(2), "espece" );

$capture_etat = new Capture_etat($bdd, $ObjetBDDParam);
$vue->set ( $capture_etat->getListe(2), "capture_etat" );

$engin_type = new Engin_type($bdd, $ObjetBDDParam);
$vue->set ( $engin_type->getListe(2), "engin_type" );

$statut = new Statut($bdd, $ObjetBDDParam);
$vue->set ( $statut->getListe(1), "statut" );
$vue->set ( $_SESSION["searchDeclaration"]->isSearch(), "isSearch" );
$vue->set ($_SESSION["searchDeclaration"]->getListeAnnee() , "annees" );

?>