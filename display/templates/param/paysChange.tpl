<h2>{t}Modification du country{$data.ices_id}{/t}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=countryList">{t}Retour à la liste{/t}</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="country_id" id="country_id"
		value="{$data.country_id}">
		<input type="hidden" name="moduleBase" value="country">
<input type="hidden" name="action" value="Write">
	
	<div class="form-group">
<label for="event_date" class="control-label col-sm-4">
		Nom du country  :{/t}<span class="red">*</span></label>
		<div class="col-sm-8">
			<input class="form-control" id="country_name" name="country_name"
				value="{$data.country_name}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group">
<label for="event_date" class="control-label col-sm-4">
		Ordre de tri pour l'affichage  :{/t}<span class="red">*</span></label>
		<div class="col-sm-8">
		<input class="form-control nombre" name="country_order" value="{$data.country_order}" required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.country_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>
