<h2>Modification d'un événement</h2>

<a href="index.php?module=declarationList">Retour à la liste des déclarations</a>
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
Retour au détail de la déclaration  - N° {$data.declaration_id}</a>
<div class="formSaisie">
	<fieldset>
		<legend>Événement</legend>
		<div>

			<form method="post" action="index.php?module=evenementWrite">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
				<input type="hidden" name="login" value="{$data.login}">
				<dl>
					<dt>
						Type d'événement <span class="red">*</span> :
					</dt>
					<dd>
						<select name="evenement_type_id" autofocus>
						{section name=lst loop=$evenement_type}
						<option value="{$evenement_type[lst].evenement_type_id}" {if $evenement_type[lst].evenement_type_id == $data.evenement_type_id}selected{/if}>
						{$evenement_type[lst].evenement_type_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
				<dt>Date de l'événement <span class="red">*</span> :</dt>
				<dd>
				<input class="date" name="evenement_date" value="{$data.evenement_date}" required>
				</dd>
				</dl>
				
				<dl><dt>Commentaire :</dt>
				<dd>
				<input class="commentaire" name="evenement_commentaire" value="{$data.evenement_commentaire}">
				</dd>
				</dl>
						<div class="formBouton">
					<input class="submit" type="submit" value="Enregistrer">
				</div>
			</form>
			{if $data.evenement_id>0}
			<div class="formBouton">
				<form action="index.php" method="post"
					onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
					<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
					<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
					<input type="hidden" name="module" value="evenementDelete"> 
					<input class="submit" type="submit" value="Supprimer">
				</form>
			</div>
			{/if}
		</div>
	</fieldset>
</div>

<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>		