<h2>Liste des destinations des esturgeons capturés</h2>
{if $droits.param == 1}
<a href="index.php?module=devenirChange&devenir_id=0"><img src="display/images/new.png" height="20">
Nouveau</a>
{/if}
<script>
	setDataTablesFull("devenirListe");
</script>
<table id="devenirListe"  class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> 
	{section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=devenirChange&devenir_id={$data[lst].devenir_id}">
		{$data[lst].devenir_libelle}</a>
		{else}{$data[lst].devenir_libelle}
		{/if}</td>
	</tr>
	{/section} 
	</tbody>
</table>