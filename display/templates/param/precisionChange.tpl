<h2>Création / modification de la précision de la localisation</h2>

<div class="row">
  <div class="col-sm-12">
    <a href="index.php?module=precisionList">Retour à la liste</a>
  </div>

  <div class="col-sm-6">
    <form class="form-horizontal protoform" method="post" action="index.php">
      <input type="hidden" name="precision_id" id="precision_id" value="{$data.precision_id}">
      <input type="hidden" name="moduleBase" value="precision">
      <input type="hidden" name="action" value="Write">
      <div class="form-group">
        <label for="precision_name" class="control-label col-sm-4">
          Libellé <span class="red">*</span> :</label>
        <div class="col-sm-8">
          <input class="form-control" id="precision_name" name="precision_name" value="{$data.precision_name}"
             autofocus required>
        </div>
      </div>
      <div class="form-group center">
        <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
        {if $data.precision_id > 0 }
        <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
        {/if}
      </div>
    </form>
    <span class="red">*</span>
    <span class="messagebas">Champ obligatoire</span>
  </div>
</div>
