<h2>Modification d'un esturgeon</h2>

<a href="index.php?module=declarationList">Retour à la liste des déclarations</a>
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
Retour au détail de la déclaration - N° {$data.declaration_id}</a>
<div class="formSaisie">
	<fieldset>
		<legend>Esturgeon capturé</legend>
		<div>

			<form method="post" action="index.php?module=individuWrite"  enctype="multipart/form-data">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="individu_id" value="{$data.individu_id}">
				<dl>
					<dt>
						Espèce :
					</dt>
					<dd>
						<select name="espece_id" autofocus>
						<option value="" {if $data.espece_id == ""}selected{/if}>
						Sélectionnez...
						</option>
						{section name=lst loop=$espece}
						<option value="{$espece[lst].espece_id}" {if $espece[lst].espece_id == $data.espece_id}selected{/if}>
						{$espece[lst].espece_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>Qualité de l'identification :</dt>
					<dd>
						<select name="qualite_identification">
						<option value="0" {if $data.qualite_identification == 0}selected{/if}>
							Détermination incertaine
						</option>
						<option value="1" {if $data.qualite_identification == 1}selected{/if}>
							Détermination confirmée
						</option>				
						</select>
					</dd>
				</dl>
				<dl>
					<dt>Marque ?</dt>
					<dd>
						<select name="presence_marque_id">
						{section name=lst loop=$presence_marque}
						<option value="{$presence_marque[lst].presence_marque_id}" {if $presence_marque[lst].presence_marque_id == $data.presence_marque_id}selected{/if}>
						{$presence_marque[lst].presence_marque_libelle}
						</option>
						{/section}
						</select>
						<input name="numero_marque" value="{$data.numero_marque}" placeholder="N° marque">
					</dd>
				</dl>
				<dl>
					<dt>Longueur (mm) :</dt>
					<dd>
					<input class="nombre" name="longueur_individu" value="{$data.longueur_individu}">
					</dd>
				</dl>
				<dl>
					<dt>Masse (kg) :</dt>
					<dd><input class="taux" name="masse" value="{$data.masse}">
					</dd>
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
					<dt>Manipulation effectuee :</dt>
					<dd>
						<input class="commentaire" name="manipulation" value="{$data.manipulation}">
					</dd>
				</dl>
				<dl>
					<dt>Devenir du poisson<span class="red">*</span> :</dt>
					<dd>
						<select name="devenir_id">
						{section name=lst loop=$devenir}
						<option value="{$devenir[lst].devenir_id}" {if $devenir[lst].devenir_id == $data.devenir_id}selected{/if}>
						{$devenir[lst].devenir_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>Cohorte estimée / validée :</dt>
					<dd>
						<input class="nombre" name="cohorte_estimee" value="{$data.cohorte_estimee}">
						 / 
						<input class="nombre" name="cohorte_validee" value="{$data.cohorte_validee}">
					</dd>
				</dl>
				<dl>
					<dt>Histoire du poisson :</dt>
					<dd>
						<input class="commentaire" name="historique" value="{$data.historique}">
					</dd>
				</dl>
				<dl>
					<dt>Commentaire :</dt>
					<dd>
						<textarea name="commentaire" rows="3" cols="50">{$data.commentaire}</textarea>
					</dd>
				</dl>	
				<fieldset>
				<legend>Photos attachées</legend>
				<dl>
<dt>Fichier(s) à importer :
<br>(doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv, mp4, avi, 3gp, wmv, ts, mov)
</dt>
<dt><input type="file" name="documentName[]" class="commentaire" multiple></dt>
</dl>
<dl>
<dt>Description :</dt>
<dd>
<input type="text" name="document_description" value="" class="commentaire">
</dd>
</dl>
</fieldset>				
							
				<div class="formBouton">
					<input class="submit" type="submit" value="Enregistrer">
				</div>
			</form>
			{if $data.individu_id>0}
			<div class="formBouton">
			<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="individu_id" value="{$data.individu_id}">
				<input type="hidden" name="module" value="individuDelete"> 
				<input class="submit" type="submit" value="Supprimer">
			</form>
			</div>
			{/if}
			
		</div>
	</fieldset>
</div>

{if $data.individu_id > 0}
<table class="tablemulticolonne">
<tr><td>
<fieldset><legend>Photos associées</legend>
{include file="declaration/documentList.tpl"}
</fieldset>
</td>
</tr>
</table>
{/if}

<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>					