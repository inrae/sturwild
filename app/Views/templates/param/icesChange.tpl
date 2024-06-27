
<h2>{t}Création / modification d'une zone CIEM{/t}</h2>

<div class="row">
<div class="col-sm-12">
<a href="icesList">{t}Retour à la liste{/t}</a>
</div>

<div class="col-sm-6">
<form class="form-horizontal " method="post" action="icesWrite">
	<input type="hidden" name="ices_id" id="ices_id"
		value="{$data.ices_id}">
		<input type="hidden" name="moduleBase" value="ices">
	<div class="form-group">
<label for="ices_name" class="control-label col-sm-4">
		{t}Libelle de la zone CIEM  :{/t}<span class="red">*</span></label>
		<div class="col-sm-8">
			<input class="form-control"  id="ices_name" name="ices_name"
				value="{$data.ices_name}" maxlength="255" autofocus required>
		</div>
	</div>
	<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.ices_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
 			{$csrf}</form>
<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>
</div>
</div>
