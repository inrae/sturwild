<h2>Modification d'une déclaration</h2>

<a href="index.php?module=declarationList">Retour à la liste</a>
{if $data.declaration_id > 0}
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">Retour
	au détail</a>
{/if}
<div class="formSaisie">
	<fieldset>
		<legend>Données générales{if $data.declaration_id > 0} - N° {$data.declaration_id}{/if}</legend>
		<div>

			<form method="post" action="index.php?module=declarationWrite">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">

				<dl>
					<dt>
						Statut <span class="red">*</span> :
					</dt>
					<dd>
						<select name="statut_id" >
						{section name=lst loop=$statut}
						<option value="{$statut[lst].statut_id}" {if $statut[lst].statut_id == $data.statut_id}selected{/if}>
						{$statut[lst].statut_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>
						Espèce<span class="red">*</span> :
					</dt>
					<dd>
						<select name="espece_id" autofocus>
						
						{section name=lst loop=$espece}
						<option value="{$espece[lst].espece_id}" {if $espece[lst].espece_id == $data.espece_id}selected{/if}>
						{$espece[lst].espece_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl><dt>Qualité de l'identification :</dt>
				<dd>
				<select name="qualite_identification">
				<option value="0" {if $data.qualite_identification == 0}selected{/if}>
				Détermination incertaine
				</option>
				<option value="1" {if $data.qualite_identification == 1}selected{/if}>
				Détermination confirmée
				</option>				
				</select>
				</dl>
				<dl>
				<dt>Nombre total d'esturgeons capturés<span class="red">*</span> :</dt>
				<dd><input class="nombre" name="nombre_capture" value="{$data.nombre_capture}" required ></dd>
				</dl>
				<dl>
				<dt>Année de capture <span class="red">*</span> :</dt>
				<dd>
				<select name="annee">
				{foreach from=$annees item=annee}
				<option value="{$annee}" {if $annee==$data.annee}selected{/if}>
				{$annee}
				</option>
				{/foreach}
				</select>
				</dd>
				</dl>
							
				<dl>
					<dt>
						Date de capture (période/heure) :
					</dt>
					<dd>
						<input class="date" name="capture_date" value="{$data.capture_date}">
						(<input name="capture_date_estimee" value="{$data.capture_date_estimee}" placeholder="période ou heure de la capture" title="Période ou heur de la capture">)
					</dd>
				</dl>
				<dl>
					<dt>
						profondeur (ou gamme de profondeur) :
					</dt>
					<dd>
						<input class="num3" name="profondeur" value="{$data.profondeur}">
						(de : <input name="prof_min" value="{$data.prof_min}" placeholder="min" class="num3"> m.
						à : <input name="prof_max" value="{$data.prof_max}" placeholder="max" class="num3"> m.
						)
					</dd>
				</dl>
				<dl>
					<dt>
						Statut du déclarant <span class="red">*</span> :
					</dt>
					<dd>
						<select name="capture_type_id">
						{section name=lst loop=$capture_type}
						<option value="{$capture_type[lst].capture_type_id}" {if $capture_type[lst].capture_type_id == $data.capture_type_id}selected{/if}>
						{$capture_type[lst].capture_type_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>
						Code du pécheur :
					</dt>
					<dd>
						<input name="pecheur_code" value="{$data.pecheur_code}">
					</dd>
				</dl>
				<dl>
					<dt>
						Port d'attache du navire de pêche :
					</dt>
					<dd>
						<input name="navire_port" value="{$data.navire_port}">
					</dd>
				</dl>
				<dl>
					<dt>
						Autre correspondant et coordonnées :
					</dt>
					<dd>
						<input name="interlocuteur" value="{$data.interlocuteur}">
						<br>
						<textarea name="interlocuteur_coord" rows="3" cols="50" placeholder="coordonnées">{$data.interlocuteur_coord}</textarea>
					</dd>
				</dl>
				<dl>
					<dt>
						Mode de capture  :
					</dt>
					<dd>
						<select name="capture_mode_id" autofocus>
						<option value="" {if $data.capture_mode_id == ""}selected{/if}>
						{section name=lst loop=$capture_mode}
						<option value="{$capture_mode[lst].capture_mode_id}" {if $capture_mode[lst].capture_mode_id == $data.capture_mode_id}selected{/if}>
						{$capture_mode[lst].capture_mode_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>

				<dl>
					<dt>
						Type d'engin utilisé et maille :
					</dt>
					<dd>
					<select name="engin_type_id">
						<option value="" {if $data.engin_type_id == ""}selected{/if}>
						{section name=lst loop=$engin_type}
						<option value="{$engin_type[lst].engin_type_id}" {if $engin_type[lst].engin_type_id == $data.engin_type_id}selected{/if}>
						{$engin_type[lst].engin_type_libelle}
						</option>
						{/section}
						</select>
						<input name="engin_maille" value="{$data.engin_maille}" placeholder="maille">
					</dd>
				</dl>
				
				<dl>
					<dt>
						Espèce ciblée :
					</dt>
					<dd>
						<input name="espece_ciblee" value="{$data.espece_ciblee}">
					</dd>
				</dl>
				<dl>
					<dt>
						Mode de déclaration :
					</dt>
					<dd>
						<input name="declaration_mode" value="{$data.declaration_mode}">
					</dd>
				</dl>
				<dl>
					<dt>
						Observations :
					</dt>
					<dd>
						<textarea name="observation" rows="3" cols="50">{$data.observation}</textarea>
					</dd>
				</dl>				
				<fieldset>
				<legend>Informations sur le lot d'esturgeons</legend>
				<dl>
				<dt>Longueur totale (mm) :</dt>
				<dd>de : <input name="lt_min" value="{$data.lt_min}" class="nombre">
				 à : <input name="lt_max" value="{$data.lt_max}" class="nombre">
				 </dd>
				</dl>
				<dl>
				<dt>Masse (kg) :</dt>
				<dd>de : <input name="masse_min" value="{$data.masse_min}" class="nombre">
				 à :<input name="masse_max" value="{$data.masse_max}" class="nombre"></dd>
				</dl>
				<dl>
				<dt>État à la capture :</dt>
				<dd>
				<select name="capture_etat_id">
						<option value="" {if $data.capture_etat_id == ""}selected{/if}>
						{section name=lst loop=$capture_etat}
						<option value="{$capture_etat[lst].capture_etat_id}" {if $capture_etat[lst].capture_etat_id == $data.capture_etat_id}selected{/if}>
						{$capture_etat[lst].capture_etat_libelle}
						</option>
						{/section}
						</select>
				</dd>
				</dl>
				<dl>
				<dt>Manipulation effectuée :</dt>
				<dd><input class="commentaire" name="manipulation" value="{$data.manipulation}"></dd>
				</dl>
				<dl>
					<dt>
						Devenir du lot<span class="red">*</span> :
					</dt>
					<dd>
						<select name="devenir_id" >
						{section name=lst loop=$devenir}
						<option value="{$devenir[lst].devenir_id}" {if $devenir[lst].devenir_id == $data.devenir_id}selected{/if}>
						{$devenir[lst].devenir_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				</fieldset>

				<div class="formBouton">
					<input class="submit" type="submit" value="Enregistrer">
				</div>
			</form>
			{if $data.declaration_id>0}
			<div class="formBouton">
				<form action="index.php" method="post"
					onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
					<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
					<input type="hidden" name="module" value="declarationDelete"> 
					<input class="submit" type="submit" value="Supprimer">
				</form>
			</div>
			{/if}
		</div>
	</fieldset>
</div>

<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>