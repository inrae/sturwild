<h2>Modification d'un type de capture</h2>
<div class="row">
<div class="col-sd-12">
<a href="index.php?module=captureTypeList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php?module=captureTypeWrite">
	<input type="hidden" name="capture_type_id" id="capture_type_id"
		value="{$data.capture_type_id}">
		<input type="hidden" name="moduleBase" value="captureType">
<input type="hidden" name="action" value="Write">

	<div class="form-group">
	<label for="capture_type_libelle" class="control-label col-sm-4">
		Type de capture <span class="red">*</span> :
		</label>
		<div class="col-sm-8">
			<input class="form-control" id="capture_type_libelle" name="capture_type_libelle"
				value="{$data.capture_type_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{$LANG["message"].19}</button>
      {if $data.capture_type_id > 0 }
      <button class="btn btn-danger button-delete">{$LANG["message"].20}</button>
      {/if}
 </div>
		</form>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
