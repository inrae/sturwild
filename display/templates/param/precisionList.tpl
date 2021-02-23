<h2>Liste des précisions des localisations estimées</h2>
{if $droits.param == 1}
<a href="index.php?module=precisionChange&precision_id=0">
  <img src="display/images/new.png" height="20">Nouveau</a>
{/if}

<div class="row">
  <div class="col-sm-6">
    <table id="precisionListe" class="table datatable table-bordered table-hover">
      <thead>
        <tr>
          <th>Id</th>
          <th>Libellé</th>
        </tr>
      </thead>
      <tbody>
        {section name=lst loop=$data}
        <tr>
          <td class="center">{$data[lst].precision_id}</td>
          <td>
            {if $droits.param == 1}
            <a href="index.php?module=precisionChange&precision_id={$data[lst].precision_id}">
              {$data[lst].precision_name}</a>
            {else}{$data[lst].precision_name}
            {/if}
          </td>
        </tr>
        {/section}
      </tbody>
    </table>
  </div>
</div>
