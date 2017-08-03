<?php

/**
 * Fonctions specifiques de l'application, chargees systematiquement
 */
function sendMail($declaration_id)
{
    global $log;
    global $APPLI_address;
    global $MAIL_param, $MAIL_enabled;
    global $bdd, $bdd_gacl, $ObjetBDDParam;
    if ($MAIL_enabled) {
        $id = $declaration_id;
        /*
         * Le statut est modifie.
         * envoi des mels aux personnes concernees
         */
        require_once 'framework/droits/droits.class.php';
        require_once 'framework/identification/identification.class.php';
        require_once 'modules/classes/mail.class.php';
        require_once 'modules/classes/declaration.class.php';
        /*
         * Lecture du statut de la declaration
         */
        $declaration = new Declaration($bdd, $ObjetBDDParam);
        $data = $declaration->lire($id);
        $statut = new Statut($bdd, $ObjetBDDParam);
        $dataStatut = $statut->lire($data["statut_id"]);
        $lien = $APPLI_address . "/index.php?module=declarationDisplay&declaration_id=" . $id;
        $dataMail = array(
            "@declaration_id" => $id,
            "@statut_libelle" => $dataStatut["statut_libelle"],
            "@lien" => $lien
        );
        /*
         * Recherche des comptes destinataires des mels
         */
        $aclAco = new Aclaco($bdd_gacl, $ObjetBDDParam);
        $logins = $aclAco->getLogins("gestion");
        $loginGestion = new LoginGestion($bdd_gacl, $ObjetBDDParam);
        $mail = new Mail($MAIL_param);
        foreach ($logins as $key => $value) {
            $login = $value["login"];
            $dataLogin = $loginGestion->lireByLogin($login);
            if (strlen($dataLogin["mail"]) > 0) {
                if ($mail->sendMail($dataLogin["mail"], $dataMail)) {
                    $log->setLog($_SESSION["login"], "sendmail_to:" . $dataLogin["mail"], $id);
                } else {
                    $log->setLog($_SESSION["login"], "error_sendmail_to:" . $dataLogin["mail"], $id);
                    global $message;
                    $message->setSyslog("error_sendmail_to:" . $dataLogin["mail"]);
                }
            }
        }
    }
}
?>