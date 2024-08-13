<?php

namespace Ppci\Libraries;


class LastRelease extends PpciLibrary
{
    function index()
    {
        $params = $this->appConfig->APPLI_release;
        $release = array();
        if (!empty($params["url"])) {
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $params["url"]);
            /*if (!empty($headers)) {
                curl_setopt($ch, CURLOPT_HEADER, $headers);
            }*/
            if ($params["provider"] == "github") {
                curl_setopt($ch, CURLOPT_USERAGENT, $params["user_agent"]);
            }
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            $result = curl_exec($ch);
            curl_close($ch);
            if ($result) {
                $res = json_decode($result, true);
                $release["tag"] = $res[$params["tag"]];
                $release["description"] = $res[$params["description"]];
                $release["date"] = date_format(date_create($res[$params["date"]]), $_SESSION["date"]["maskdate"]);
                $vue = service('Smarty');
                $vue->set("ppci/utils/lastRelease.tpl", "corps");
                $vue->set($this->appConfig->version, "currentVersion");
                $vue->set($release, "release");
                return $vue->send();
            } else {
                $this->message->set(_("Impossible de récupérer la dernière version publiée de l'application"), true);
                $default = new DefaultPage();
                return  $default->display();
            }
        }
    }
}
