<h2>{t}Liste des paramètres :{/t}&nbsp;{$tabledescription}</h2>
<div class="row">
	<div class="col-md-6">
		{if $droits.param == 1 && $readOnly == 0}
		<a href="index.php?module={$tablename}Change&{$tablename}_id=0">
			<img src="display/images/new.png" height="25">
			{t}Nouveau...{/t}
		</a>
		{/if}
		<table id="paramList" class="table table-bordered table-hover datatable " data-order = '[[3,"asc"],[1,"asc"]]'>
			<thead>
				<tr>
					<th>{t}Id{/t}</th>
					<th>{t}Libellé{/t}</th>
					<th>{t}Libellé en anglais, pour les échanges{/t}</th>
					<th>{t}Ordre d'affichage{/t}</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data as $row}
				<tr>
					<td class="center">{$row[$fieldid]}</td>
					<td>
						{if $droits.param == 1 && $readOnly == 0}
						<a href="index.php?module={$tablename}Change&{$tablename}_id={$row[$fieldid]}">
							{$row[$fieldname]}
						</a>
						{else}
						{$row[$fieldname]}
						{/if}
					</td>
					<td>{$row[$fieldexchange]}</td>
					<td class="center">{$row[$fieldorder]}</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>
