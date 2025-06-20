<script>
$(document).ready(function() {
	$("#duplicate").on("click", function () {
		return confirm("Confirmez-vous la duplication de cette déclaration ?");
	});
	/**
	* Management of tabs
	*/
	var moduleName = "declarationDisplay";
	try {
		activeTab = Cookies.get(moduleName + "Tab");
	} catch (Exception) {
		activeTab = "";
	}
	try {
		if (activeTab.length > 0) {
			$("#"+activeTab).tab('show');
		}
	} catch (Exception) { }
	$('a[data-toggle="tab"]').on('shown.bs.tab', function () {
		Cookies.set(moduleName + "Tab", $(this).attr("id"), { secure: true});
	});
	/*$("#tab-location").on("shown.bs.tab", function () {
		{if !empty($location.longitude_dd)  && !empty($location.latitude_dd)  && $MAPS_enabled == 1}
				setTimeout(function () { map.updateSize(); }, 400);
		{/if}
  });*/
});

</script>
<div class="col-md-12">
<a href="declarationList">
<img src="display/images/list.png" height="20">
{t}Retour à la liste{/t}</a>
{if $rights.manage ==1 && $editGranted == 1}
<a href=declarationChange?declaration_id=0>
<img src="display/images/new.png" height="25">
{t}Nouvelle déclaration...{/t}
</a>
<a id="duplicate" href="declarationDuplicate?declaration_id={$data.declaration_id}">
<img src="display/images/copy.png" height="20">{t}Dupliquer la déclaration{/t}</a>
{/if}
</div>

<div class="row">
  <div class="col-xs-12">
	  <ul class="nav nav-tabs" id="myTab" role="tablist" >
      <li class="nav-item active">
        <a class="nav-link" id="tab-general" data-toggle="tab"  role="tab" aria-controls="nav-general" aria-selected="true" href="#nav-general">
          <img src="display/images/display.png" height="25">
          {t}Données générales - N°{/t} {$data.declaration_id}
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" id="tab-location" href="#nav-location"  data-toggle="tab" role="tab" aria-controls="nav-location" aria-selected="false">
          <img src="display/images/point.png" height="25">
          {t}Localisation{/t}
        </a>
      </li>
			<li class="nav-item">
        <a class="nav-link" id="tab-sturio" href="#nav-sturio"  data-toggle="tab" role="tab" aria-controls="nav-sturio" aria-selected="false">
          <img src="display/images/fish.png" height="25">
          {t}Esturgeons capturés{/t}
        </a>
      </li>
			<li class="nav-item">
        <a class="nav-link" id="tab-photo" href="#nav-photo"  data-toggle="tab" role="tab" aria-controls="nav-photo" aria-selected="false">
          <img src="display/images/camera.png" height="25">
          {t}Photos associées{/t}
        </a>
      </li>
			<li class="nav-item">
        <a class="nav-link" id="tab-event" href="#nav-event"  data-toggle="tab" role="tab" aria-controls="nav-event" aria-selected="false">
          <img src="display/images/display-red.png" height="25">
          {t}Événements{/t}
        </a>
      </li>
		</ul>
		<div class="tab-content" id="nav-tabContent">
      <div class="tab-pane active in" id="nav-general" role="tabpanel" aria-labelledby="tab-general">
				{include file="declaration/declarationGeneral.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-location" role="tabpanel" aria-labelledby="tab-location">
				{include file="declaration/locationDisplay.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-event" role="tabpanel" aria-labelledby="tab-event">
				{include file="declaration/eventList.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-sturio" role="tabpanel" aria-labelledby="tab-sturio">
				{include file="declaration/fishList.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-photo" role="tabpanel" aria-labelledby="tab-photo">
				{include file="declaration/documentList.tpl"}
			</div>
		</div>
	</div>
</div>
