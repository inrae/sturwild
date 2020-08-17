<h2>Modification d'un type d'engin de pêche</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=enginTypeList">Retour à la liste</a>
</div>

<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="engin_type_id" id="engin_type_id"
		value="{$data.engin_type_id}">
		<input type="hidden" name="moduleBase" value="enginType">
<input type="hidden" name="action" value="Write">
<div class="form-group">
<label for="engin_type_libelle" class="control-label col-sm-4">
	Type d'engin de pêche <span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input class="form-control" id="engin_type_libelle" name="engin_type_libelle"
				value="{$data.engin_type_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.engin_type_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
