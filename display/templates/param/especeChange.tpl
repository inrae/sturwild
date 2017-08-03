<h2>Modification d'une espèce</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=especeList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="espece_id" id="espece_id"
		value="{$data.espece_id}">
		<input type="hidden" name="moduleBase" value="espece">
<input type="hidden" name="action" value="Write">

<div class="form-group">
<label for="espece_libelle" class="control-label col-sm-4">
	Libellé de l'espèce <span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input class="form-control" id="espece_libelle" name="espece_libelle"
				value="{$data.espece_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{$LANG["message"].19}</button>
      {if $data.espece_id > 0 }
      <button class="btn btn-danger button-delete">{$LANG["message"].20}</button>
      {/if}
 </div>
</form>	
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
