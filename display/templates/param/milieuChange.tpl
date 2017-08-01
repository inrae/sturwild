<h2>Modification d'un milieu</h2>
<a href="index.php?module=milieuList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=milieuWrite">
	<input type="hidden" name="milieu_id" id="milieu_id"
		value="{$data.milieu_id}">
		<input type="hidden" name="module" value="milieuWrite">
	<dl>
		<dt>Libellé du milieu <span class="red">*</span> :</dt>
		<dd>
			<input id="milieu_libelle" name="milieu_libelle"
				value="{$data.milieu_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.milieu_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="milieu_id" value="{$data.milieu_id}"> 
 				<input type="hidden" name="module" value="milieuDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>