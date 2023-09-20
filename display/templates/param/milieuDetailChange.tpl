<h2>{t}Modification d'un mileu détaillé{/t}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=environmentDetailList">{t}Retour à la liste{/t}</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="environment_detail_id" id="environment_detail_id"
		value="{$data.environment_detail_id}">
		<input type="hidden" name="moduleBase" value="environmentDetail">
<input type="hidden" name="action" value="Write">

<div class="form-group">
<label for="environment_detail_name" class="control-label col-sm-4">
	{t}Libellé du milieu  :{/t}<span class="red">*</span></label>
		<div class="col-sm-8">
			<input class="form-control" id="environment_detail_name" name="environment_detail_name"
				value="{$data.environment_detail_name}" maxlength="255" autofocus required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.environment_detail_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>	
<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>