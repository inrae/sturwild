<h2>Liste des milieux détaillés</h2>
{if $droits.param == 1}
<a href="index.php?module=milieuDetailChange&milieu_detail_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}

<table id="milieuDetailListe"  class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=milieuDetailChange&milieu_detail_id={$data[lst].milieu_detail_id}">
		{$data[lst].milieu_detail_libelle}</a>
		{else}{$data[lst].milieu_detail_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
