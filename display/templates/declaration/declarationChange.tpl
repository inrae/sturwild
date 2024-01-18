<h2>{t}Modification d'une déclaration{/t}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=declarationList">
<img src="display/images/list.png" height="25">
{t}Retour à la liste{/t}</a>
{if $data.declaration_id > 0}
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
<img src="display/images/display.png" height="25">
Retour au détail</a>
{/if}
</div>

<div class="col-sm-6">
	<fieldset>
		<legend>{t}Données générales{/t}{if $data.declaration_id > 0} - N° {$data.declaration_id}{/if}</legend>
		<div>

			<form class="form-horizontal protoform" method="post" action="index.php">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="moduleBase" value="declaration">
				<input type="hidden" name="action" value="Write">

				<div class="form-group">
					<label for="status_id" class="control-label col-sm-4">
						{t}Statut  :{/t}<span class="red">*</span>
					</label>
					<div class="col-sm-8">
						<select id="status_id" name="status_id" class="form-control" >
						{section name=lst loop=$status}
						<option value="{$status[lst].status_id}" {if $status[lst].status_id == $data.status_id}selected{/if}>
						{$status[lst].status_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="species_id" class="control-label col-sm-4">
						{t}Espèce :{/t}<span class="red">*</span>
					</label>
					<div class="col-sm-8">
						<select id="species_id" name="species_id" class="form-control" autofocus>

						{section name=lst loop=$species}
						<option value="{$species[lst].species_id}" {if $species[lst].species_id == $data.species_id}selected{/if}>
						{$species[lst].species_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
				<label for="identification_quality" class="control-label col-sm-4">{t}Qualité de l'identification :{/t}</label>
				<div class="col-sm-8">
				<select id="identification_quality" name="identification_quality" class="form-control">
				<option value="0" {if $data.identification_quality == 0}selected{/if}>
				{t}Détermination incertaine{/t}
				</option>
				<option value="1" {if $data.identification_quality == 1}selected{/if}>
				{t}Détermination confirmée{/t}
				</option>
				</select>
				</div>
				</div>
				<div class="form-group">
				<label for="caught_number" class="control-label col-sm-4">
					{t}Nombre total d'esturgeons capturés :{/t}<span class="red">*</span>
				</label>
				<div class="col-sm-8"><input class="nombre form-control" id="caught_number" name="caught_number" value="{$data.caught_number}" required ></div>
				</div>
				<div class="form-group">
				<label for="year" class="control-label col-sm-4">
					{t}Année de capture :{/t}<span class="red">*</span>
				</label>
				<div class="col-sm-8">
				<select id="year" name="year" class="form-control">
				{foreach from=$years item=year}
				<option value="{$year}" {if $year==$data.year}selected{/if}>
				{$year}
				</option>
				{/foreach}
				</select>
				</div>
				</div>

				<div class="form-group">
					<label for="capture_date_zone" class="control-label col-sm-4">
						{t}Date de capture (période/heure) :{/t}
					</label>
					<div class="col-sm-8" id="capture_date_zone">
						<input class="datepicker form-control" id="capture_date" name="capture_date" value="{$data.capture_date}">
						(<input id="estimated_capture_date" name="estimated_capture_date" value="{$data.estimated_capture_date}" placeholder="période ou heure de la capture" title="Période ou heur de la capture">)
					</div>
				</div>
				<div class="form-group">
					<label for="depth_zone" class="control-label col-sm-4">
						{t}Profondeur (ou gamme de profondeur) :{/t}
					</label>
					<div class="col-sm-8" id="depth_zone">
						<input class="nombre form-control" id="depth" name="depth" value="{$data.depth}">
						({t}de :{/t} <input name="depth_min" id="depth_min" value="{$data.depth_min}" placeholder="min" class="nombre num5"> m.
						{t}à :{/t} <input name="depth_max" id="depth_max" value="{$data.depth_max}" placeholder="max" class="nombre num5"> m.)
					</div>
				</div>
				<div class="form-group">
					<label for="origin_id" class="control-label col-sm-4">
						{t}Statut du déclarant  :{/t}<span class="red">*</span>
					</label>
					<div class="col-sm-8">
						<select id="origin_id" name="origin_id" class="form-control">
						{section name=lst loop=$origin}
						<option value="{$origin[lst].origin_id}" {if $origin[lst].origin_id == $data.origin_id}selected{/if}>
						{$origin[lst].origin_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="fisher_code" class="control-label col-sm-4">
						{t}Code du pécheur :{/t}
					</label>
					<div class="col-sm-8">
						<input id="fisher_code" class="form-control" name="fisher_code" value="{$data.fisher_code}">
					</div>
				</div>
				<div class="form-group">
					<label for="harbour_vessel" class="control-label col-sm-4">
						{t}Port d'attache du navire de pêche :{/t}
					</label>
					<div class="col-sm-8">
						<input id="harbour_vessel" class="form-control" name="harbour_vessel" value="{$data.harbour_vessel}">
					</div>
				</div>
				<div class="form-group">
					<label for="contact_coord" class="control-label col-sm-4">
						{t}Autre correspondant et coordonnées :{/t}
					</label>
					<div class="col-sm-8">
						<input id="contact_coord" class="form-control" name="contact" value="{$data.contact}">
						<br>
						<textarea class="form-control" id="contact_coord" name="contact_coord" rows="3" cols="50" placeholder="{t}coordonnées{/t}">{$data.contact_coord}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="capture_method_id" class="control-label col-sm-4">
						{t}Méthode de capture :{/t}
					</label>
					<div class="col-sm-8">
						<select id="capture_method_id" class="form-control" name="capture_method_id" autofocus>
						<option value="" {if $data.capture_method_id == ""}selected{/if}>
						{section name=lst loop=$capture_method}
						<option value="{$capture_method[lst].capture_method_id}" {if $capture_method[lst].capture_method_id == $data.capture_method_id}selected{/if}>
						{$capture_method[lst].capture_method_name}
						</option>
						{/section}
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="engin" class="control-label col-sm-4">
						{t}Type d'engin utilisé et maille :{/t}
					</label>
					<div class="col-sm-8" id="engin">
					<select class="form-control" id="gear_type_id" name="gear_type_id">
						<option value="" {if $data.gear_type_id == ""}selected{/if}>
						{section name=lst loop=$gear_type}
						<option value="{$gear_type[lst].gear_type_id}" {if $gear_type[lst].gear_type_id == $data.gear_type_id}selected{/if}>
						{$gear_type[lst].gear_type_name}
						</option>
						{/section}
						</select>
						<input class="form-control" id="gear_mesh" name="gear_mesh" value="{$data.gear_mesh}" placeholder="{t}maille - précisez le mode de mesure{/t}">
					</div>
				</div>
				<div class="form-group">
					<label for="target_species_id" class="control-label col-sm-4">
						{t}Espèce ciblée :{/t}
					</label>
					<div class="col-sm-8">
						<select id="target_species_id" name="target_species_id" class="form-control">
							<option value="" {if $data.target_species_id == ""}selected{/if}>
							</option>
							{foreach $target_species as $target}
							<option value="{$target.target_species_id}" {if $target.target_species_id == $data.target_species_id}selected{/if}>
								{$target.target_species_name}
							</option>
							{/foreach}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="target_species" class="control-label col-sm-4">
						{t}Commentaire sur l'espèce ciblée :{/t}
					</label>
					<div class="col-sm-8">
						<input class="form-control" id="target_species" name="target_species" value="{$data.target_species}">
					</div>
				</div>

				<div class="form-group">
					<label for="declaration_mode" class="control-label col-sm-4">
						{t}Mode de déclaration :{/t}
					</label>
					<div class="col-sm-8">
						<input class="form-control" id="declaration_mode" name="declaration_mode" value="{$data.declaration_mode}">
					</div>
				</div>
				<div class="form-group">
					<label for="institute_id" class="control-label col-sm-4">
						{t}Institut ayant recueilli la déclaration :{/t}
					</label>
					<div class="col-md-8">
						<select id="institute_id" name="institute_id" class="form-control">
							<option value="" {if $data.institute_id == ""}selected{/if}></option>
							{foreach $institutes as $institute} 
							<option value="{$institute.institute_id}" {if $institute.institute_id == $data.institute_id}selected{/if}>
							{$institute.institute_code}
							</option>
							{/foreach}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="remarks" class="control-label col-sm-4">
						{t}Observations :{/t}
					</label>
					<div class="col-sm-8">
						<textarea class="form-control" id="remarks" name="remarks" rows="3" cols="50">{$data.remarks}</textarea>
					</div>
				</div>
				<fieldset>
				<legend>{t}Informations sur le lot d'esturgeons{/t}</legend>
				<div class="form-group">
				<label for="lot" class="control-label col-sm-4">{t}Longueur totale (mm) :{/t}</label>
				<div class="col-sm-8" id="lot">{t}de :{/t} <input class="form-control nombre" id="length_min" name="length_min" value="{$data.length_min}">
				 {t}à :{/t}<input class="form-control nombre" id="length_max" name="length_max" value="{$data.length_max}">
				 </div>
				</div>
				<div class="form-group">
				<label for="weight" class="control-label col-sm-4">{t}Masse (kg) :{/t}</label>
				<div class="col-sm-8" id="weight">{t}de :{/t} <input class="form-control nombre" id="weight_min" name="weight_min" value="{$data.weight_min}">
				 {t}à :{/t}<input class="form-control nombre" id="weight_max" name="weight_max" value="{$data.weight_max}"></div>
				</div>
				<div class="form-group">
				<label for="capture_state_id" class="control-label col-sm-4">
					{t}État à la capture :{/t}
				</label>
				<div class="col-sm-8">
				<select class="form-control" id="capture_state_id" name="capture_state_id">
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
										<input type="checkbox" name="handlings[]" value="{$handling.handling_id}" class="form-control"
										{if $handling.is_selected == 1}checked{/if}>
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
				<div class="col-sm-8"><input class="remarks form-control" id="handling" name="handling" value="{$data.handling}"></div>
				</div>
				<div class="form-group">
					<label for="fate_id" class="control-label col-sm-4">
						{t}Devenir du lot :{/t}<span class="red">*</span>
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="fate_id" name="fate_id" >
						{section name=lst loop=$fate}
						<option value="{$fate[lst].fate_id}" {if $fate[lst].fate_id == $data.fate_id}selected{/if}>
						{$fate[lst].fate_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				</fieldset>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.declaration_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
</div>
</fieldset>


<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>
