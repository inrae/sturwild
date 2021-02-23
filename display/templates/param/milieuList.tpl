<h2>Liste des milieux</h2>
{if $droits.param == 1}
<a href="index.php?module=milieuChange&milieu_id=0"><img src="display/images/new.png" height="20">
Nouveau</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="milieuListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=milieuChange&milieu_id={$data[lst].milieu_id}">
		{$data[lst].milieu_libelle}</a>
		{else}{$data[lst].milieu_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
