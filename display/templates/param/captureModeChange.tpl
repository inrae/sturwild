<h2>{t}Modification d'un mode de capture{/t}</h2>
<div class="row">
<div class="col-sd-12">
<a href="index.php?module=captureModeList">{t}Retour à la liste{/t}</a>
</div>
<div class="col-sm-6">
<form method="post" action="index.php" class="form-horizontal protoform">
	<input type="hidden" name="capture_method_id" id="capture_method_id" value="{$data.capture_method_id}">
		<input type="hidden" name="moduleBase" value="captureMode">
<input type="hidden" name="action" value="Write">
	<div class="form-group">	
	<label for="capture_method_name" class="control-label col-sm-4">{t}Mode de capture  :{/t}<span class="red">*</span>
	</label>
	<div class="col-sm-8">
			<input class="form-control" id="capture_method_name" name="capture_method_name"
				value="{$data.capture_method_name}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.capture_method_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>