<h2>Liste des environmentx détaillés</h2>
{if $droits.param == 1}
<a href="index.php?module=environmentDetailChange&environment_detail_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="environmentDetailListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=environmentDetailChange&environment_detail_id={$data[lst].environment_detail_id}">
		{$data[lst].environment_detail_name}</a>
		{else}{$data[lst].environment_detail_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
