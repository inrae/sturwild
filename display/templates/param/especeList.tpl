<h2>Liste des espèces d'esturgeon</h2>
{if $droits.param == 1}
<a href="index.php?module=speciesChange&species_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="speciesListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=speciesChange&species_id={$data[lst].species_id}">
		{$data[lst].species_name}</a>
		{else}{$data[lst].species_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
