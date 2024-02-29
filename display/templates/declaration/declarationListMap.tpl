{include file="mapDefault.tpl"}
<link rel="stylesheet" href="display/node_modules/leaflet.markercluster/dist/MarkerCluster.css">
<link rel="stylesheet" href="display/node_modules/leaflet.markercluster/dist/MarkerCluster.Default.css">
<script src="display/node_modules/leaflet.markercluster/dist/leaflet.markercluster.js"></script>
<script>
    var mapList = setMap("mapList");
    L.control.scale().addTo(mapList);
    mapList.setMaxZoom(19);
    var markers = JSON.parse('{$markers}');
    var markerGroup = L.markerClusterGroup();
   
    /** Create the markers */
    markers.markers.forEach(function (marker) {
        var title = marker.id + " - " + marker.date;
        var mark = L.marker(marker.latlng, {
            "title": title
        });
        mark.bindPopup("<a href=index.php?module=declarationDisplay&declaration_id=" + marker.id + ">" + title + "</a>").openPopup();
        markerGroup.addLayer(mark);
    });
     mapList.addLayer(markerGroup);
     $("#mapList").width(window.innerWidth - 40);
        $("#mapList").height(window.innerHeight * 0.5);
    mapDisplay(mapList);
    
</script>