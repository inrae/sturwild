<h2>Nombre d'esturgeons capturés par année</h2>
<div class="col-sm-6">
<table  class="table datatable-export table-bordered table-hover" id="nbSturioList">
<thead>
<tr><th class="center">{t}Année{/t}</th>
    <th>{t}Espèce{/t}</th>
<th class="center">{t}Nbre{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
    <td class="center">{$data[lst].annee}</td>
    <td>{$data[lst].espece_libelle}</td>
    <td class="center">{$data[lst].nombre_capture}</td>
</tr>
{/section}
</tbody>
</table>
</div>