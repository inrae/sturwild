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
	});
	$("#latitude_declaree_dd,#latitude_estimee_dd").change(function() { 
		var valeur = $(this).val();
		$('#latitude_dd').val( valeur );
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

<a href="index.php?module=declarationList">Retour à la liste</a>

<a href="index.php?module=declarationDisplay&declaration_id={$data.declaration_id}">Retour
	au détail</a>
<div class="formSaisie">
	<fieldset>
		<legend>Localisation</legend>
		<div>

			<form id="localisation" method="post" action="index.php?module=localisationWrite">
				<input type="hidden" name="declaration_id" value="{$data.declaration_id}">
				<dl>
					<dt>
						Pays :
					</dt>
					<dd>
						<select name="pays_id" autofocus>
						<option value="" {if $data.pays_id == ""}selected{/if}>
						{section name=lst loop=$pays}
						<option value="{$pays[lst].pays_id}" {if $pays[lst].pays_id == $data.pays_id}selected{/if}>
						{$pays[lst].pays_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>
						Zone CIEM :
					</dt>
					<dd>
						<select name="ciem_id" >
						<option value="" {if $data.ciem_id == ""}selected{/if}>
						{section name=lst loop=$ciem}
						<option value="{$ciem[lst].ciem_id}" {if $ciem[lst].ciem_id == $data.ciem_id}selected{/if}>
						{$ciem[lst].ciem_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>
						Région :
					</dt>
					<dd>
						<select name="region_id" >
						<option value="" {if $data.region_id == ""}selected{/if}>
						{section name=lst loop=$region}
						<option value="{$region[lst].region_id}" {if $region[lst].region_id == $data.region_id}selected{/if}>
						{$region[lst].region_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>
						Milieu :
					</dt>
					<dd>
						<select name="milieu_id" >
						<option value="" {if $data.milieu_id == ""}selected{/if}>
						{section name=lst loop=$milieu}
						<option value="{$milieu[lst].milieu_id}" {if $milieu[lst].milieu_id == $data.milieu_id}selected{/if}>
						{$milieu[lst].milieu_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>
						Milieu détaillé :
					</dt>
					<dd>
						<select name="milieu_detail_id" >
						<option value="" {if $data.milieu_detail_id == ""}selected{/if}>
						{section name=lst loop=$milieu_detail}
						<option value="{$milieu_detail[lst].milieu_detail_id}" {if $milieu_detail[lst].milieu_detail_id == $data.milieu_detail_id}selected{/if}>
						{$milieu_detail[lst].milieu_detail_libelle}
						</option>
						{/section}
						</select>
					</dd>
				</dl>
				<dl>
					<dt>
						Détail de la zone :
					</dt>
					<dd>
					<textarea name="zone_detail" rows="3" cols="50">{$data.zone_detail}</textarea>
					</dd>
				</dl>
				<dl>
					<dt>
						<br><br><br>Coordonnées GPS en ° :
					</dt>
					<dd>
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
					</dd>						
				</dl>
				<dl>
					<dt>
						<br>Coordonnées déclarées :
					</dt>
					<dd>
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
					</dd>
				</dl>
				<dl>
					<dt>
						<br>Coordonnées estimées :
					</dt>
					<dd>
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
					</dd>						
				</dl>
				<dl>
					<dt>
						<br>Coordonnées validées :
					</dt>
					<dd><table>
						<tr>
						<td>
						Long :
						</td><td>
						<input id="longitude_dd" name="longitude_dd" title="longitude" placeholder="-0.184" value="{$data.longitude_dd}" autocomplete="off">
						</td></tr>
						<tr><td>
						Lat  :
						</td><td><input id="latitude_dd" name="latitude_dd" title="latitude" placeholder="45.154" value="{$data.latitude_dd}" autocomplete="off">
						</td></tr>
						</table>
					</dd>						
				</dl>
				
				<div class="formBouton">
					<input class="submit" type="submit" value="Enregistrer">
				</div>
			</form>	
			</div>
	</fieldset>
</div>

<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>				