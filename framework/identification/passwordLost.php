<?php
/**
 * Created : 7 août 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
require_once 'framework/identification/passwordlost.class.php';
$dataClass = new Passwordlost($bdd, $ObjetBDDParam);
$keyName = "passwordlost_id";
$id = $_REQUEST[$keyName];

switch ($t_module["param"]) {
    case "islost":
        $vue->set("identMailInput.tpl", "corps");
        break;
    case "sendmail":
        if (isset($_REQUEST["mail"])) {
            try {
                $data = $dataClass->createTokenFromMail($_REQUEST["mail"]);
                if ($data["id"] > 0) {
                    require_once 'framework/identification/mail.class.php';
                    $contents = "<html><body>";
                    $contents .= ":prenom :nom,<br>";
                    $contents .= "<br>Vous avez demandé à réinitialiser votre mot de passe pour l'application :appli. Si ce n'était pas le cas, contactez l'administrateur de l'application.";
                    $contents .= "<br>Pour réinitaliser votre mot de passe, recopiez le lien suivant dans votre navigateur :";
                    $contents .= "<br><a href=':adresse'>Réinitialisez votre mot de passe</a>";
                    $contents .= "<br>Ne répondez pas à ce mail, qui est généré automatiquement";
                    $contents .= '</body></html>';
                    
                    $param = array(
                        "replyTo" => $APPLI_mail,
                        "from" => $APPLI_mail,
                        "subject" => ":appli - réinitialisation du mot de passe",
                        "contents" => $contents
                    );
                    $loginGestion = new LoginGestion($bdd_gacl, $ObjetBDDParam);
                    $dl = $loginGestion->lire($data["id"]);
                    require_once 'framework/identification/mail.class.php';
                    $mail = new Mail($param);
                    if ($mail->sendMail($data["mail"], array(
                        ":nom" => $dl["nom"],
                        ":prenom" => $dl["prenom"],
                        ":expiration" => $data["expiration"],
                        ":appli" => $APPLI_name,
                        ":adresse" => $APPLI_adresse . "/index.php?module=passwordlostReinitchange&token=" . $data["token"]
                    ))) {
                        $message->set("Mail envoyé");
                    } else {
                        
                        $message->set("Impossible d'envoyer le mail");
                        $message->setSyslog("Envoi d'un mail de réinitialisation du mot de passe vers $mail impossible");
                    }
                }
            } catch (Exception $e) {
                $log->setLog("", "passwordlostSendmail-ko", "$mail");
                $message->setSyslog($e->getMessage());
            }
        }
        $module_coderetour = 1;
        break;
    case "reinitChange":
        if (isset($_REQUEST["token"])) {
            /*
             * Verification de la validite du token
             */
            try {
            $data = $dataClass->verifyToken($_REQUEST["token"]);
            $vue->set("loginChangePassword.tpl", "corps");
            $vue->set("1","passwordLost");
            
            } catch (Exception $e) {
                $message->set("Le jeton fourni n'est pas valide");
                $message->setSyslog("token". $_REQUEST["token"]. " not valid");
                $vue->set("main.tpl", "corps");
            }
        }
        break;
    case "reinitWrite":
        
        break;
}
?>