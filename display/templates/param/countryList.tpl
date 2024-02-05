<h2>{t}Liste des pays{/t}</h2>
{if $droits.param == 1}
<a href="index.php?module=countryChange&country_id=0">
<img src="display/images/new.png" height="20">{t}Nouveau{/t}</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="countryListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>{t}Libellé{/t}</th>
			<th>{t}Ordre de tri{/t}</th>
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
