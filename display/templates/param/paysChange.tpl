<h2>Modification du pays{$data.ciem_id}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=paysList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="pays_id" id="pays_id"
		value="{$data.pays_id}">
		<input type="hidden" name="moduleBase" value="pays">
<input type="hidden" name="action" value="Write">
	
	<div class="form-group">
<label for="event_date" class="control-label col-sm-4">
		Nom du pays <span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input class="form-control" id="pays_libelle" name="pays_libelle"
				value="{$data.pays_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group">
<label for="event_date" class="control-label col-sm-4">
		Ordre de tri pour l'affichage <span class="red">*</span> :</label>
		<div class="col-sm-8">
		<input class="form-control nombre" name="pays_order" value="{$data.pays_order}" required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.pays_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
