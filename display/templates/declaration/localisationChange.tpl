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
	$("#longitude_declaree_dd,#longitude_estimee_dd").change(function() {
		var valeur = $(this).val();
		$('#longitude_dd').val( valeur );
		positionChange();

	});
	$("#latitude_declaree_dd,#latitude_estimee_dd").change(function() {
		var valeur = $(this).val();
		$('#latitude_dd').val( valeur );
		positionChange();
	});
	$("#longitude_gps").change(function () {
		//alert($("input[name='degreType']:checked").val());
		if ($("input[name='degreType']:checked").val() == 1  ) {
			$('#longitude_declaree_dd').val ( convertGPSDecimalToDD($(this).val()));
		} else {
			$('#longitude_declaree_dd').val ( convertGPSSecondeToDD($(this).val()));
		}
		if ($('#longitude_declaree_dd').val() != "NaN" ) {
			$('#longitude_declaree_dd').change();
		};
	});
	$("#latitude_gps").change(function () {
		if ($("input[name='degreType']:checked").val() == 1 ) {
			$('#latitude_declaree_dd').val ( convertGPSDecimalToDD($(this).val()));
		} else {
			$('#latitude_declaree_dd').val ( convertGPSSecondeToDD($(this).val()));
		}
		if ($('#latitude_declaree_dd').val() != "NaN" ) {
			$('#latitude_declaree_dd').change();
		};
	});
	$("#longCalc").click( function () {
		$("#longitude_gps").trigger("change");
	});
	$("#latCalc").click( function () {
		$("#latitude_gps").trigger("change");
	});
	$("#localisation").submit(function (event) {
		$("#"+hasfocus).trigger("change");
	});

});
</script>
<h2>Modification de la localisation - N° {$data.declaration_id}</h2>
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

			<form  class="form-horizontal protoform" id="localisation" method="post" action="index.php">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<input type="hidden" name="moduleBase" value="localisation">
				<input type="hidden" name="action" value="Write">

				<div class="form-group">
					<label for="pays_id" class="control-label col-sm-4">
						Pays :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="pays_id"  name="pays_id" autofocus>
						<option value="" {if $data.pays_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$pays}
						<option value="{$pays[lst].pays_id}" {if $pays[lst].pays_id == $data.pays_id}selected{/if}>
						{$pays[lst].pays_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="ciem_id" class="control-label col-sm-4">
						Zone CIEM :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="ciem_id"  name="ciem_id" >
						<option value="" {if $data.ciem_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$ciem}
						<option value="{$ciem[lst].ciem_id}" {if $ciem[lst].ciem_id == $data.ciem_id}selected{/if}>
						{$ciem[lst].ciem_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="milieu_id" class="control-label col-sm-4">
						Milieu :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="milieu_id"  name="milieu_id" >
						<option value="" {if $data.milieu_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$milieu}
						<option value="{$milieu[lst].milieu_id}" {if $milieu[lst].milieu_id == $data.milieu_id}selected{/if}>
						{$milieu[lst].milieu_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="milieu_detail_id" class="control-label col-sm-4">
						Milieu détaillé :
					</label>
					<div class="col-sm-8">
						<select class="form-control" id="milieu_detail_id"  name="milieu_detail_id" >
						<option value="" {if $data.milieu_detail_id == ""}selected{/if}>Sélectionnez...</option>
						{section name=lst loop=$milieu_detail}
						<option value="{$milieu_detail[lst].milieu_detail_id}" {if $milieu_detail[lst].milieu_detail_id == $data.milieu_detail_id}selected{/if}>
						{$milieu_detail[lst].milieu_detail_libelle}
						</option>
						{/section}
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="zone_detail" class="control-label col-sm-4">
						Détail de la zone :
					</label>
					<div class="col-sm-8">
					<textarea id="zone_detail" class="form-control" name="zone_detail" rows="3" cols="50">{$data.zone_detail}</textarea>
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
						<input id="longitude_declaree_dd" name="longitude_declaree_dd" title="longitude" placeholder="-0.184" value="{$data.longitude_declaree_dd}" autocomplete="off">
						</td></tr>
						<tr><td>
						Lat  :
						</td><td><input id="latitude_declaree_dd" name="latitude_declaree_dd" title="latitude" placeholder="45.154" value="{$data.latitude_declaree_dd}" autocomplete="off">
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
						</td><td><input id="longitude_estimee_dd" name="longitude_estimee_dd" title="longitude" placeholder="-0.184" value="{$data.longitude_estimee_dd}" autocomplete="off">
						</td></tr>
						<tr><td>
						Lat  :
						</td><td><input id="latitude_estimee_dd" name="latitude_estimee_dd" title="latitude" placeholder="45.154" value="{$data.latitude_estimee_dd}" autocomplete="off">
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
					<label for="precision_id" class="control-label col-sm-4">Précision estimée du point GPS :</label>
					<div class="col-sm-8">
						<select id="precision_id" name="precision_id" class="form-control">
							<option value="" {if $data.precision_id == ""}selected{/if}>Sélectionnez...</option>
							{foreach $precisions as $precision}
								<option value="{$precision.precision_id}" {if $data.precision_id == $precision.precision_id}selected{/if}>{$precision.precision_name}</option>
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
