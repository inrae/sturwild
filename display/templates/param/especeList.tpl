<h2>Liste des espèces d'esturgeon</h2>
{if $droits.param == 1}
<a href="index.php?module=especeChange&espece_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="especeListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=especeChange&espece_id={$data[lst].espece_id}">
		{$data[lst].espece_libelle}</a>
		{else}{$data[lst].espece_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
