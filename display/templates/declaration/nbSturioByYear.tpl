<h2>Nombre d'esturgeons d'Europe capturés par année</h2>
<div class="col-sm-6">
<table  class="table table-bordered table-hover" id="nbSturioList">
<thead>
<tr><th class="center">Année</th>
<th class="center">Nbre</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr><td class="center">{$data[lst].annee}</td>
<td class="center">{$data[lst].nombre_capture}</td>
</tr>
{/section}
</tbody>
</table>
</div>