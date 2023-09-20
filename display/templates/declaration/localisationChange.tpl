<script>
function convertGPSSecondeToDD(valeur) {
	var parts = valeur.split(/[^\d]+/);
	var dd = parseFloat(parts[0]) + parseFloat(parseFloat(parts[1])/60) + parseFloat(parseFloat(parts[2])/3600);
	//dd = parseFloat(dd);
	var lastChar = valeur.substr(-1).toUpperCase();
	dd = Math.round(dd * 1000000) / 1000000;
	if (lastChar == "S" || lastChar == "W" || lastChar == "O") {
		dd *= -1;
	};
	return dd;
}

function convertGPSDecimalToDD(valeur) {
	var parts = valeur.split(/[^\d]+/);
	var dd = parseFloat(parts[0])
			+ parseFloat((parts[1] + "." + parts[2]) / 60);
	var lastChar = valeur.substr(-1).toUpperCase();
	dd = Math.round(dd * 1000000) / 1000000;
	if (lastChar == "S" || lastChar == "W" || lastChar == "O") {
		dd *= -1;
	}
	;
	return dd;
}

$(document).ready(function() {
	var hasfocus = "";
	$(":input").focus(function() {
		hasfocus = $(this).attr("name");
	});
	$("#longitude_declared_dd,#longitude_estimated_dd").change(function() {
		var valeur = $(this).val();
		$('#longitude_dd').val( valeur );
		positionChange();

	});
	$("#latitude_declared_dd,#latitude_estimated_dd").change(function() {
		var valeur = $(this).val();
		$('#latitude_dd').val( valeur );
		positionChange();
	});
	$("#longitude_gps").change(function () {
		//alert($("input[name='degreType']:checked").val());
		if ($("input[name='degreType']:checked").val() == 1  ) {
			$('#longitude_declared_dd').val ( convertGPSDecimalToDD($(this).val()));
		} else {
			$('#longitude_declared_dd').val ( convertGPSSecondeToDD($(this).val()));
		}
		if ($('#longitude_declared_dd').val() != "NaN" ) {
			$('#longitude_declared_dd').change();
		};
	});
	$("#latitude_gps").change(function () {
		if ($("input[name='degreType']:checked").val() == 1 ) {
			$('#latitude_declared_dd').val ( convertGPSDecimalToDD($(this).val()));
		} else {
			$('#latitude_declared_dd').val ( convertGPSSecondeToDD($(this).val()));
		}
		if ($('#latitude_declared_dd').val() != "NaN" ) {
			$('#latitude_declared_dd').change();
		};
	});
	$("#longCalc").click( function () {
		$("#longitude_gps").trigger("change");
	});
	$("#latCalc").click( function () {
		$("#latitude_gps").trigger("change");
	});
	$("#location").submit(function (event) {
		$("#"+hasfocus).trigger("change");
	});

});
</script>
<h2>Modification de la location - N° {$data.declaration_id}</h2>
<div class="row">
<div class="col-sm-12">
<a href="index.php?module=declarationList">
	<img src="display/images/list.png" height="25">
	Retour à la liste des déclarations
