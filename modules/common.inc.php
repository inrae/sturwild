<?php
/**
 * Code execute systematiquement a chaque appel, apres demarrage de la session
 * Utilise notamment pour recuperer les instances de classes stockees en 
 * variables de session
 */
if (! isset ( $_SESSION ["searchDeclaration"] )) {
	$_SESSION ["searchDeclaration"] = new SearchDeclaration();
} 
?>