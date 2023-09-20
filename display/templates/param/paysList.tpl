<h2>Liste des country</h2>
{if $droits.param == 1}
<a href="index.php?module=countryChange&country_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="countryListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
			<th>Ordre de tri</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>{if $droits.param == 1}
		<a href="index.php?module=countryChange&country_id={$data[lst].country_id}">
		{$data[lst].country_name}</a>
		{else}{$data[lst].country_name}
		{/if}</td>
		<td>{$data[lst].country_order}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