</a>
<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">
<img src="display/images/display.png" height="25">
Retour au détail de la déclaration  - N° {$data.declaration_id}</a>
</div>
<div class="col-sm-6">
		<div>

			<form  class="form-horizontal protoform" id="location" method="post" action="index.php">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="moduleBase" value="location">
				<input type="hidden" name="action" value="Write">

				<div class="form-group">
					<label for="country_id" class="control-label col-sm-4">
						Pays :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="country_id"  name="country_id" autofocus>
						<option value="" {if $data.country_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$country}
						<option value="{$country[lst].country_id}" {if $country[lst].country_id == $data.country_id}selected{/if}>
						{$country[lst].country_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="ices_id" class="control-label col-sm-4">
						Zone CIEM :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="ices_id"  name="ices_id" >
						<option value="" {if $data.ices_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$ices}
						<option value="{$ices[lst].ices_id}" {if $ices[lst].ices_id == $data.ices_id}selected{/if}>
						{$ices[lst].ices_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="environment_id" class="control-label col-sm-4">
						Milieu :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="environment_id"  name="environment_id" >
						<option value="" {if $data.environment_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$environment}
						<option value="{$environment[lst].environment_id}" {if $environment[lst].environment_id == $data.environment_id}selected{/if}>
						{$environment[lst].environment_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="environment_detail_id" class="control-label col-sm-4">
						Milieu détaillé :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="environment_detail_id"  name="environment_detail_id" >
						<option value="" {if $data.environment_detail_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$environment_detail}
						<option value="{$environment_detail[lst].environment_detail_id}" {if $environment_detail[lst].environment_detail_id == $data.environment_detail_id}selected{/if}>
						{$environment_detail[lst].environment_detail_name}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="area_detail" class="control-label col-sm-4">
						Détail de la zone :
					</label>
					<div class="col-sm-8">
					<textarea id="area_detail" class="form-control" name="area_detail" rows="3" cols="50">{$data.area_detail}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="" class="control-label col-sm-4">
						<br><br><br>Coordonnées GPS en ° :
					</label>
					<div class="col-sm-8">
						<table>
						<tr>
						<td>
						Calcul en degrés/minutes décimales
						</td>
						<td>
						<input name="degreType" type="radio" checked value="1">
						</td>
						</tr>
						<tr>
						<td>
						Calcul en degrés/minutes/secondes
						</td>
						<td>
						<input name="degreType" type="radio" value="0">
						</td>
						</tr>
						</table>
						<table class="tablenoborder">
						<tr>
						<td>
						Long :
						</td><td>
						 <input id="longitude_gps" name="longitude_gps" title="longitude" placeholder="0°5,145W" value="{$data.longitude_gps}" autocomplete="off">
						 <button type="button" id="longCalc" title="recalculer..."><img src="display/images/calculator.png" height="20"></button>
						</td></tr>
						<tr><td>
						Lat  :
						</td><td><input id="latitude_gps" name="latitude_gps" title="latitude" placeholder="45°10,154N" value="{$data.latitude_gps}" autocomplete="off">
						<button type="button" id="latCalc" title="recalculer..."><img src="display/images/calculator.png" height="20"></button>
						</td></tr>
						</table>
					</div>
				</div>
				<div class="form-group">
					<label for="" class="control-label col-sm-4">
						Coordonnées déclarées :
					</label>
					<div class="col-sm-8">
					<table>
						<tr>
						<td>
						Long :
						</td><td>
						<input id="longitude_declared_dd" name="longitude_declared_dd" title="longitude" placeholder="-0.184" value="{$data.longitude_declared_dd}" autocomplete="off">
						</td></tr>
						<tr><td>
						Lat  :
						</td><td><input id="latitude_declared_dd" name="latitude_declared_dd" title="latitude" placeholder="45.154" value="{$data.latitude_declared_dd}" autocomplete="off">
						</td></tr>
						</table>
					</div>
				</div>
				<div class="form-group">
					<label for="" class="control-label col-sm-4">
						Coordonnées estimées :
					</label>
					<div class="col-sm-8">
						<table>
						<tr>
						<td>
						Long :
						</td><td><input id="longitude_estimated_dd" name="longitude_estimated_dd" title="longitude" placeholder="-0.184" value="{$data.longitude_estimated_dd}" autocomplete="off">
						</td></tr>
						<tr><td>
						Lat  :
						</td><td><input id="latitude_estimated_dd" name="latitude_estimated_dd" title="latitude" placeholder="45.154" value="{$data.latitude_estimated_dd}" autocomplete="off">
						</td></tr>
						</table>
					</div>
				</div>
				<div class="form-group">
					<label for="" class="control-label col-sm-4">
						Coordonnées validées :
					</label>
					<div class="col-sm-8">
					<table>
						<tr>
						<td>
						Long :
						</td><td>
						<input class="position" id="longitude_dd" name="longitude_dd" title="longitude" placeholder="-0.184" value="{$data.longitude_dd}" autocomplete="off">
						</td></tr>
						<tr><td>
						Lat  :
						</td><td><input class="position" id="latitude_dd" name="latitude_dd" title="latitude" placeholder="45.154" value="{$data.latitude_dd}" autocomplete="off">
						</td></tr>
						</table>
					</div>
				</div>
				<div class="form-group">
					<label for="accuracy_id" class="control-label col-sm-4">Précision estimée du point GPS :</label>
					<div class="col-sm-8">
						<select id="accuracy_id" name="accuracy_id" class="form-control">
							<option value="" {if $data.accuracy_id == ""}selected{/if}>Sélectionnez...</option>
							{foreach $accuracys as $accuracy}
								<option value="{$accuracy.accuracy_id}" {if $data.accuracy_id == $accuracy.accuracy_id}selected{/if}>{$accuracy.accuracy_name}</option>
							{/foreach}
						</select>
					</div>
				</div>


				<div class="form-group center">
      				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				 </div>
			</form>
			</div>


<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
</div>
<!-- Ajout de la carte pour visualiser le point de capture -->
<div class="col-sm-6" style="height:600px;" id="map"></div>
</div>
<script>
function transform_geometry(element) {
	  var current_projection = new ol.proj.Projection({ code: "EPSG:4326" });
	  var new_projection = layer.getSource().getProjection();

	  element.getGeometry().transform(current_projection, new_projection);
	}

function setPosition(lon, lat) {
	var lonlat = ol.proj.transform([parseFloat(lon),parseFloat(lat)], 'EPSG:4326', 'EPSG:3857');
			point.setCoordinates (lonlat3857);
		   view.setCenter(lonlat3857);
}

function positionChange() {
	var lon = $("#longitude_dd").val();
	var lat = $("#latitude_dd").val();
	if (lon.length > 0 && lat.length > 0) {
		/*
		console.log("longitude saisie : "+ lon);
		console.log ("latitude saisie : " + lat);
		*/
		var lonlat3857 = ol.proj.transform([parseFloat(lon),parseFloat(lat)], 'EPSG:4326', 'EPSG:3857');
        point.setCoordinates (lonlat3857);
    	view.setCenter(lonlat3857);
}
}

$(".position").change(function () {
	positionChange();
});

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
var coordonnee = [0, 45] ;
var point = new ol.geom.Point(coordonnee);
point_feature = new ol.Feature ( {
	geometry: point
});
point_feature.setStyle(imageStyle);
var features = new Array();
features.push(point_feature);
var lonlat3857 = ol.proj.transform(coordonnee, 'EPSG:4326', 'EPSG:3857');
var zoom = 5;
var lon = $("#longitude_dd").val();
var lat = $("#latitude_dd").val();

if (lon.length > 0 && lat.length > 0) {
	coordonnee = [parseFloat(lon),parseFloat(lat)];
	lonlat3857 = ol.proj.transform(coordonnee, 'EPSG:4326', 'EPSG:3857');
	zoom = 9;
	point.setCoordinates (coordonnee);
}

var view = new ol.View({
    zoom: zoom
  });
view.setCenter(lonlat3857);
//console.log("coordonnees : ", coordonnee);

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
  view: view
});
var layer = new ol.layer.Tile({
	  source: new ol.source.OSM()
	});
map.addLayer(layer);
map.addControl(mousePosition);


var layerPoint = new ol.layer.Vector({
	  source: new ol.source.Vector( {
	    features: features
	  })
	});
features.forEach(transform_geometry);
map.addLayer(layerPoint);
</script>
