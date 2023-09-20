{if $droits["gestion"] == 1}
<a href=index.php?module=eventChange&event_id=0&declaration_id={$data.declaration_id}>Nouvel événement...</a>
{/if}
<table class="table table-bordered table-hover">
<thead>
<tr>
{if $droits["gestion"] == 1}
<th>{t}Modifier{/t}</th>
{/if}
<th>{t}Type{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Commentaire{/t}</th>
{if $droits["gestion"] == 1}
<th>{t}Utilisateur{/t}</th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$events}
<tr>
{if $droits["gestion"] == 1}
<td class="center">
<a href="index.php?module=eventChange&event_id={$events[lst].event_id}">
<img src="display/images/edit.gif" height="20">
</a>
</td>
{/if}
<td>{$events[lst].event_type_name}</td>
<td>{$events[lst].event_date}</td>
<td>{$events[lst].event_remarks}</td>
{if $droits["gestion"] == 1}
<td>{$events[lst].utilisateur}</td>
{/if}
</tr>
{/section}
</tbody>
</table>
