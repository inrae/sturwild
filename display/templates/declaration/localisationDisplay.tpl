<div class="col-sm-12 col-md-6">
{if $droits.gestion ==1}
<a href="index.php?module=localisationChange&declaration_id={$data.declaration_id}">
<img src="display/images/edit.gif" height="20">Modifier...
</a>
{/if}
<div class="form-display">
<dl class="dl-horizontal">
	<dt>Pays :</dt>
	<dd>{$localisation.pays_libelle}
	</dd>
	</dl>
<dl class="dl-horizontal">
	<dt>Zone CIEM :</dt>
	<dd>{$localisation.ciem_libelle}</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Région :</dt>
	<dd>{$localisation.region_libelle}</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Milieu :</dt>
	<dd>{$localisation.milieu_libelle}</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Milieu détaillé :</dt>
	<dd>{$localisation.milieu_detail_libelle}</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Détail de la zone :</dt>
	<dd><span class="textareaDisplay">{$localisation.zone_detail}</span></dd>
</dl>
<dl class="dl-horizontal">
	<dt>Valeurs GPS :</dt>
	<dd>{$localisation.longitude_gps}
	<br>{$localisation.latitude_gps}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Coordonnées<br>déclarées :</dt>
	<dd>{$localisation.longitude_declaree_dd}
	<br>{$localisation.latitude_declaree_dd}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Coordonnées<br>estimées :</dt>
	<dd>{$localisation.longitude_estimee_dd}
	<br>{$localisation.latitude_estimee_dd}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Coordonnées<br>retenues :</dt>
	<dd>{$localisation.longitude_dd}
	<br>{$localisation.latitude_dd}
	</dd>
</dl>
<dl class="dl-horizontal">
	<dt>Précision de la localisation, si estimée lors de la saisie :</dt>
	<dd>{$localisation.precision_name}</dd>
</dl>
</div>
</div>
<div class="col-sm-12 col-md-6">
<div id="map"  style="height:400px;"></div>
{if strlen($localisation.longitude_dd) > 0 && strlen($localisation.latitude_dd) > 0 && $MAPS_enabled == 1}
</div>
<script>

var imageStyle = new ol.style.Style({
		image: new ol.style.Circle({
  			radius: 5,
  			snapToPixel: false,
  			fill: new ol.style.Fill({
  			color: [255 , 0 , 0 , 0.2]
  		}),
  		stroke: new ol.style.Stroke({
 	 		color: [255 , 0 , 0 , 1],
  			width: 1
  		})
	})
});
//console.log("imageStyle", imageStyle);

 var coordonnee = [{$localisation.longitude_dd}, {$localisation.latitude_dd}];
// console.log("coordonnees : ", coordonnee);
 var zoom = 9;
var attribution = new ol.control.Attribution({
  collapsible: false
});
var mousePosition = new ol.control.MousePosition( {
    coordinateFormat: ol.coordinate.createStringXY(2),
    projection: 'EPSG:4326',
    target: undefined,
    undefinedHTML: '&nbsp;'
});
var map = new ol.Map({
  controls: ol.control.defaults({ attribution: false }).extend([attribution]),
  target: 'map',
  view: new ol.View({
  	center: ol.proj.fromLonLat(coordonnee),
    zoom: zoom
  })
});
map.addControl(mousePosition);

var layer = new ol.layer.Tile({
  source: new ol.source.OSM()
});
map.addLayer(layer);

function transform_geometry(element) {
  var current_projection = new ol.proj.Projection({ code: "EPSG:4326" });
  var new_projection = layer.getSource().getProjection();

  element.getGeometry().transform(current_projection, new_projection);
}

var point = new ol.geom.Point(coordonnee, 'XY');
var point_feature = new ol.Feature ( point );
point_feature.setStyle(imageStyle);

var features = [ point_feature];

//console.log("features : ", features);

features.forEach(transform_geometry);

var layer_point = new ol.layer.Vector({
  source: new ol.source.Vector( {
    features: features
  })
});
//console.log("layer_point : ", layer_point);
map.addLayer(layer_point);


</script>
{/if}
