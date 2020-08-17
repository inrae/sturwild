<h2>Modification d'un esturgeon</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=declarationList">Retour à la liste des déclarations</a>
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
Retour au détail de la déclaration - N° {$data.declaration_id}</a>
</div>
<div class="col-sm-6">
	<fieldset>
		<legend>Esturgeon capturé</legend>

			<form class="form-horizontal protoform" method="post" action="index.php"  enctype="multipart/form-data">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="individu_id" value="{$data.individu_id}">
				<input type="hidden" name="moduleBase" value="individu">
				<input type="hidden" name="action" value="Write">
				<div class="form-group">
					<label for="espece_id" class="control-label col-sm-4">
						Espèce :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="espece_id"  name="espece_id" autofocus>
						<option value="" {if $data.espece_id == ""}selected{/if}>
						Sélectionnez...
						</option>
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
						<select class="form-control" id="qualite_identification"  name="qualite_identification">
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
					<label for="presence_marque_id" class="control-label col-sm-4">Marque ?</label>
					<div class="col-sm-8">
						<select class="form-control" id="presence_marque_id"  name="presence_marque_id">
						{section name=lst loop=$presence_marque}
						<option value="{$presence_marque[lst].presence_marque_id}" {if $presence_marque[lst].presence_marque_id == $data.presence_marque_id}selected{/if}>
						{$presence_marque[lst].presence_marque_libelle}
						</option>
						{/section}
						</select>
						<input  id="numero_marque" class="form-control" name="numero_marque" value="{$data.numero_marque}" placeholder="N° marque">
					</div>
				</div>
				<div class="form-group">
					<label for="longueur_individu" class="control-label col-sm-4">Longueur (mm) :</label>
					<div class="col-sm-8">
					<input  id="longueur_individu" class="form-control nombre" name="longueur_individu" value="{$data.longueur_individu}">
					</div>
				</div>
				<div class="form-group">
					<label for="masse" class="control-label col-sm-4">Masse (kg) :</label>
					<div class="col-sm-8">
					<input id="masse" class="form-control taux" name="masse" value="{$data.masse}">
					</div>
				</div>
				<div class="form-group">
					<label for="capture_etat_id" class="control-label col-sm-4">État à la capture :</label>
					<div class="col-sm-8">
						<select class="form-control" id="capture_etat_id"  name="capture_etat_id">
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
					<label for="manipulation" class="control-label col-sm-4">Manipulation effectuee :</label>
					<div class="col-sm-8">
						<input  id="manipulation" class="form-control" name="manipulation" value="{$data.manipulation}">
					</div>
				</div>
				<div class="form-group">
					<label for=devenir_id"" class="control-label col-sm-4">Devenir du poisson<span class="red">*</span> :</label>
					<div class="col-sm-8">
						<select class="form-control" id="devenir_id"  name="devenir_id">
						{section name=lst loop=$devenir}
						<option value="{$devenir[lst].devenir_id}" {if $devenir[lst].devenir_id == $data.devenir_id}selected{/if}>
						{$devenir[lst].devenir_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="cohorte" class="control-label col-sm-4">Cohorte estimée / validée :</label>
					<div id="cohorte" class="col-sm-8">
						<input id="cohorte_estimee" class="nombre" name="cohorte_estimee" value="{$data.cohorte_estimee}">
						 / 
						<input id="cohorte_validee" class="nombre" name="cohorte_validee" value="{$data.cohorte_validee}">
					</div>
				</div>
				<div class="form-group">
					<label for="historique" class="control-label col-sm-4">Histoire du poisson :</label>
					<div class="col-sm-8">
						<input  id="historique" class="form-control" name="historique" value="{$data.historique}">
					</div>
				</div>
				<div class="form-group">
					<label for="commentaire" class="control-label col-sm-4">Commentaire :</label>
					<div class="col-sm-8">
						<textarea  id="commentaire" class="form-control" name="commentaire" rows="3" cols="50">{$data.commentaire}</textarea>
					</div>
				</div>	
				<fieldset>
				<legend>Photos attachées</legend>
				<div class="form-group">
<label for="" class="control-label col-sm-4">Fichier(s) à importer :
<br>(doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv, mp4, avi, 3gp, wmv, ts, mov)
</label>
<label for="" class="control-label col-sm-4"><input type="file" name="documentName[]" class="commentaire" multiple></label>
</div>
<div class="form-group">
<label for="document_description" class="control-label col-sm-4">Description :</label>
<div class="col-sm-8">
<input type="text" id="document_description" class="form-control" name="document_description" value="">
</div>
</div>
</fieldset>	
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.individu_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
      </div>		
		</form>				
	</fieldset>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>	
</div>
	
{if $data.individu_id > 0}
<div class="col-sm-12">
<fieldset><legend>Photos associées</legend>
{include file="declaration/documentList.tpl"}
</fieldset>
</div>
{/if}


</div>
				