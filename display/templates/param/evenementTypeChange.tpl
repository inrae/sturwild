<h2>Modification d'un type d'événement</h2>
<a href="index.php?module=evenementTypeList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=evenementTypeWrite">
	<input type="hidden" name="evenement_type_id" id="evenement_type_id"
		value="{$data.evenement_type_id}">
		<input type="hidden" name="module" value="evenementTypeWrite">
	<dl>
		<dt>Type d'événement <span class="red">*</span> :</dt>
		<dd>
			<input id="evenement_type_libelle" name="evenement_type_libelle"
				value="{$data.evenement_type_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.evenement_type_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="evenement_type_id" value="{$data.evenement_type_id}"> 
 				<input type="hidden" name="module" value="evenementTypeDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>