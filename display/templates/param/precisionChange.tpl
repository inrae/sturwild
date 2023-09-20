<h2>Création / modification de la précision de la location</h2>

<div class="row">
  <div class="col-sm-12">
    <a href="index.php?module=accuracyList">Retour à la liste</a>
  </div>

  <div class="col-sm-6">
    <form class="form-horizontal protoform" method="post" action="index.php">
      <input type="hidden" name="accuracy_id" id="accuracy_id" value="{$data.accuracy_id}">
      <input type="hidden" name="moduleBase" value="accuracy">
      <input type="hidden" name="action" value="Write">
      <div class="form-group">
        <label for="accuracy_name" class="control-label col-sm-4">
          Libellé <span class="red">*</span> :</label>
        <div class="col-sm-8">
          <input class="form-control" id="accuracy_name" name="accuracy_name" value="{$data.accuracy_name}"
             autofocus required>
        </div>
      </div>
      <div class="form-group center">
        <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
        {if $data.accuracy_id > 0 }
        <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
        {/if}
      </div>
    </form>
    <span class="red">*</span>
    <span class="messagebas">Champ obligatoire</span>
  </div>
</div>
