<?php namespace App\Models;
use Ppci\Models\PpciModel;
/**
 * Classe de base pour gerer des parametres de recherche
 * Classe non instanciable, a heriter
 * L'instance doit etre conservee en variable de session
 * @author Eric Quinton
 *
 */
class SearchParam {
	/**
	 * Tableau des parametres geres par la classe
	 * La liste des parametres doit etre declaree dans la fonction construct
	 *
	 * @var array
	 */
	public $param;
	/**
	 * Indique si la lecture des parametres a ete realisee au moins une fois
	 * Permet ainsi de declencher ou non la recherche
	 *
	 * @var int
	 */
	public $isSearch;
	/**
	 * Constructeur de la classe
	 * A rappeler systematiquement pour initialiser isSearch
	 */
	public function __construct()
		if (! is_array ( $this->param ))
			$this->param = array ();
		$this->isSearch = 0;
	}
	/**
	 * Stocke les parametres fournis
	 *
	 * @param array $data
	 */
	function setParam($data) {
		foreach ( $this->param as $key => $value ) {
			/*
			 * Recherche si une valeur de $data correspond a un parametre
			 */
			if (isset ( $data [$key] ))
				$this->param [$key] = $data [$key];
		}
		/*
		 * Gestion de l'indicateur de recherche
		 */
		if ($data ["isSearch"] == 1)
			$this->isSearch = 1;
	}
	/**
	 * Retourne les parametres existants
	 */
	function getParam() {
		return $this->param;
	}
	/**
	 * Indique si la recherche a ete deja lancee
	 *
	 * @return int
	 */
	function isSearch() {
		if ($this->isSearch == 1) {
			return 1;
		} else {
			return 0;
		}
	}
}
class SearchDeclaration extends SearchParam {
	public function __construct()
		$year = date("Y");

		$this->param = array (
				"libelle"=>"",
				"year_debut"=>$year - 1,
				"year_fin"=>$year,
				"ices_id"=>"",
				"country_id"=>"",
				"environment_id"=>"",
				"status_id"=>"",
				"species_id"=>"",
				"capture_state_id"=>"",
				"gear_type_id"=>"",
				"institute_id"=>""
		);
		parent::__construct();
	}

	/**
	 * Renvoie un tableau simple avec les 20 dernieres years
	 * @return array
	 */
	function getListeAnnee () {
		$year = date("Y");
		$years = array();
		for($debut = 1980; $debut <= $year; $debut ++) {
			$years[] = $debut;
		}
		return $years;
	}
}

?>
