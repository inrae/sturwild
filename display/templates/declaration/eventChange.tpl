<h2>{t}Modification d'un événement{/t}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=declarationList">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste des déclarations{/t}
</a>
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
<img src="display/images/display.png" height="25">
{t}Retour au détail de la déclaration  - N°{/t} {$data.declaration_id}</a>
</div>
	<div class="col-sm-6">
	<fieldset >
		<legend>{t}Événement{/t}</legend>
			<form class="form-horizontal protoform" method="post" action="index.php">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="event_id" value="{$data.event_id}">
				<input type="hidden" name="login" value="{$data.login}">
				<input type="hidden" name="moduleBase" value="event">
				<input type="hidden" name="action" value="Write">
				<div class="form-group">
					<label for="event_type_id" class="control-label col-md-4">
						{t}Type d'événement :{/t}<span class="red">*</span>
					</label>
					<div class="col-md-8">
						<select id="event_type_id" name="event_type_id" autofocus>
						{section name=lst loop=$event_type}
						<option value="{$event_type[lst].event_type_id}" {if $event_type[lst].event_type_id == $data.event_type_id}selected{/if}>
						{$event_type[lst].event_type_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
				<label for="event_date" class="control-label col-md-4">{t}Date de l'événement :{/t}<span class="red">*</span></label>
				<div class="col-md-8">
				<input class="form-control datepicker" id="event_date" name="event_date" value="{$data.event_date}" required>
				</div>
				</div>

				<div class="form-group">
				<label for="event_remarks" class="control-label col-md-4">{t}Commentaire :{t}{/t}</label>
				<div class="col-md-8">
				<input class="form-control " id="event_remarks" name="event_remarks" value="{$data.event_remarks}">
				</div>
				</div>

				<button class="btn btn-primary button-valid col-sm-offset-4">{t}Valider{/t}</button>
				{if $data.event_id>0}
				 <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
     			{/if}

			</form>
	</fieldset>


<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>
