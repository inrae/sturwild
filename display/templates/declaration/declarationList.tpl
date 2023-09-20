{include file="declaration/declarationSearch.tpl"}
{if $isSearch == 1}
<div class="col-md-12">
{if $droits["gestion"] == 1}
<a href=index.php?module=declarationChange&declaration_id=0>
<img src="display/images/new.png" height="25">
<b>Nouvelle déclaration...</b>
</a>
{/if}
{if count($data) > 0}
<br>
<a href="index.php?module=declarationExport">
<img src="display/images/csv_text.png" height="25">
Exporter la liste au format CSV</a>
&nbsp;
<a href="index.php?module=fishExport"><img src="display/images/csv_text.png" height="25">Exporter les poissons correspondants au format CSV</a>
{/if}
<table  id="declarationList" data-order='[[0,"desc"]]' class="table table-bordered table-hover datatable " >
<thead>
<tr>
<th>N°</th>
<th>Espèce</th>
<th>État à<br>la capture</th>
<th>Année</th>
<th>Date de<br>capture</th>
<th>Localisation</th>
<th>Nbre de<br>poissons</th>
<th title="Nombre total de documents associés, photos, vidéo, etc.">Nbre de<br>photos</th>
<th>Engin de pêche</th>
<th>Code du<br>pécheur</th>
<th>Interlocuteur</th>
<th>Statut</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td class="center">
<a href="index.php?module=declarationDisplay&declaration_id={$data[lst].declaration_id}">
<!--  img src="display/images/detail.png" height="20"-->
{$data[lst].declaration_id}
</a>
</td>
 <td>{$data[lst].species_name}</td>
 <td>{$data[lst].capture_state_name}</td>
<td>{$data[lst].year}</td>
<td>
{if strlen($data[lst].capture_date) > 0}
{$data[lst].capture_date}
{else}
{$data[lst].estimated_capture_date}
{/if}
</td>
<td>
{$data[lst].country_name}
{if !empty($data[lst].ices_name)}
 {$data[lst].ices_name}
{/if}
{if !empty($data[lst].environment_name) }
 {$data[lst].environment_name}
{/if}
{if !empty($data[lst].environment_detail_name)}
 {$data[lst].environment_detail_name}
{/if}
 </td>
 <td class="center">{$data[lst].caught_number}</td>
 <td class="center">
 {if $data[lst].document_nb > 0}{$data[lst].document_nb}{/if}
 </td>
 <td>{$data[lst].gear_type_name}</td>
 <td>{$data[lst].fisher_code}</td>
 <td>{$data[lst].contact}</td>
 <td>{$data[lst].status_name}</td>
</tr>
{/section}
</tbody>
</table>
</div>
{/if}
