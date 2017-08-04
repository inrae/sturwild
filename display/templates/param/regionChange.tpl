<h2>Modification d'une région</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=regionList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="region_id" id="region_id"
		value="{$data.region_id}">
		<input type="hidden" name="moduleBase" value="region">
<input type="hidden" name="action" value="Write">
	<div class="form-group">
<label for="event_date" class="control-label col-sm-4">
		Libellé<span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input id="region_libelle" name="region_libelle"
				value="{$data.region_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{$LANG["message"].19}</button>
      {if $data.region_id > 0 }
      <button class="btn btn-danger button-delete">{$LANG["message"].20}</button>
      {/if}
 </div>
</form>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>