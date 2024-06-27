<h2>{t}Modification d'un statut :{/t}</h2>
<a href="statusList"><img src="display/images/list.png" height="25">{t}Retour à la liste{/t}</a>
<div class="row">
  <div class="col-md-6">
    <form class="form-horizontal " id="paramForm" method="post" action="statusWrite">
      <input type="hidden" name="moduleBase" value="status">
      <input type="hidden" name="status_id" value="{$data.status_id}">
      <div class="form-group">
        <label for="paramName" class="control-label col-md-4">
          <span class="red">*</span>
          {t}Libellé :{/t}
        </label>
        <div class="col-md-8">
          <input id="paramName" type="text" class="form-control" name="status_name" value="{$data.status_name}"
            autofocus required>
        </div>
      </div>
      <div class="form-group">
        <label for="paramExchange" class="control-label col-md-4">
          {t}Libellé en anglais, utilisé pour les échanges d'informations :{/t}
        </label>
        <div class="col-md-8">
          <input id="paramExchange" type="text" class="form-control" name="status_exchange"
            value="{$data.status_exchange}">
        </div>
      </div>
      <div class="form-group center">
        <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      </div>
    {$csrf}</form>
  </div>
</div>
<span class="red">*</span><span class="messagebas">{t}Donnée obligatoire{/t}</span>