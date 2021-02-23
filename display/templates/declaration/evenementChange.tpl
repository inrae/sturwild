<h2>Modification d'un événement</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=declarationList">
	<img src="display/images/list.png" height="25">
	Retour à la liste des déclarations
</a>
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
<img src="display/images/display.png" height="25">
Retour au détail de la déclaration  - N° {$data.declaration_id}</a>
</div>
	<div class="col-sm-6">
	<fieldset >
		<legend>Événement</legend>
			<form class="form-horizontal protoform" method="post" action="index.php">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
				<input type="hidden" name="login" value="{$data.login}">
				<input type="hidden" name="moduleBase" value="evenement">
				<input type="hidden" name="action" value="Write">
				<div class="form-group">
					<label for="evenement_type_id" class="control-label col-md-4">
						Type d'événement <span class="red">*</span> :
					</label>
					<div class="col-md-8">
						<select id="evenement_type_id" name="evenement_type_id" autofocus>
						{section name=lst loop=$evenement_type}
						<option value="{$evenement_type[lst].evenement_type_id}" {if $evenement_type[lst].evenement_type_id == $data.evenement_type_id}selected{/if}>
						{$evenement_type[lst].evenement_type_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
				<label for="evenement_date" class="control-label col-md-4">Date de l'événement <span class="red">*</span> :</label>
				<div class="col-md-8">
				<input class="form-control datepicker" id="evenement_date" name="evenement_date" value="{$data.evenement_date}" required>
				</div>
				</div>

				<div class="form-group">
				<label for="evenement_commentaire" class="control-label col-md-4">Commentaire :</label>
				<div class="col-md-8">
				<input class="form-control " id="evenement_commentaire" name="evenement_commentaire" value="{$data.evenement_commentaire}">
				</div>
				</div>

				<button class="btn btn-primary button-valid col-sm-offset-4">{t}Valider{/t}</button>
				{if $data.evenement_id>0}
				 <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
     			{/if}

			</form>
	</fieldset>


<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
