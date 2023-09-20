<h2>{t}Liste des états à la capture{/t}</h2>
{if $droits.param == 1}
<a href="index.php?module=captureEtatChange&capture_state_id=0">
<img src="display/images/new.png" height="20">{t}Nouveau{/t}</a>
{/if}
<div class="row">
<div class="col-sm-6">
<table class="table table-bordered table-hover datatable" id="captureEtatListe" >
	<thead>
		<tr>
			<th>{t}Libellé{/t}</th>
		</tr>
	</thead>
	<tbody> {section name=lst loop=$data}
	<tr>
		<td>
		{if $droits.param == 1}<a href="index.php?module=captureEtatChange&capture_state_id={$data[lst].capture_state_id}">
		{$data[lst].capture_state_name}</a>
		{else}{$data[lst].capture_state_name}{/if}
		</td>
	</tr>
	{/section} </tbody>
</table>
</div>
</div>
