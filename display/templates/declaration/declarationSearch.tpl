<div>
	<fieldset>
		<legend>{t}Critères de recherche des déclarations{/t}</legend>
		<form class="form-horizontal col-lg-10 col-md-12" method="GET" action="index.php" id="search">
			<input type="hidden" name="module" value="declarationList">
			<input type="hidden" name="isSearch" value="1">
			<div class="form-group">
				<label for="" class="col-sm-2 control-label">{t}Texte à rechercher :{/t}</label>
				<div class="col-sm-4">
					<input class="remarks form-control" id="libelle" name="libelle" value="{$dataSearch.libelle}"
						placeholder="{t}N° déclaration, code pêcheur ou contact{/t}"
						title="{t}Recherche à partir du N° de la déclaration, du code du pêcheur ou du nom du contact{/t}">
				</div>
				<label for="status_id" class="col-sm-1 control-label">{t}Statut :{/t}</label>
				<div class="col-sm-2">
					<select class="form-control"  id="status_id" name="status_id">
						<option value="" {if $dataSearch.status_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
						{section name=lst loop=$status}
						<option value={$status[lst].status_id} {if
							$dataSearch.status_id==$status[lst].status_id}selected{/if}>
							{$status[lst].status_name}
						</option>
						{/section}
					</select>
				</div>
				<label for="institute_id" class="col-sm-1 control-label">{t}Institut :{/t}</label>
				<div class="col-sm-2">
					<select class="form-control"  id="institute_id" name="institute_id">
						<option value="" {if $dataSearch.institute_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
						{section name=lst loop=$institute}
						<option value={$institute[lst].institute_id} {if
							$dataSearch.institute_id==$institute[lst].institute_id}selected{/if}>
							{$institute[lst].institute_code}
						</option>
						{/section}
					</select>
				</div>
			</div>

			<div class="form-group">
				<label for="species_id" class="col-sm-2 control-label">{t}Espèce :{/t}</label>
				<div class="col-sm-4">
					<select class="form-control" name="species_id" id="species_id">
						<option value="" {if $dataSearch.species_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
						{section name=lst loop=$species}
						<option value={$species[lst].species_id} {if
							$dataSearch.species_id==$species[lst].species_id}selected{/if}>
							{$species[lst].species_name}
						</option>
						{/section}
					</select>
				</div>
				<label for="capture_state_id" class="col-sm-4 control-label">{t}État à la capture :{/t}</label>
				<div class="col-sm-2">
					<select class="form-control" name="capture_state_id" id="capture_state_id">
						<option value="" {if $dataSearch.capture_state_id=="" }selected{/if}>{t}Sélectionnez...{/t}
						</option>
						{section name=lst loop=$capture_state}
						<option value={$capture_state[lst].capture_state_id} {if
							$dataSearch.capture_state_id==$capture_state[lst].capture_state_id}selected{/if}>
							{$capture_state[lst].capture_state_name}
						</option>
						{/section}
					</select>
				</div>
			</div>

			<div class="form-group">
				<label for="country_id" class="col-sm-1 control-label">{t}Pays :{/t}</label>
				<div class="col-sm-2">
					<select class="form-control" id="country_id" name="country_id">
						<option value="" {if $dataSearch.country_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
						{section name=lst loop=$country}
						<option value={$country[lst].country_id} {if
							$dataSearch.country_id==$country[lst].country_id}selected{/if}>
							{$country[lst].country_name}
						</option>
						{/section}
					</select>
				</div>
				<label for="ices_id" class="col-sm-2 control-label">{t}Zone CIEM :{/t}</label>
				<div class="col-sm-1">
					<select class="form-control" id="ices_id" name="ices_id">
						<option value="" {if $dataSearch.ices_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
						{section name=lst loop=$ices}
						<option value={$ices[lst].ices_id} {if $dataSearch.ices_id==$ices[lst].ices_id}selected{/if}>
							{$ices[lst].ices_name}
						</option>
						{/section}
					</select>
				</div>
				<label for="gear_type_id" class="col-sm-4 control-label">{t}Engin de pêche :{/t}</label>
				<div class="col-sm-2">
					<select class="form-control " id="gear_type_id" name="gear_type_id">
						<option value="" {if $dataSearch.gear_type_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
						{section name=lst loop=$gear_type}
						<option value={$gear_type[lst].gear_type_id} {if
							$dataSearch.gear_type_id==$gear_type[lst].gear_type_id}selected{/if}>
							{$gear_type[lst].gear_type_name}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="environment_id" class="col-sm-1 control-label">{t}Milieu :{/t}</label>
				<div class="col-sm-2">
					<select class="form-control" id="environment_id" name="environment_id">
						<option value="" {if $dataSearch.environment_id=="" }selected{/if}>{t}Sélectionnez...{/t}
						</option>
						{section name=lst loop=$environment}
						<option value={$environment[lst].environment_id} {if
							$dataSearch.environment_id==$environment[lst].environment_id}selected{/if}>
							{$environment[lst].environment_name}
						</option>
						{/section}
					</select>
				</div>
				<label for="year_debut" class="col-sm-2 control-label">{t}Année de la déclaration : de{/t}</label>
				<div class="col-sm-1">
					<select class="form-control" id="year_debut" name="year_debut">
						{foreach from=$years item=year}
						<option value="{$year}" {if $year==$dataSearch.year_debut}selected{/if}>
							{$year}
						</option>
						{/foreach}
					</select>
				</div>
				<label for="year_fin" class="col-sm-1 control-label">{t}à{/t} </label>
				<div class="col-sm-1">
					<select class="form-control" id="year_fin" name="year_fin">
						{foreach from=$years item=year}
						<option value="{$year}" {if $year==$dataSearch.year_fin}selected{/if}>
							{$year}
						</option>
						{/foreach}
					</select>
				</div>
			</div>
				<div class="form-group">
					<div class="center">
						<input type="submit" class="btn btn-success" value="{t}Rechercher{/t}"
					autofocus>
					</div>
				</div>
			</div>
		</form>
	</fieldset>
</div>