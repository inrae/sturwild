<h2>Modification d'un type d'engin de pêche</h2>
<a href="index.php?module=enginTypeList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=enginTypeWrite">
	<input type="hidden" name="engin_type_id" id="engin_type_id"
		value="{$data.engin_type_id}">
		<input type="hidden" name="module" value="enginTypeWrite">
	<dl>
		<dt>Type d'engin de pêche <span class="red">*</span> :</dt>
		<dd>
			<input id="engin_type_libelle" name="engin_type_libelle"
				value="{$data.engin_type_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.engin_type_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="enginType_id" value="{$data.engin_type_id}"> 
 				<input type="hidden" name="module" value="enginTypeDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>