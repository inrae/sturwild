<h2>Liste des milieux</h2>
{if $droits.param == 1}
<a href="index.php?module=milieuChange&milieu_id=0"><img src="display/images/new.png" height="20">
Nouveau</a>
{/if}
<script>
	setDataTablesFull("milieuListe");
</script>
<table id="milieuListe" class="tableaffichage">
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
