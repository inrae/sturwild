<script>
    $(document).ready(function() { 
        var activeTabResult = "";
		var myStorage = window.localStorage;
        try {
        activeTabResult = myStorage.getItem("declarationResultTab");
        } catch (Exception) {
        }
		try {
			if (activeTabResult.length > 0) {
				$("#"+activeTabResult).tab('show');
			}
		} catch (Exception) { }
		 $('.tabResult').on('shown.bs.tab', function () {
			myStorage.setItem("declarationResultTab", $(this).attr("id"));
		});
        $('.nav-tabs > li > a').hover(function() {
			//$(this).tab('show');
 		});
    });
</script>
{include file="declaration/declarationSearch.tpl"}
{if $isSearch == 1}
<div class="col-md-12">
    {if $rights["manage"] == 1}
    <a href=declarationChange?declaration_id=0>
        <img src="display/images/new.png" height="25">
        <b>{t}Nouvelle déclaration{/t}</b>
    </a>
    {/if}
    {if count($data) > 0}
    <a href="declarationExport">
        <img src="display/images/csv_text.png" height="25">
        {t}Exporter la liste au format CSV (obsolète){/t}</a>
    &nbsp;
    <a href="fishExport"><img src="display/images/csv_text.png" height="25">
        {t}Exporter les poissons correspondants au format CSV (obsolète){/t}
    </a>
    {/if}

    <ul class="nav nav-tabs  " id="tabResult" role="tablist" >
        <li class="nav-item active">
                <a class="nav-link tabResult" id="tablist" data-toggle="tab"  role="tab" aria-controls="navlist" aria-selected="true" href="#navlist">
                        {t}Liste{/t}
                </a>
        </li>
        <li class="nav-item">
                <a class="nav-link tabResult" id="tabmap" href="#navmap"  data-toggle="tab" role="tab" aria-controls="navmap" aria-selected="false">
                        {t}Carte{/t}
                </a>
        </li>
    </ul>
    <div class="tab-content tab-content-white col-lg-12 form-horizontal" id="tabresult-content">
        <div class="tab-pane active in" id="navlist" role="tabpanel" aria-labelledby="tablist">
            <div class="col-lg-12">
                {include file='declaration/declarationListDetail.tpl'}
            </div>
        </div>
        <div class="tab-pane fade" id="navmap" role="tabpanel" aria-labelledby="tabmap">
            <div id="mapList" class="map" ></div>
            {include file="declaration/declarationListMap.tpl"}
        </div>
    </div>
</div>
{/if}