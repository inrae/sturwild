<h2>Modification d'un mode de capture</h2>
<div class="row">
<div class="col-sd-12">
<a href="index.php?module=captureModeList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form method="post" action="index.php" class="form-horizontal protoform">
	<input type="hidden" name="capture_mode_id" id="capture_mode_id" value="{$data.capture_mode_id}">
		<input type="hidden" name="moduleBase" value="captureMode">
<input type="hidden" name="action" value="Write">
	<div class="form-group">	
	<label for="capture_mode_libelle" class="control-label col-sm-4">Mode de capture <span class="red">*</span> :
	</label>
	<div class="col-sm-8">
			<input class="form-control" id="capture_mode_libelle" name="capture_mode_libelle"
				value="{$data.capture_mode_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.capture_mode_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>