<?php

/**
 * Fonctions specifiques de l'application, chargees systematiquement
 */
function sendMail($declaration_id)
{
  global $log;
  global $APPLI_address;
  global $MAIL_param, $MAIL_enabled, $message;
  global $bdd, $bdd_gacl, $ObjetBDDParam;
  global $SMARTY_param;
  if ($MAIL_enabled) {
    $id = $declaration_id;
    /*
     * Le status est modifie.
     * envoi des mels aux personnes concernees
     */
    require_once 'framework/droits/droits.class.php';
    require_once 'framework/identification/loginGestion.class.php';
    require_once 'framework/utils/mail.class.php';
    require_once 'modules/classes/declaration.class.php';
    require_once "modules/classes/param.class.php";
    /*
     * Lecture du status de la declaration
     */
    $declaration = new Declaration($bdd, $ObjetBDDParam);
    $data = $declaration->lire($id);
    $status = new Param($bdd, "status");
    $dataStatut = $status->lire($data["status_id"]);
    $lien = $APPLI_address . "/index.php?module=declarationDisplay&declaration_id=" . $id;
    $dataMail = array(
      "declaration_id" => $id,
      "status_name" => $dataStatut["status_name"],
      "link" => $lien
    );
    /*
     * Recherche des comptes destinataires des mels
     */
    $aclAco = new Aclaco($bdd_gacl, $ObjetBDDParam);
    $logins = $aclAco->getLogins("gestion");
    $loginGestion = new LoginGestion($bdd_gacl, $ObjetBDDParam);
    $mail = new Mail();
    foreach ($logins as $value) {
      $login = $value["login"];
      $dataLogin = $loginGestion->lireByLogin($login);
      if (!empty($dataLogin["mail"] && $dataLogin["actif"])) {
        if (
          $mail->sendMailSmarty(
            $SMARTY_param,
            $dataLogin["mail"],
            sprintf(_("%s - modification d'une déclaration"), $_SESSION["APPLI_title"]),
            "declaration/declarationMail.tpl",
            $dataMail,
            $_SESSION["LANG"]["locale"]
          )
        ) {
          $log->setLog($_SESSION["login"], "sendmail_to:" . $dataLogin["mail"], $id);
        } else {
          $log->setLog($_SESSION["login"], "error_sendmail_to:" . $dataLogin["mail"], $id);
          $message->set(sprintf(_("Erreur d'envoi d'un mail vers %s"), $dataLogin["mail"]), true);
          $message->setSyslog("error_sendmail_to:" . $dataLogin["mail"]);
        }
      }
    }
    $message->set(_("Envoi des mails réalisé pour informer du changement de status de la déclaration"));
  }
}

function setParamMap($vue, $isChange = false)
{
  if (isset($vue)) {
    foreach (array("mapDefaultZoom", "mapDefaultLong", "mapDefaultLat", "mapCacheMaxAge", "mapMinZoom", "mapMaxZoom") as $mapParam) {
      if (isset($_SESSION[$mapParam])) {
        $vue->set($_SESSION[$mapParam], $mapParam);
      }
    }
  }
}
?>