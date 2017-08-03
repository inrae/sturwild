<h2>Liste des modes de capture</h2>
{if $droits.param == 1}
<a href="index.php?module=captureModeChange&capture_mode_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<script>
	setDataTablesFull("captureModeListe");
</script>
<table id="captureModeListe"  class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}<a href="index.php?module=captureModeChange&capture_mode_id={$data[lst].capture_mode_id}">
		{$data[lst].capture_mode_libelle}</a>
		{else}{$data[lst].capture_mode_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>