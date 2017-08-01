<h2>Modification d'une espèce</h2>
<a href="index.php?module=especeList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=especeWrite">
	<input type="hidden" name="espece_id" id="espece_id"
		value="{$data.espece_id}">
		<input type="hidden" name="module" value="especeWrite">
	<dl>
		<dt>Libellé de l'espèce <span class="red">*</span> :</dt>
		<dd>
			<input id="espece_libelle" name="espece_libelle"
				value="{$data.espece_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.espece_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="espece_id" value="{$data.espece_id}"> 
 				<input type="hidden" name="module" value="especeDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>