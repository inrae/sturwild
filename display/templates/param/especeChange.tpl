<h2>{t}Modification d'une espèce{/t}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=speciesList">{t}Retour à la liste{/t}</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="species_id" id="species_id"
		value="{$data.species_id}">
		<input type="hidden" name="moduleBase" value="species">
<input type="hidden" name="action" value="Write">

<div class="form-group">
<label for="species_name" class="control-label col-sm-4">
	{t}Libellé de l'espèce  :{/t}<span class="red">*</span></label>
		<div class="col-sm-8">
			<input class="form-control" id="species_name" name="species_name"
				value="{$data.species_name}" maxlength="255" autofocus required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.species_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>	
<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>
