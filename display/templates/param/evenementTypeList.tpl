<h2>Liste des types d'événement</h2>
{if $droits.param == 1}
<a href="index.php?module=eventTypeChange&event_type_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="eventTypeListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>id</th>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td class="center">{$data[lst].event_type_id}</td>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=eventTypeChange&event_type_id={$data[lst].event_type_id}">
		{$data[lst].event_type_name}</a>
		{else}{$data[lst].event_type_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
