<h2>Modification d'un état à la capture</h2>
<div class="row">
<div class="col-sd-12">
<a href="index.php?module=captureEtatList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form  class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="capture_state_id" id="capture_state_id" value="{$data.capture_state_id}">
		<input type="hidden" name="module" value="captureEtatWrite">
		<input type="hidden" name="moduleBase" value="captureEtat">
		<input type="hidden" name="action" value="Write">
	<div class="form-group">
		<label for="capture_state_name" class="control-label col-sm-4">Etat à la capture <span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input class="form-control" id="capture_state_name" name="capture_state_name"
				value="{$data.capture_state_name}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.capture_state_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>

<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
