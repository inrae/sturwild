<h2>Liste des types d'événement</h2>
{if $droits.param == 1}
<a href="index.php?module=evenementTypeChange&evenement_type_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="evenementTypeListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>id</th>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td class="center">{$data[lst].evenement_type_id}</td>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=evenementTypeChange&evenement_type_id={$data[lst].evenement_type_id}">
		{$data[lst].evenement_type_libelle}</a>
		{else}{$data[lst].evenement_type_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
