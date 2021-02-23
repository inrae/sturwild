<h2>Modification d'une déclaration</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=declarationList">
<img src="display/images/list.png" height="25">
Retour à la liste</a>
{if $data.declaration_id > 0}
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
<img src="display/images/display.png" height="25">
Retour au détail</a>
{/if}
</div>

<div class="col-sm-6">
	<fieldset>
		<legend>Données générales{if $data.declaration_id > 0} - N° {$data.declaration_id}{/if}</legend>
		<div>

			<form class="form-horizontal protoform" method="post" action="index.php">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="moduleBase" value="declaration">
				<input type="hidden" name="action" value="Write">

				<div class="form-group">
					<label for="statut_id" class="control-label col-sm-4">
						Statut <span class="red">*</span> :
					</label>
					<div class="col-sm-8">
						<select id="statut_id" name="statut_id" class="form-control" >
						{section name=lst loop=$statut}
						<option value="{$statut[lst].statut_id}" {if $statut[lst].statut_id == $data.statut_id}selected{/if}>
						{$statut[lst].statut_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="espece_id" class="control-label col-sm-4">
						Espèce<span class="red">*</span> :
					</label>
					<div class="col-sm-8">
						<select id="espece_id" name="espece_id" class="form-control" autofocus>

						{section name=lst loop=$espece}
						<option value="{$espece[lst].espece_id}" {if $espece[lst].espece_id == $data.espece_id}selected{/if}>
						{$espece[lst].espece_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
				<label for="qualite_identification" class="control-label col-sm-4">Qualité de l'identification :</label>
				<div class="col-sm-8">
				<select id="qualite_identification" name="qualite_identification" class="form-control">
				<option value="0" {if $data.qualite_identification == 0}selected{/if}>
				Détermination incertaine
				</option>
				<option value="1" {if $data.qualite_identification == 1}selected{/if}>
				Détermination confirmée
				</option>
				</select>
				</div>
				</div>
				<div class="form-group">
				<label for="nombre_capture" class="control-label col-sm-4">Nombre total d'esturgeons capturés<span class="red">*</span> :</label>
				<div class="col-sm-8"><input class="nombre form-control" id="nombre_capture" name="nombre_capture" value="{$data.nombre_capture}" required ></div>
				</div>
				<div class="form-group">
				<label for="annee" class="control-label col-sm-4">Année de capture <span class="red">*</span> :</label>
				<div class="col-sm-8">
				<select id="annee" name="annee" class="form-control">
				{foreach from=$annees item=annee}
				<option value="{$annee}" {if $annee==$data.annee}selected{/if}>
				{$annee}
				</option>
				{/foreach}
				</select>
				</div>
				</div>

				<div class="form-group">
					<label for="capture_date_zone" class="control-label col-sm-4">
						Date de capture (période/heure) :
					</label>
					<div class="col-sm-8" id="capture_date_zone">
						<input class="datepicker form-control" id="capture_date" name="capture_date" value="{$data.capture_date}">
						(<input id="capture_date_estimee" name="capture_date_estimee" value="{$data.capture_date_estimee}" placeholder="période ou heure de la capture" title="Période ou heur de la capture">)
					</div>
				</div>
				<div class="form-group">
					<label for="profondeur_zone" class="control-label col-sm-4">
						profondeur (ou gamme de profondeur) :
					</label>
					<div class="col-sm-8" id="profondeur_zone">
						<input class="nombre form-control" id="profondeur" name="profondeur" value="{$data.profondeur}">
						(de : <input name="prof_min" id="prof_min" value="{$data.prof_min}" placeholder="min" class="nombre num5"> m.
						à : <input name="prof_max" id="prof_max" value="{$data.prof_max}" placeholder="max" class="nombre num5"> m.
						)
					</div>
				</div>
				<div class="form-group">
					<label for="capture_type_id" class="control-label col-sm-4">
						Statut du déclarant <span class="red">*</span> :
					</label>
					<div class="col-sm-8">
						<select id="capture_type_id" name="capture_type_id" class="form-control">
						{section name=lst loop=$capture_type}
						<option value="{$capture_type[lst].capture_type_id}" {if $capture_type[lst].capture_type_id == $data.capture_type_id}selected{/if}>
						{$capture_type[lst].capture_type_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="pecheur_code" class="control-label col-sm-4">
						Code du pécheur :
					</label>
					<div class="col-sm-8">
						<input id="pecheur_code" class="form-control" name="pecheur_code" value="{$data.pecheur_code}">
					</div>
				</div>
				<div class="form-group">
					<label for="navire_port" class="control-label col-sm-4">
						Port d'attache du navire de pêche :
					</label>
					<div class="col-sm-8">
						<input id="navire_port" class="form-control" name="navire_port" value="{$data.navire_port}">
					</div>
				</div>
				<div class="form-group">
					<label for="interlocuteur_coord" class="control-label col-sm-4">
						Autre correspondant et coordonnées :
					</label>
					<div class="col-sm-8">
						<input id="interlocuteur_coord" class="form-control" name="interlocuteur" value="{$data.interlocuteur}">
						<br>
						<textarea class="form-control" id="interlocuteur_coord" name="interlocuteur_coord" rows="3" cols="50" placeholder="coordonnées">{$data.interlocuteur_coord}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="capture_mode_id" class="control-label col-sm-4">
						Mode de capture  :
					</label>
					<div class="col-sm-8">
						<select id="capture_mode_id" class="form-control" name="capture_mode_id" autofocus>
						<option value="" {if $data.capture_mode_id == ""}selected{/if}>
						{section name=lst loop=$capture_mode}
						<option value="{$capture_mode[lst].capture_mode_id}" {if $capture_mode[lst].capture_mode_id == $data.capture_mode_id}selected{/if}>
						{$capture_mode[lst].capture_mode_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="engin" class="control-label col-sm-4">
						Type d'engin utilisé et maille :
					</label>
					<div class="col-sm-8" id="engin">
					<select class="form-control" id="engin_type_id" name="engin_type_id">
						<option value="" {if $data.engin_type_id == ""}selected{/if}>
						{section name=lst loop=$engin_type}
						<option value="{$engin_type[lst].engin_type_id}" {if $engin_type[lst].engin_type_id == $data.engin_type_id}selected{/if}>
						{$engin_type[lst].engin_type_libelle}
						</option>
						{/section}
						</select>
						<input class="form-control" id="engin_maille" name="engin_maille" value="{$data.engin_maille}" placeholder="maille">
					</div>
				</div>

				<div class="form-group">
					<label for="espece_ciblee" class="control-label col-sm-4">
						Espèce ciblée :
					</label>
					<div class="col-sm-8">
						<input class="form-control" id="espece_ciblee" name="espece_ciblee" value="{$data.espece_ciblee}">
					</div>
				</div>
				<div class="form-group">
					<label for="declaration_mode" class="control-label col-sm-4">
						Mode de déclaration :
					</label>
					<div class="col-sm-8">
						<input class="form-control" id="declaration_mode" name="declaration_mode" value="{$data.declaration_mode}">
					</div>
				</div>
				<div class="form-group">
					<label for="observation" class="control-label col-sm-4">
						Observations :
					</label>
					<div class="col-sm-8">
						<textarea class="form-control" id="observation" name="observation" rows="3" cols="50">{$data.observation}</textarea>
					</div>
				</div>
				<fieldset>
				<legend>Informations sur le lot d'esturgeons</legend>
				<div class="form-group">
				<label for="lot" class="control-label col-sm-4">Longueur totale (mm) :</label>
				<div class="col-sm-8" id="lot">de : <input class="form-control nombre" id="lt_min" name="lt_min" value="{$data.lt_min}">
				 à : <input class="form-control nombre" id="lt_max" name="lt_max" value="{$data.lt_max}">
				 </div>
				</div>
				<div class="form-group">
				<label for="masse" class="control-label col-sm-4">Masse (kg) :</label>
				<div class="col-sm-8" id="masse">de : <input class="form-control nombre" id="masse_min" name="masse_min" value="{$data.masse_min}">
				 à :<input class="form-control nombre" id="masse_max" name="masse_max" value="{$data.masse_max}"></div>
				</div>
				<div class="form-group">
				<label for="capture_etat_id" class="control-label col-sm-4">État à la capture :</label>
				<div class="col-sm-8">
				<select class="form-control" id="capture_etat_id" name="capture_etat_id">
						<option value="" {if $data.capture_etat_id == ""}selected{/if}>
						{section name=lst loop=$capture_etat}
						<option value="{$capture_etat[lst].capture_etat_id}" {if $capture_etat[lst].capture_etat_id == $data.capture_etat_id}selected{/if}>
						{$capture_etat[lst].capture_etat_libelle}
						</option>
						{/section}
						</select>
				</div>
				</div>
				<div class="form-group">
				<label for="manipulation" class="control-label col-sm-4">Manipulation effectuée :</label>
				<div class="col-sm-8"><input class="commentaire form-control" id="manipulation" name="manipulation" value="{$data.manipulation}"></div>
				</div>
				<div class="form-group">
					<label for="devenir_id" class="control-label col-sm-4">
						Devenir du lot<span class="red">*</span> :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="devenir_id" name="devenir_id" >
						{section name=lst loop=$devenir}
						<option value="{$devenir[lst].devenir_id}" {if $devenir[lst].devenir_id == $data.devenir_id}selected{/if}>
						{$devenir[lst].devenir_libelle}
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
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
