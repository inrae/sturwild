<script>
$(document).ready(function() {
	setDataTables("documentList");
	$('.image-popup-no-margins').magnificPopup( {
		type: 'image',
		closeOnContentClick: true,
		closeBtnInside: false,
		fixedContentPos: true,
		mainClass: 'mfp-no-margins mfp-with-zoom', // class to remove default margin from left and right side
		image: {
			verticalFit: false
		},
		zoom: {
			enabled: true,
			duration: 300 // don't foget to change the duration also in CSS
		}
	});
	var documentChangeShow = 0;
	$('#documentChange').hide("") ;
	$('#documentChangeActivate').click(function () {
		if (documentChangeShow == 0) {
			$('#documentChange').show("");
			documentChangeShow = 1 ;
			 $("html, body").animate({ scrollTop: $(document).height() }, 1000);
		} else {
			$('#documentChange').hide("");
			documentChangeShow = 0 ;
		}
	});
} ) ;
</script>
{if $rights["gestion"] == 1 }
<a href="#" id="documentChangeActivate">{t}Saisir un nouveau document...{/t}</a>
<div id="documentChange" hidden="true">
{include file="document/documentChange.tpl"}
</div>
{/if}
<table id="documentList" class="tableliste">
<thead>
<tr>
<th>{t}Vignette{/t}</th>
<th>{t}Nom du document{/t}</th>
<th>{t}Description{/t}</th>
<th>{t}Taille{/t}</th>
<th>{t}Date d'import{/t}</th>
{if $rights["gestion"] == 1}
<th>{t}Supprimer{/t}</th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$dataDoc}
<tr>
<td class="center">
{if in_array($dataDoc[lst].mime_type_id, array(4, 5, 6)) }
<a class="image-popup-no-margins" href="documentGet?document_id={$dataDoc[lst].document_id}&document_name={$dataDoc[lst].photo_preview}&attached=0&phototype=1" title="aperçu de la photo : {substr($dataDoc[lst].photo_name, strrpos($dataDoc[lst].photo_name, '/') + 1)}">
<img src="documentGet&document_id={$dataDoc[lst].document_id}&document_name={$dataDoc[lst].thumbnail_name}&attached=0&phototype=2" height="30">
</a>
{elseif  $dataDoc[lst].mime_type_id == 1}
<a class="image-popup-no-margins" href="documentGet?document_id={$dataDoc[lst].document_id}&&document_name={$dataDoc[lst].thumbnail_name}&attached=0&phototype=2" title="aperçu du document : {substr($dataDoc[lst].thumbnail_name, strrpos($dataDoc[lst].thumbnail_name, '/') + 1)}">
<img src="documentGet&document_id={$dataDoc[lst].document_id}&document_name={$dataDoc[lst].thumbnail_name}&attached=0&phototype=2" height="30">
</a>
{/if}
<td>
<a href="documentSent?document_id={$dataDoc[lst].document_id}&filename={$dataDoc[lst].photo_name}&attached=1" title="{t}document original{/t}">
{$dataDoc[lst].document_name}
</a>
</td>
<td>{$dataDoc[lst].document_description}</td>
<td>{$dataDoc[lst].size}</td>
<td>{$dataDoc[lst].document_date_import}</td>
{if $rights["gestion"] == 1}
<td>
<div class="center">
<a href="documentDelete?document_id={$dataDoc[lst].document_id}&moduleParent={$moduleParent}&parentIdName={$parentIdName}&parent_id={$parent_id}&parentType={$parentType}" onclick="return confirm('{t}Confirmez-vous la suppression ?{/t}');">
<img src="display/images/corbeille.png" height="20">
</a>
</div>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>
