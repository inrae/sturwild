<h2>Liste des types de capture</h2>
{if $droits.param == 1}
<a href="index.php?module=captureTypeChange&capture_type_id=0">
<img src="display/images/new.png" height="20">Nouveau</a>
{/if}
<script>
	setDataTablesFull("captureTypeListe");
</script>
<table id="captureTypeListe"  class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>Libellé</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}
		<a href="index.php?module=captureTypeChange&capture_type_id={$data[lst].capture_type_id}">
		{$data[lst].capture_type_libelle}</a>
		{else}{$data[lst].capture_type_libelle}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>