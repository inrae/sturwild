<h2>{t}Liste des destinations des esturgeons capturés{/t}</h2>
{if $droits.param == 1}
<a href="index.php?module=fateChange&fate_id=0"><img src="display/images/new.png" height="20">
Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="fateListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>{t}Libellé{/t}</th>
		</tr>
	</thead>
	<tbody>
	{section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=fateChange&fate_id={$data[lst].fate_id}">
		{$data[lst].fate_name}</a>
		{else}{$data[lst].fate_name}
		{/if}</td>
	</tr>
	{/section}
	</tbody>
</table>
</div>
</div>
