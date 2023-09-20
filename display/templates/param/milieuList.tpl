<h2>{t}Liste des milieux{/t}</h2>
{if $droits.param == 1}
<a href="index.php?module=environmentChange&environment_id=0"><img src="display/images/new.png" height="20">
Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="environmentListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>{t}Libellé{/t}</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=environmentChange&environment_id={$data[lst].environment_id}">
		{$data[lst].environment_name}</a>
		{else}{$data[lst].environment_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
