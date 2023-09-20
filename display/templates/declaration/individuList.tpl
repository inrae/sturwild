{if $droits["gestion"] == 1}
<a href=index.php?module=fishChange&fish_id=0&declaration_id={$data.declaration_id}>Nouvel esturgeon...</a>
{/if}
<table class="table table-bordered table-hover" id="fishList">
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
{section name=lst loop=$fishs}
<tr>
<td class="center">
{if $droits["gestion"] == 1}
<a href="index.php?module=fishChange&fish_id={$fishs[lst].fish_id}" title="Modifier">
<img src="display/images/edit.gif" height="20">
{$fishs[lst].fish_id}
</a>
{else}
{$fishs[lst].fish_id}
{/if}
</td>

<td>{$fishs[lst].species_name}
{if $fishs[lst].identification_quality == 1}
&nbsp;(Sûr){else}
<br>(incertain)
{/if}
 </td>
  <td>{$fishs[lst].fish_length}
 {if $fishs[lst].weight <> ""}
 <br>{$fishs[lst].weight}
 {/if}
 </td>
 <td>{$fishs[lst].tag_presence_name}
  {if $fishs[lst].tag_number <> ""}
 <br>{$fishs[lst].tag_number}
 {/if}
 </td>
 <td class="center">{$fishs[lst].estimated_cohort}
  {if $fishs[lst].validated_cohort <> ""}
 <br>{$fishs[lst].validated_cohort}
 {/if}
 </td>
 <td>{$fishs[lst].capture_state_name}</td>
<td>{$fishs[lst].handling}</td>
<td>{$fishs[lst].fate_name}</td>
<td>{$fishs[lst].background}</td>
<td><span class="textareaDisplay">{$fishs[lst].remarks}</span></td>

</tr>
{/section}
</tbody>
</table>