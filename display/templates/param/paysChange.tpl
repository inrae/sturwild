<h2>Modification du pays{$data.ciem_id}</h2>
<a href="index.php?module=paysList">Retour à la liste</a>
<div class="formSaisie">
<form method="post" action="index.php?module=paysWrite">
	<input type="hidden" name="pays_id" id="pays_id"
		value="{$data.pays_id}">
		<input type="hidden" name="module" value="paysWrite">
	<dl>
		<dt>Nom du pays <span class="red">*</span> :</dt>
		<dd>
			<input id="pays_libelle" name="pays_libelle"
				value="{$data.pays_libelle}" maxlength="255" autofocus required>
		</dd>
	</dl>
	<dl>
		<dt>Ordre de tri pour l'affichage <span class="red">*</span> :</dt>
		<dd>
		<input name="pays_order" value="{$data.pays_order}" required>
		</dd>
	</dl>
	<div class="formBouton">
			<input class="submit" type="submit" value="Enregistrer">
		</div>
		</form>
		{if $data.pays_id > 0}
		<div class="formBouton">
 			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
 				<input type="hidden" name="pays_id" value="{$data.pays_id}"> 
 				<input type="hidden" name="module" value="paysDelete"> 
 				<input class="submit" type="submit" value="Supprimer"> 
 			</form>
		</div>
		{/if}
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>