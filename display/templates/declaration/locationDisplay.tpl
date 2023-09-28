<div class="col-sm-12 col-md-6">
{if $droits.gestion ==1}
<a href="index.php?module=locationChange&declaration_id={$data.declaration_id}">
<img src="display/images/edit.gif" height="20">{t}Modifier...{/t}</a>
{/if}
<div class="form-display">
<dl class="dl-horizontal">
	<dt>{t}Pays :{/t}</dt>
	<dd>{$location.country_name}
	</dd>
	</dl>
<dl class="dl-horizontal">
	<dt>{t}Zone CIEM :{/t}</dt>
	<dd>{$location.ices_name}</dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Milieu :{/t}</dt>
	<dd>{$location.environment_name}</dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Milieu détaillé :{/t}</dt>
	<dd>{$location.environment_detail_name}</dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Détail de la zone :{/t}</dt>
	<dd><span class="textareaDisplay">{$location.area_detail}</span></dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Valeurs GPS :{/t}</dt>
	<dd>{$location.longitude_gps}
	 {$location.latitude_gps}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Coordonnées déclarées :{/t}</dt>
	<dd>{$location.longitude_declared_dd}
	 {$location.latitude_declared_dd}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Coordonnées estimées :{/t}</dt>
	<dd>{$location.longitude_estimated_dd}
	 {$location.latitude_estimated_dd}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Coordonnées retenues :{/t}</dt>
	<dd>{$location.longitude_dd}
	 {$location.latitude_dd}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>{t}Précision de la localisation, si estimée lors de la saisie :{/t}</dt>
	<dd>{$location.accuracy_name}</dd>
</dl>
</div>
</div>
<div class="col-sm-12 col-md-6">
<div id="map" class="map" style="height:600px;"></div>
</div>
{if !empty($location.longitude_dd) && !empty($location.latitude_dd)  && $MAPS_enabled == 1}
{include file="declaration/locationMap.tpl"}
{/if}