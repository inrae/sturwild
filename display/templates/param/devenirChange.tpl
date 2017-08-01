<h2>Modification d'une destination d'un esturgeon capturé</h2>
<a href="index.php?module=devenirList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=devenirWrite">
	<input type="hidden" name="devenir_id" id="devenir_id"
		value="{$data.devenir_id}">
		<input type="hidden" name="module" value="devenirWrite">
	<dl>
		<dt>Nom de la destination <span class="red">*</span> :</dt>
		<dd>
			<input id="devenir_libelle" name="devenir_libelle"
				value="{$data.devenir_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.devenir_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="devenir_id" value="{$data.devenir_id}"> 
 				<input type="hidden" name="module" value="devenirDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>