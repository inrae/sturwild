<h2>{t}Modification d'un esturgeon{/t}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=declarationList">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste{/t} des déclarations
</a>
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
<img src="display/images/display.png" height="25">
Retour au détail de la déclaration  - N° {$data.declaration_id}</a>
</div>
<div class="col-sm-6">
	<fieldset>
		<legend>Esturgeon capturé</legend>

			<form class="form-horizontal protoform" method="post" action="index.php"  enctype="multipart/form-data">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="fish_id" value="{$data.fish_id}">
				<input type="hidden" name="moduleBase" value="fish">
				<input type="hidden" name="action" value="Write">
				<div class="form-group">
					<label for="species_id" class="control-label col-sm-4">
						Espèce :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="species_id"  name="species_id" autofocus>
						<option value="" {if $data.species_id == ""}selected{/if}>
						Sélectionnez...
						</option>
						{section name=lst loop=$species}
						<option value="{$species[lst].species_id}" {if $species[lst].species_id == $data.species_id}selected{/if}>
						{$species[lst].species_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="identification_quality" class="control-label col-sm-4">Qualité de l'identification :{t}{/t}</label>
					<div class="col-sm-8">
						<select class="form-control" id="identification_quality"  name="identification_quality">
						<option value="0" {if $data.identification_quality == 0}selected{/if}>
							Détermination incertaine
						</option>
						<option value="1" {if $data.identification_quality == 1}selected{/if}>
							Détermination confirmée
						</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="presence_tag_d" class="control-label col-sm-4">Marque ?</label>
					<div class="col-sm-8">
						<select class="form-control" id="presence_tag_d"  name="presence_tag_d">
						{section name=lst loop=$tag_presence}
						<option value="{$tag_presence[lst].presence_tag_d}" {if $tag_presence[lst].presence_tag_d == $data.presence_tag_d}selected{/if}>
						{$tag_presence[lst].tag_presence_name}
						</option>
						{/section}
						</select>
						<input  id="tag_number" class="form-control" name="tag_number" value="{$data.tag_number}" placeholder="N° marque">
					</div>
				</div>
				<div class="form-group">
					<label for="fish_length" class="control-label col-sm-4">Longueur (mm) :{t}{/t}</label>
					<div class="col-sm-8">
					<input  id="fish_length" class="form-control nombre" name="fish_length" value="{$data.fish_length}">
					</div>
				</div>
				<div class="form-group">
					<label for="weight" class="control-label col-sm-4">Masse (kg) :{t}{/t}</label>
					<div class="col-sm-8">
					<input id="weight" class="form-control taux" name="weight" value="{$data.weight}">
					</div>
				</div>
				<div class="form-group">
					<label for="capture_state_id" class="control-label col-sm-4">État à la capture :{t}{/t}</label>
					<div class="col-sm-8">
						<select class="form-control" id="capture_state_id"  name="capture_state_id">
						<option value="" {if $data.capture_state_id == ""}selected{/if}>
						{section name=lst loop=$capture_state}
						<option value="{$capture_state[lst].capture_state_id}" {if $capture_state[lst].capture_state_id == $data.capture_state_id}selected{/if}>
						{$capture_state[lst].capture_state_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="handling" class="control-label col-sm-4">Manipulation effectuee :{t}{/t}</label>
					<div class="col-sm-8">
						<input  id="handling" class="form-control" name="handling" value="{$data.handling}">
					</div>
				</div>
				<div class="form-group">
					<label for=fate_id"" class="control-label col-sm-4">Devenir du poisson :{/t}<span class="red">*</span></label>
					<div class="col-sm-8">
						<select class="form-control" id="fate_id"  name="fate_id">
						{section name=lst loop=$fate}
						<option value="{$fate[lst].fate_id}" {if $fate[lst].fate_id == $data.fate_id}selected{/if}>
						{$fate[lst].fate_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="cohorte" class="control-label col-sm-4">Cohorte estimée / validée :{t}{/t}</label>
					<div id="cohorte" class="col-sm-8">
						<input id="estimated_cohort" class="nombre" name="estimated_cohort" value="{$data.estimated_cohort}">
						 /
						<input id="validated_cohort" class="nombre" name="validated_cohort" value="{$data.validated_cohort}">
					</div>
				</div>
				<div class="form-group">
					<label for="background" class="control-label col-sm-4">Histoire du poisson :{t}{/t}</label>
					<div class="col-sm-8">
						<input  id="background" class="form-control" name="background" value="{$data.background}">
					</div>
				</div>
				<div class="form-group">
					<label for="remarks" class="control-label col-sm-4">Commentaire :{t}{/t}</label>
					<div class="col-sm-8">
						<textarea  id="remarks" class="form-control" name="remarks" rows="3" cols="50">{$data.remarks}</textarea>
					</div>
				</div>
				<fieldset>
				<legend>Photos attachées</legend>
				<div class="form-group">
<label for="" class="control-label col-sm-4">Fichier(s) à importer :
 (doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv, mp4, avi, 3gp, wmv, ts, mov)
</label>
<label for="" class="control-label col-sm-4"><input type="file" name="documentName[]" class="remarks" multiple></label>
</div>
<div class="form-group">
<label for="document_description" class="control-label col-sm-4">Description :{t}{/t}</label>
<div class="col-sm-8">
<input type="text" id="document_description" class="form-control" name="document_description" value="">
</div>
</div>
</fieldset>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.fish_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
      </div>
		</form>
	</fieldset>
<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>

{if $data.fish_id > 0}
<div class="col-sm-12">
<fieldset><legend>Photos associées</legend>
{include file="declaration/documentList.tpl"}
</fieldset>
</div>
{/if}


</div>
