
<h2>Création / modification d'une zone CIEM</h2>

<div class="row">
<div class="col-sm-12">
<a href="index.php?module=ciemList">Retour à la liste</a>
</div>

<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="ciem_id" id="ciem_id"
		value="{$data.ciem_id}">
		<input type="hidden" name="moduleBase" value="ciem">
<input type="hidden" name="action" value="Write">
	<div class="form-group">
<label for="ciem_libelle" class="control-label col-sm-4">
		Libelle de la zone CIEM <span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input class="form-control"  id="ciem_libelle" name="ciem_libelle"
				value="{$data.ciem_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.ciem_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
 			</form>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
