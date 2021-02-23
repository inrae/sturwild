<h2>Liste des pays</h2>
{if $droits.param == 1}
<a href="index.php?module=paysChange&pays_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="paysListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
			<th>Ordre de tri</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>{if $droits.param == 1}
		<a href="index.php?module=paysChange&pays_id={$data[lst].pays_id}">
		{$data[lst].pays_libelle}</a>
		{else}{$data[lst].pays_libelle}
		{/if}</td>
		<td>{$data[lst].pays_order}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
