{include file="mapDefault.tpl"}
<script>
    var point;
    function setPosition(lat, lon) {
        if (point == undefined) {
            point = L.marker([lat, lon]);
            point.addTo(map);
        } else {
            point.setLatLng([lat, lon]);
        }
        map.setView([lat, lon]);
    }
    function setDefaultPosition(lat, lon) {
        if (lat.length > 0 && lon.length > 0) {
            mapData.mapDefaultLong = lon;
            mapData.mapDefaultLat = lat;
            map.setView([lat, lon]);
        }
    }

    var mapIsChange = "{$mapIsChange}";
    var map = setMap("map");
    var lon = "{$location.longitude_dd}";
    var lat = "{$location.latitude_dd}";

    mapDisplay(map);
    if (lon.length > 0 && lat.length > 0) {
        setPosition(lat, lon);
    }

    if (mapIsChange == 1) {
        map.on('click', function (e) {
            setPosition(e.latlng.lat, e.latlng.lng);
            $("#longitude_dd").val(e.latlng.lng);
            $("#latitude_dd").val(e.latlng.lat);
        });
    }

</script>