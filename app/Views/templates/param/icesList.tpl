<h2>{t}Liste des zones CIEM{/t}</h2>
{if $rights.param == 1}
<a href="icesChange?ices_id=0">
<img src="display/images/new.png" height="20">{t}Nouveau{/t}</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="icesListe"  class="table table-bordered datatable display table-hover">
	<thead>
		<tr>
			<th>{t}Libellé{/t}</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $rights.param == 1}
		<a href="icesChange?ices_id={$data[lst].ices_id}">
		{$data[lst].ices_name}</a>
		{else}{$data[lst].ices_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
