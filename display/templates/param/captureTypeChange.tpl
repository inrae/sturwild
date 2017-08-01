<h2>Modification d'un type de capture</h2>
<a href="index.php?module=captureTypeList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=captureTypeWrite">
	<input type="hidden" name="capture_type_id" id="capture_type_id"
		value="{$data.capture_type_id}">
		<input type="hidden" name="module" value="captureTypeWrite">
	<dl>
		<dt>Type de capture <span class="red">*</span> :</dt>
		<dd>
			<input id="capture_type_libelle" name="capture_type_libelle"
				value="{$data.capture_type_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.capture_type_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="captureType_id" value="{$data.capture_type_id}"> 
 				<input type="hidden" name="module" value="captureTypeDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>