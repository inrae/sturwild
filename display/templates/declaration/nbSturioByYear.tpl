<script>setDataTablesFull("nbSturioList")</script>
<h2>Nombre d'esturgeons d'Europe capturés par année</h2>
<table class="tableliste" id="nbSturioList">
<thead>
<tr><th>Année</th><th>Nbre</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr><td>{$data[lst].annee}</td>
<td class="right">{$data[lst].nombre_capture}</td>
</tr>
{/section}
</tbody>
</table>
