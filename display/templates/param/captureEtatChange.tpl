<h2>Modification d'un état à la capture</h2>
<a href="index.php?module=captureEtatList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=captureEtatWrite">
	<input type="hidden" name="capture_etat_id" id="capture_etat_id"
		value="{$data.capture_etat_id}">
		<input type="hidden" name="module" value="captureEtatWrite">
	<dl>
		<dt>Etat à la capture <span class="red">*</span> :</dt>
		<dd>
			<input id="capture_etat_libelle" name="capture_etat_libelle"
				value="{$data.capture_etat_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.capture_etat_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="captureEtat_id" value="{$data.capture_etat_id}"> 
 				<input type="hidden" name="module" value="captureEtatDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>