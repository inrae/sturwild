<h2>{t}Liste des modes de capture{/t}</h2>
{if $droits.param == 1}
<a href="index.php?module=captureModeChange&capture_method_id=0">
<img src="display/images/new.png" height="20">{t}Nouveau{/t}</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table id="captureModeListe"  class="table table-bordered datatable table-hover">
	<thead>
		<tr>
			<th>{t}Libellé{/t}</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}<a href="index.php?module=captureModeChange&capture_method_id={$data[lst].capture_method_id}">
		{$data[lst].capture_method_name}</a>
		{else}{$data[lst].capture_method_name}
		{/if}</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
