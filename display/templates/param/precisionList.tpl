<h2>{t}Liste des précisions des locations estimées{/t}</h2>
{if $droits.param == 1}
<a href="index.php?module=accuracyChange&accuracy_id=0">
  <img src="display/images/new.png" height="20">Nouveau</a>
{/if}

<div class="row">
  <div class="col-sm-6">
    <table id="accuracyListe" class="table datatable table-bordered table-hover">
      <thead>
        <tr>
         <th>{t}Id{/t}</th>
         <th>{t}Libellé{/t}</th>
        </tr>
      </thead>
      <tbody>
        {section name=lst loop=$data}
        <tr>
          <td class="center">{$data[lst].accuracy_id}</td>
          <td>
            {if $droits.param == 1}
            <a href="index.php?module=accuracyChange&accuracy_id={$data[lst].accuracy_id}">
              {$data[lst].accuracy_name}</a>
            {else}{$data[lst].accuracy_name}
            {/if}
          </td>
        </tr>
        {/section}
      </tbody>
    </table>
  </div>
</div>
