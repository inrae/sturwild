<h2>Modification d'un mode de capture</h2>
<a href="index.php?module=captureModeList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=captureModeWrite">
	<input type="hidden" name="capture_mode_id" id="capture_mode_id"
		value="{$data.capture_mode_id}">
		<input type="hidden" name="module" value="captureModeWrite">
	<dl>
		<dt>Mode de capture <span class="red">*</span> :</dt>
		<dd>
			<input id="capture_mode_libelle" name="capture_mode_libelle"
				value="{$data.capture_mode_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.capture_mode_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="captureMode_id" value="{$data.capture_mode_id}"> 
 				<input type="hidden" name="module" value="captureModeDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>