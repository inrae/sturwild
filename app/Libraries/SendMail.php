<?php

namespace app\Libraries;

use App\Models\Declaration;
use App\Models\Param;
use Ppci\Libraries\Mail;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\Aclaco;
use Ppci\Models\Acllogin;
use Ppci\Models\LoginGestion;

class SendMail extends PpciLibrary
{
    public function send(int $declaration_id)
    {
        if ($this->appConfig->MAIL_enabled) {
            $declaration = new Declaration();
            $data = $declaration->lire($declaration_id);
            $status = new Param("status");
            $dataStatut = $status->lire($data["status_id"]);
            $lien = $this->appConfig->baseURL . "/declarationDisplay&declaration_id=" . $declaration_id;
            $dataMail = array(
                "declaration_id" => $declaration_id,
                "status_name" => $dataStatut["status_name"],
                "link" => $lien
            );
            $mail = new Mail();
            /**
             * Search destinataries of emails
             */
            $aclAco = new Aclaco();
            $logins = $aclAco->getLogins("manage");
            $acllogin = new Acllogin();
            foreach ($logins as $login) {
                $dacllogin = $acllogin->getFromLogin($login);
                if (!empty($dacllogin["email"])) {
                    if (
                        $mail->sendMailSmarty(
                            $dacllogin["email"],
                            sprintf(_("%s - modification d'une déclaration"), $_SESSION["dbparams"]["APPLI_title"]),
                            "declaration/declarationMail.tpl",
                            $dataMail,
                            $_SESSION["locale"]
                        )
                    ) {
                        $this->log->setLog($_SESSION["login"], "sendmail_to:" . $dacllogin["email"], $declaration_id);
                    } else {
                        $this->log->setLog($_SESSION["login"], "error_sendmail_to:" . $dacllogin["email"], $declaration_id);
                        $this->message->set(sprintf(_("Erreur d'envoi d'un mail vers %s"), $dacllogin["email"]), true);
                        $this->message->setSyslog("error_sendmail_to:" . $dacllogin["email"]);
                    }
                }
            }
        }
    }
}
