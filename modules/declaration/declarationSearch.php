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
$smarty->assign("ciem", $ciem->getListe(2));
$pays = new Pays($bdd, $ObjetBDDParam);
$smarty->assign("pays", $pays->getListe(3));
$region = new Region($bdd, $ObjetBDDParam);
$smarty->assign("region", $region->getListe(2));
$milieu = new Milieu($bdd, $ObjetBDDParam);
$smarty->assign("milieu", $milieu->getListe(2));
$statut = new Statut($bdd, $ObjetBDDParam);
$espece = new Espece($bdd, $ObjetBDDParam);
$smarty->assign("espece", $espece->getListe(2));
$capture_etat = new Capture_etat($bdd, $ObjetBDDParam);
$smarty->assign("capture_etat", $capture_etat->getListe(2));
$engin_type = new Engin_type($bdd, $ObjetBDDParam);
$smarty->assign("engin_type", $engin_type->getListe(2));

$smarty->assign("statut", $statut->getListe(1));
$smarty->assign("isSearch", $_SESSION["searchDeclaration"]->isSearch());
$smarty->assign("annees", $_SESSION["searchDeclaration"]->getListeAnnee());
?>