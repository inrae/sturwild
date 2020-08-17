<h2>Modification d'un milieu détaillé</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=milieuDetailList">Retour à la liste</a>
</div>
<div class="col-sm-6">
<form class="form-horizontal protoform" method="post" action="index.php">
	<input type="hidden" name="milieu_detail_id" id="milieu_detail_id"
		value="{$data.milieu_detail_id}">
		<input type="hidden" name="moduleBase" value="milieuDetail">
<input type="hidden" name="action" value="Write">

<div class="form-group">
<label for="milieu_detail_libelle" class="control-label col-sm-4">
	Libellé du milieu <span class="red">*</span> :</label>
		<div class="col-sm-8">
			<input class="form-control" id="milieu_detail_libelle" name="milieu_detail_libelle"
				value="{$data.milieu_detail_libelle}" maxlength="255" autofocus required>
		</div>
	</div>
<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.milieu_detail_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>	
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
</div>