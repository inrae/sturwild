<h2>{t}Modification d'un esturgeon{/t}</h2>
<div class="row">
	<div class="col-sm-12">
		<a href="declarationList">
			<img src="display/images/list.png" height="25">
			{t}Retour à la liste des déclarations{/t}
		</a>
		<a href="declarationDisplay?declaration_id={$data.declaration_id}">
			<img src="display/images/display.png" height="25">
			{t}Retour au détail de la déclaration - N°{/t} {$data.declaration_id}</a>
	</div>
	<div class="col-lg-6">
		<fieldset>
			<legend>{t}Esturgeon capturé{/t}</legend>

			<form class="form-horizontal " method="post" action="fishWrite" enctype="multipart/form-data">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="fish_id" value="{$data.fish_id}">
				<input type="hidden" name="moduleBase" value="fish">
				<div class="form-group">
					<label for="species_id" class="control-label col-sm-4">
						{t}Espèce :{/t}
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="species_id" name="species_id" autofocus>
							<option value="" {if $data.species_id=="" }selected{/if}>
								{t}Sélectionnez...{/t}
							</option>
							{section name=lst loop=$species}
							<option value="{$species[lst].species_id}" {if
								$species[lst].species_id==$data.species_id}selected{/if}>
								{$species[lst].species_name}
							</option>
							{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="identification_quality" class="control-label col-sm-4">
						{t}Qualité de l'identification :{/t}
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="identification_quality" name="identification_quality">
							<option value="0" {if $data.identification_quality==0}selected{/if}>
								{t}Détermination incertaine{/t}
							</option>
							<option value="1" {if $data.identification_quality==1}selected{/if}>
								{t}Détermination confirmée{/t}
							</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="presence_tag_d" class="control-label col-sm-4">
						{t}Marque ?{/t}
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="presence_tag_d" name="presence_tag_d">
							{section name=lst loop=$tag_presence}
							<option value="{$tag_presence[lst].presence_tag_d}" {if
								$tag_presence[lst].presence_tag_d==$data.presence_tag_d}selected{/if}>
								{$tag_presence[lst].tag_presence_name}
							</option>
							{/section}
						</select>
						<input id="tag_number" class="form-control" name="tag_number" value="{$data.tag_number}"
							placeholder="{t}N° de marque{/t}">
					</div>
				</div>
				<div class="form-group">
					<label for="fish_length" class="control-label col-sm-4" >
						{t}Longueur (mm) :{/t}
					</label>
					<div class="col-sm-8">
						<input id="fish_length" class="form-control nombre" name="fish_length"
							value="{$data.fish_length}">
					</div>
				</div>
				<div class="form-group">
					<label for="weight" class="control-label col-sm-4">
						{t}Masse (kg) :{/t}
					</label>
					<div class="col-sm-8">
						<input id="weight" class="form-control taux" name="weight" value="{$data.weight}">
					</div>
				</div>
				<div class="form-group">
					<label for="capture_state_id" class="control-label col-sm-4">
						{t}État à la capture :{/t}
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="capture_state_id" name="capture_state_id">
							<option value="" {if $data.capture_state_id=="" }selected{/if}>
								{section name=lst loop=$capture_state}
							<option value="{$capture_state[lst].capture_state_id}" {if
								$capture_state[lst].capture_state_id==$data.capture_state_id}selected{/if}>
								{$capture_state[lst].capture_state_name}
							</option>
							{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="handlings" class="control-label col-sm-4">
						{t}Manipulations effectuées :{/t}
					</label>
					<div class="col-sm-8">
						<table class="table table-condensed table-nobordered">
							<tbody>
								{$nb = 0}
								</tr>
								{foreach $handlings as $handling}
								{if $nb == 0}<tr>{/if}
									<td class="right"><label class="">{$handling.handling_name}</label></td>
									<td class="center">
										<input type="checkbox" name="handlings[]" value="{$handling.handling_id}"
											class="form-control" {if $handling.is_selected==1}checked{/if}>
									</td>
									{$nb = $nb + 1}
									{if $nb == 2}
								</tr>
								{$nb = 0}
								{/if}
								{/foreach}
								{if $nb == 1}</tr>{/if}
							</tbody>
						</table>
					</div>
				</div>
				<div class="form-group">
					<label for="handling" class="control-label col-sm-4">
						{t}Compléments sur les manipulations effectuées :{/t}
					</label>
					<div class="col-sm-8"><input class="remarks form-control" id="handling" name="handling"
							value="{$data.handling}"></div>
				</div>
				<div class="form-group">
					<label for=fate_id"" class="control-label col-sm-4">
						{t}Devenir du poisson :{/t}
						<span class="red">*</span>
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="fate_id" name="fate_id">
							{section name=lst loop=$fate}
							<option value="{$fate[lst].fate_id}" {if $fate[lst].fate_id==$data.fate_id}selected{/if}>
								{$fate[lst].fate_name}
							</option>
							{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="cohorte" class="control-label col-sm-4">
						{t}Cohorte estimée / validée :{/t}
					</label>
					<div id="cohorte" class="col-sm-8">
						<input id="estimated_cohort" class="nombre" name="estimated_cohort"
							value="{$data.estimated_cohort}">
						/
						<input id="validated_cohort" class="nombre" name="validated_cohort"
							value="{$data.validated_cohort}">
					</div>
				</div>
				<div class="form-group">
					<label for="background" class="control-label col-sm-4">
						{t}Histoire du poisson :{/t}
					</label>
					<div class="col-sm-8">
						<input id="background" class="form-control" name="background" value="{$data.background}">
					</div>
				</div>
				<div class="form-group">
					<label for="remarks" class="control-label col-sm-4">
						{t}Commentaire :{/t}
					</label>
					<div class="col-sm-8">
						<textarea id="remarks" class="form-control" name="remarks" rows="3"
							cols="50">{$data.remarks}</textarea>
					</div>
				</div>
				<fieldset>
					<legend>{t}Photos attachées{/t}</legend>
					<div class="form-group">
						<label for="" class="control-label col-sm-4">
							{t}Fichier(s) à importer :{/t}
							(doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv, mp4, avi, 3gp, wmv, ts, mov)
						</label>
						<label for="" class="control-label col-sm-4"><input type="file" name="documentName[]"
								class="remarks" multiple></label>
					</div>
					<div class="form-group">
						<label for="document_description" class="control-label col-sm-4">
							{t}Description :{/t}
						</label>
						<div class="col-sm-8">
							<input type="text" id="document_description" class="form-control"
								name="document_description" value="">
						</div>
					</div>
				</fieldset>
				<div class="form-group center">
					<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
					{if $data.fish_id > 0 }
					<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
					{/if}
				</div>
			{$csrf}</form>
		</fieldset>
		<span class="red">*</span>
		<span class="messagebas">{t}Champ obligatoire{/t}</span>
	</div>

	{if $data.fish_id > 0}
	<div class="col-sm-12 col-lg-6">
		<fieldset>
			<legend>{t}Photos associées{/t}</legend>
			{include file="declaration/documentList.tpl"}
		</fieldset>
	</div>
	{/if}


</div>