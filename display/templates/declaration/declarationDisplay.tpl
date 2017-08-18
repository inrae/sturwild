<script>
$(document).ready(function() {
$("#duplicate").on("click", function () { 
	return confirm("Confirmez-vous la duplication de cette déclaration ?");
});
});
</script>
<div class="col-md-12">
<a href="index.php?module=declarationList">
<img src="display/images/list.png" height="20">
Retour à la liste</a>
{if $droits.gestion ==1}
<a href=index.php?module=declarationChange&declaration_id=0>
<img src="display/images/new.png" height="25">
Nouvelle déclaration...
</a>
<a id="duplicate" href="index.php?module=declarationDuplicate&declaration_id={$data.declaration_id}">
<img src="display/images/copy.png" height="20">Dupliquer la déclaration</a>
<br> 
<a href="index.php?module=declarationChange&declaration_id={$data.declaration_id}">Données générales</a>
&nbsp;
<a href="index.php?module=localisationChange&declaration_id={$data.declaration_id}">Localisation</a>
<!-- &nbsp;
<a href="index.php?module=lotChange&declaration_id={$data.declaration_id}">Lot</a>-->
&nbsp;
<a href=index.php?module=evenementChange&evenement_id=0&declaration_id={$data.declaration_id}>Nouvel événement</a>
&nbsp;
<a href=index.php?module=individuChange&individu_id=0&declaration_id={$data.declaration_id}>Nouvel esturgeon</a>
{/if}
</div>
<fieldset class="col-md-6 hidden-sm hidden-xs ">
<legend>Données générales - N° {$data.declaration_id}
</legend>
{include file="declaration/declarationGeneral.tpl"}
</fieldset>

<fieldset class="col-md-6 hidden-sm hidden-xs ">
<legend>Événements</legend>
{include file="declaration/evenementList.tpl"}
</fieldset>
<fieldset class="hidden-md hidden-lg col-sm-12 ">
<legend>Événements</legend>
{include file="declaration/evenementList.tpl"}
</fieldset>
<fieldset class="hidden-md hidden-lg col-sm-12 ">
<legend>Données générales - N° {$data.declaration_id}
</legend>
{include file="declaration/declarationGeneral.tpl"}
</fieldset>



<fieldset class="col-sm-12">
<legend>Localisation</legend>
{include file="declaration/localisationDisplay.tpl"}
</fieldset>

<fieldset class="col-sm-12">
<legend>Détail des esturgeons capturés</legend>
{include file="declaration/individuList.tpl"}
</fieldset>

<fieldset class="col-sm-12">
<legend>Photos associées</legend>
{include file="declaration/documentList.tpl"}
</fieldset>


