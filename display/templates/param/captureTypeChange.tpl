<h2>{t}Modification d'un type de capture{/t}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=captureTypeList">{t}Retour à la liste{/t}</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php?module=captureTypeWrite">
	<input type="hidden" name="origin_id" id="origin_id"
		value="{$data.origin_id}">
		<input type="hidden" name="moduleBase" value="captureType">
<input type="hidden" name="action" value="Write">

	<div class="form-group">
	<label for="origin_name" class="control-label col-sm-4">
		{t}Type de capture  :{/t}<span class="red">*</span>
		</label>
		<div class="col-sm-8">
			<input class="form-control" id="origin_name" name="origin_name"
				value="{$data.origin_name}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.origin_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
		</form>
<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>
