<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 11 août 2015
 */
class Export {
	private $separateurExport = ",";
	private $nomFichierExport = "export";
	public $fichierExport;
	/**
	 * Initialise l'export CSV
	 * 
	 * @param string $nomFichierExport        	
	 * @param string $separateur        	
	 */
	function exportCSVinit($nomFichierExport, $separateur = ",") {
		$this->nomFichierExport = $nomFichierExport . "-" . date ( 'd-m-Y' ) . ".csv";
		if ($separateur == "tab")
			$separateur = "\t";
		$this->separateurExport = $separateur;
	}
	/**
	 * Ecrit une ligne dans le fichier CSV
	 * 
	 * @param array $data        	
	 */
	function exportCSV($tableau, $withEntete = true) {
		header ( "content-type: text/csv" );
		header ( 'Content-Disposition: attachment; filename="' . $this->nomFichierExport . '"' );
		header ( 'Pragma: no-cache' );
		header ( 'Cache-Control:must-revalidate, post-check=0, pre-check=0' );
		header ( 'Expires: 0' );
		$fp = fopen ( 'php://output', 'w' );
		/*
		 * Generation de la ligne d'entete
		 */
		if ($withEntete == true) {			
			$entete = array ();
			foreach ( $tableau [0] as $key => $value ) {				
				$entete [] = $key;
			}
			fputcsv ( $fp, $entete, $this->separateurExport );
		}
		/*
		 * Traitement des donnees
		 */
		foreach ( $tableau as $cle => $data ) {	
			/*
			 * Suppression des sauts de ligne inseres dans le texte
			 */		
			$data = preg_replace ( "/\r\n/", ' ', $data );
			$data = preg_replace ( "/\n/", ' ', $data );
			fputcsv ( $fp, $data, $this->separateurExport );
		}
		fclose ( $fp );
	}
}

?>