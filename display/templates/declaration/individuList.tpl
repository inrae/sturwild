{if $droits["gestion"] == 1}
<a href=index.php?module=individuChange&individu_id=0&declaration_id={$data.declaration_id}>Nouvel esturgeon...</a>
{/if}
<table class="tableliste" id="individuList">
<thead>
<tr>
<th class="center"><img src="display/images/edit.gif" height="20"></th>
<th>Espèce</th>
<th>Longueur (mm)<br>Masse (kg)</th>
<th>Marque</th>
<th>Cohorte estimée<br>validée</th>
<th>État</th>
<th>Manipulation</th>
<th>Devenir</th>
<th>Historique</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$individus}
<tr>
<td class="center">
{if $droits["gestion"] == 1}
<a href="index.php?module=individuChange&individu_id={$individus[lst].individu_id}" title="Modifier">
<img src="display/images/edit.gif" height="20">
{$individus[lst].individu_id}
</a>
{else}
{$individus[lst].individu_id}
{/if}
</td>

<td>{$individus[lst].espece_libelle}
{if $individus[lst].qualite_identification == 1}
&nbsp;(Sûr){else}
<br>(incertain)
{/if}
 </td>
  <td>{$individus[lst].longueur_individu}
 {if $individus[lst].masse <> ""}
 <br>{$individus[lst].masse}
 {/if}
 </td>
 <td>{$individus[lst].presence_marque_libelle}
  {if $individus[lst].numero_marque <> ""}
 <br>{$individus[lst].numero_marque}
 {/if}
 </td>
 <td class="center">{$individus[lst].cohorte_estimee}
  {if $individus[lst].cohorte_validee <> ""}
 <br>{$individus[lst].cohorte_validee}
 {/if}
 </td>
 <td>{$individus[lst].capture_etat_libelle}</td>
<td>{$individus[lst].manipulation}</td>
<td>{$individus[lst].devenir_libelle}</td>
<td>{$individus[lst].historique}</td>
<td><span class="textareaDisplay">{$individus[lst].commentaire}</span></td>

</tr>
{/section}
</tbody>
</table>