{include file="declaration/declarationSearch.tpl"}
{if $isSearch == 1}
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
<a href="index.php?module=individuExport"><img src="display/images/csv_text.png" height="25">Exporter les poissons correspondants au format CSV</a>
{/if}
<table  id="declarationList"class="table table-bordered table-hover datatable " >
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
 <td>{$data[lst].espece_libelle}</td>
 <td>{$data[lst].capture_etat_libelle}</td>
<td>{$data[lst].annee}</td>
<td>
{if strlen($data[lst].capture_date) > 0}
{$data[lst].capture_date}
{else}
{$data[lst].capture_date_estimee}
{/if}
</td>
<td>
{$data[lst].pays_libelle}
{if (strlen($data[lst].ciem_libelle) > 0)}
 {$data[lst].ciem_libelle}
{/if}
{if (strlen($data[lst].region_libelle) > 0)}
 {$data[lst].region_libelle}
{/if}
{if (strlen($data[lst].milieu_libelle) > 0)}
 {$data[lst].milieu_libelle}
{/if}
{if (strlen($data[lst].milieu_detail_libelle) > 0)}
 {$data[lst].milieu_detail_libelle}
{/if}
 </td>
 <td class="center">{$data[lst].nombre_capture}</td>
 <td class="center">
 {if $data[lst].document_nb > 0}{$data[lst].document_nb}{/if}
 </td>
 <td>{$data[lst].engin_type_libelle}</td>
 <td>{$data[lst].pecheur_code}</td>
 <td>{$data[lst].interlocuteur}</td>
 <td>{$data[lst].statut_libelle}</td>
</tr>
{/section}
</tbody>
</table>
<br>
{/if}