<h2>Liste des états à la capture</h2>
{if $droits.param == 1}
<a href="index.php?module=captureEtatChange&capture_etat_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<script>
	setDataTablesFull("captureEtatListe");
</script>
<table id="captureEtatListe" class="tableaffichage">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}<a href="index.php?module=captureEtatChange&capture_etat_id={$data[lst].capture_etat_id}">
		{$data[lst].capture_etat_libelle}</a>
		{else}{$data[lst].capture_etat_libelle}{/if}
		</td>
	</tr>
	{/section} </tbody>
</table>