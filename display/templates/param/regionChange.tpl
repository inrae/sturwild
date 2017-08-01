<h2>Modification d'une région</h2>
<a href="index.php?module=regionList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=regionWrite">
	<input type="hidden" name="region_id" id="region_id"
		value="{$data.region_id}">
		<input type="hidden" name="module" value="regionWrite">
	<dl>
		<dt>Libellé<span class="red">*</span> :</dt>
		<dd>
			<input id="region_libelle" name="region_libelle"
				value="{$data.region_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.region_id>0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="region_id" value="{$data.region_id}"> 
 				<input type="hidden" name="module" value="regionDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>