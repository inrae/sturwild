<?php

namespace App\Models;

class SearchDeclaration extends SearchParam
{
    public function __construct()
    {
        $year = date("Y");

        $this->param = array(
            "libelle" => "",
            "year_debut" => $year - 1,
            "year_fin" => $year,
            "ices_id" => "",
            "country_id" => "",
            "environment_id" => "",
            "status_id" => "",
            "species_id" => "",
            "capture_state_id" => "",
            "gear_type_id" => "",
            "institute_id" => ""
        );
        parent::__construct();
    }

    /**
     * Renvoie un tableau simple avec les 20 dernieres years
     * @return array
     */
    function getListeAnnee()
    {
        $year = date("Y");
        $years = array();
        for ($debut = 1980; $debut <= $year; $debut++) {
            $years[] = $debut;
        }
        return $years;
    }
}
