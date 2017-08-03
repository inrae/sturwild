<h2>Modification d'une destination d'un esturgeon capturé</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=devenirList">Retour à la liste</a>
</div>

<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="devenir_id" id="devenir_id"
		value="{$data.devenir_id}">
		<input type="hidden" name="moduleBase" value="devenir">
<input type="hidden" name="action" value="Write">

<div class="form-group">
<label for="devenir_libelle" class="control-label col-sm-4">
	Nom de la destination <span class="red">*</span> :</label>
	<div class="col-sm-8">
				<input class="form-control" id="devenir_libelle" name="devenir_libelle"
				value="{$data.devenir_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{$LANG["message"].19}</button>
      {if $data.example_id > 0 }
      <button class="btn btn-danger button-delete">{$LANG["message"].20}</button>
      {/if}
 </div>
</form>

<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>
