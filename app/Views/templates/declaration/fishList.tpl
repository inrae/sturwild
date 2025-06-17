{if $rights["manage"] == 1 && $editGranted == 1}
<a href=fishChange?fish_id=0&declaration_id={$data.declaration_id}>{t}Nouvel esturgeon...{/t}</a>
{/if}
<table class="table table-bordered table-hover" id="fishList">
<thead>
<tr>
<th class="center"><img src="display/images/edit.gif" height="20"></th>
<th>{t}Espèce{/t}</th>
<th>{t}Longueur (mm) Masse (kg){/t}</th>
<th>{t}Marque{/t}</th>
<th>{t}Cohorte estimée validée{/t}</th>
<th>{t}État{/t}</th>
<th>{t}Manipulations{/t}</th>
<th>{t}Devenir{/t}</th>
<th>{t}Historique{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$fishs}
<tr>
<td class="center">
{if $rights["manage"] == 1 && $editGranted == 1}
<a href="fishChange?fish_id={$fishs[lst].fish_id}&declaration_id={$data.declaration_id}" title="{t}Modifier{/t}">
<img src="display/images/edit.gif" height="20">
{$fishs[lst].fish_id}
</a>
{else}
{$fishs[lst].fish_id}
{/if}
</td>

<td>{$fishs[lst].species_name}
{if $fishs[lst].identification_quality == 1}
&nbsp;{t}(Sûr){/t}{else}
 {t}(incertain){/t}
{/if}
 </td>
  <td>{$fishs[lst].fish_length}
 {if $fishs[lst].weight <> ""}
  {$fishs[lst].weight}
 {/if}
 </td>
 <td>{$fishs[lst].tag_presence_name}
  {if $fishs[lst].tag_number <> ""}
  {$fishs[lst].tag_number}
 {/if}
 </td>
 <td class="center">{$fishs[lst].estimated_cohort}
  {if $fishs[lst].validated_cohort <> ""}
  {$fishs[lst].validated_cohort}
 {/if}
 </td>
 <td>{$fishs[lst].capture_state_name}</td>
<td>
    {$fishs[lst].handlings_name}
    {if !empty($fishs[lst].handling)&& !empty($fishs[lst].handlings_name)}
    <br>
    {/if}
    {$fishs[lst].handling}
</td>
<td>{$fishs[lst].fate_name}</td>
<td>{$fishs[lst].background}</td>
<td><span class="textareaDisplay">{$fishs[lst].remarks}</span></td>

</tr>
{/section}
</tbody>
</table>