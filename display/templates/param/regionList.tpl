<h2>Liste des régions</h2>
{if $droits.param == 1}
<a href="index.php?module=regionChange&region_id=0">
<img src="display/images/new.png" height="20">
Nouveau</a>
{/if}
<table id="regionListe"  class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=regionChange&region_id={$data[lst].region_id}">
		{$data[lst].region_libelle}</a>
		{else}{$data[lst].region_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
