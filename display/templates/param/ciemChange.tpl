{if $data.ciem_id > 0}
<h2>Modification d'une zone CIEM</h2>
{/if}
<a href="index.php?module=ciemList">Retour à la liste</a>

<div class="formSaisie">
<form method="post" action="index.php?module=ciemWrite">
	<input type="hidden" name="ciem_id" id="ciem_id"
		value="{$data.ciem_id}">
	<dl>
		<dt>Libelle de la zone CIEM <span class="red">*</span> :</dt>
		<dd>
			<input id="ciem_libelle" name="ciem_libelle"
				value="{$data.ciem_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.ciem_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="id" value="{$data.ciem_id}"> 
 				<input type="hidden" name="module" value="ciemDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>