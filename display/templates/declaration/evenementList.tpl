{if $droits["gestion"] == 1}
<a href=index.php?module=evenementChange&evenement_id=0&declaration_id={$data.declaration_id}>Nouvel événement...</a>
{/if}
<table class="tableliste">
<thead>
<tr>
{if $droits["gestion"] == 1}
<th>Modifier</th>
{/if}
<th>Type</th>
<th>Date</th>
<th>Commentaire</th>
{if $droits["gestion"] == 1}
<th>Utilisateur</th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$evenements}
<tr>
{if $droits["gestion"] == 1}
<td class="center">
<a href="index.php?module=evenementChange&evenement_id={$evenements[lst].evenement_id}">
<img src="display/images/edit.gif" height="20">
</a>
</td>
{/if}
<td>{$evenements[lst].evenement_type_libelle}</td>
<td>{$evenements[lst].evenement_date}</td>
<td>{$evenements[lst].evenement_commentaire}</td>
{if $droits["gestion"] == 1}
<td>{$evenements[lst].utilisateur}</td>
{/if}
</tr>
{/section}
</tbody>
</table>
