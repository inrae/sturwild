<h2>Modification d'un type d'événement</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=eventTypeList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform"  method="post" action="index.php">
	<input type="hidden" name="event_type_id" id="event_type_id"
		value="{$data.event_type_id}">
		<input type="hidden" name="moduleBase" value="eventType">
<input type="hidden" name="action" value="Write">
<div class="form-group">
<label for="event_type_name" class="control-label col-sm-4">
	Type d'événement <span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input  class="form-control" id="event_type_name" name="event_type_name"
				value="{$data.event_type_name}" maxlength="255" autofocus required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.event_type_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
