<h2>{t}Liste des types d'engins de pêche{/t}</h2>
{if $droits.param == 1}
<a href="index.php?module=enginTypeChange&gear_type_id=0">
<img src="display/images/new.png" height="20">{t}Nouveau{/t}</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="enginTypeListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>{t}Libellé{/t}</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=enginTypeChange&gear_type_id={$data[lst].gear_type_id}">
		{$data[lst].gear_type_name}</a>
		{else}{$data[lst].gear_type_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
