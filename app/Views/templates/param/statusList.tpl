<h2>{t}Liste des statuts des déclarations{/t}</h2>

<div class="row">
	<div class="col-md-6">
		<table id="paramList" class="table table-bordered table-hover datatable ">
			<thead>
				<tr>
					<th>{t}Id{/t}</th>
					<th>{t}Libellé{/t}</th>
					<th>{t}Libellé en anglais, pour les échanges{/t}</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data as $row}
				<tr>
					<td class="center">{$row.status_id}</td>
					<td>
						{if $rights.param == 1 && $readOnly == 0}
						<a href="statusChange?status_id={$row.status_id}">
							{$row.status_name}
						</a>
						{else}
						{$row.status_name}
						{/if}
					</td>
					<td>{$row.status_exchange}</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>
