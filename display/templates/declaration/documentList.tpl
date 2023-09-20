<script>
$(document).ready(function() {
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
			duration: 300 // don't forget to change the duration also in CSS
		}
	});
} ) ;
</script>

<table id="documentList" class="table table-bordered table-hover" >
<thead>
<tr>
<th>{t}N° poisson{/t}</th>
<th>{t}Vignette{/t}</th>
<th>{t}Nom du document{/t}</th>
<th>{t}Description{/t}</th>
<th>{t}Taille{/t}</th>
<th>{t}Date d'import{/t}</th>
{if $droits["gestion"] == 1 }
<th>{t}Supprimer{/t}</th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$dataDoc}
<tr>
<td class="center">
{if $droits.gestion == 1}
<a href="index.php?module=fishChange&fish_id={$dataDoc[lst].fish_id}" title="Modifier les informations concernant le poisson">{$dataDoc[lst].fish_id}</a>
{else}
{$dataDoc[lst].fish_id}
{/if}
</td>
<td style="text-align:center;">
{if in_array($dataDoc[lst].mime_type_id, array(1,4,5,6,7))}
{if $dataDoc[lst].mime_type_id != 1}
<a class="image-popup-no-margins"
   href="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&attached=0&phototype=1"
   title="aperçu de la photo">
   <img src="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&attached=0&phototype=2" height="30">
{/if}

{if $dataDoc[lst].mime_type_id != 1}</a>{/if}
{/if}
<td>
<a href="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&attached=1&phototype=0"" title="document original">
{$dataDoc[lst].document_name}
</a>

</td>
<td>{$dataDoc[lst].document_description}</td>
<td>{$dataDoc[lst].size}</td>
<td>{$dataDoc[lst].document_date_import}</td>
{if $droits["gestion"] == 1}
<td>
<div class="center">
<a href="index.php?module=documentDelete&document_id={$dataDoc[lst].document_id}&fish_id={$dataDoc[lst].fish_id}" onclick="return confirm('Confirmez-vous la suppression ?');">
<img src="display/images/corbeille.png" height="20">
</a>
</div>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>
