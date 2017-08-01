<h2>Liste des zones CIEM</h2>
{if $droits.param == 1}
<a href="index.php?module=ciemChange&ciem_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<script>
	setDataTablesFull("ciemListe");
</script>
<table id="ciemListe" class="tableaffichage">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=ciemChange&ciem_id={$data[lst].ciem_id}">
		{$data[lst].ciem_libelle}</a>
		{else}{$data[lst].ciem_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
