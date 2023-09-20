<h2>Liste des types de capture</h2>
{if $droits.param == 1}
<a href="index.php?module=captureTypeChange&origin_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="captureTypeListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=captureTypeChange&origin_id={$data[lst].origin_id}">
		{$data[lst].origin_name}</a>
		{else}{$data[lst].origin_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
