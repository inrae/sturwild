<!--
<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
} ) ;
</script>
-->

<div >
<fieldset>
<legend>Critères de recherche des déclarations</legend>
<form class="form-horizontal protoform col-md-10" method="GET" action="index.php" id="search">
<input type="hidden" name="module" value="declarationList">
<input type="hidden" name="isSearch" value="1">
<div class="form-group">
<label for="" class="col-sm-2 control-label">Texte à rechercher :</label> 
<div class="col-sm-4">
<input class="commentaire form-control" id="libelle" name="libelle" value="{$dataSearch.libelle}" 
placeholder="N° déclaration, code pêcheur ou interlocuteur" 
title="Recherche à partir du N° de la déclaration, du code du pêcheur ou du nom de l'interlocuteur">
</div>
<label for="statut_id" class="col-sm-2 control-label">Statut : </label>
<div class="col-sm-4">
<select class="form-control  id="statut_id" name="statut_id">
<option value="" {if $dataSearch.statut_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$statut}
<option value={$statut[lst].statut_id} {if $dataSearch.statut_id == $statut[lst].statut_id}selected{/if}>
{$statut[lst].statut_libelle}
</option>
{/section}
</select>
</div>
</div>

<div class="form-group">
<label for="espece_id" class="col-sm-2 control-label">Espèce : </label>
<div class="col-sm-4">
<select class="form-control" name="espece_id" id="espece_id">
<option value="" {if $dataSearch.espece_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$espece}
<option value={$espece[lst].espece_id} {if $dataSearch.espece_id == $espece[lst].espece_id}selected{/if}>
{$espece[lst].espece_libelle}
</option>
{/section}
</select>
</div>
<label for="capture_etat_id" class="col-sm-2 control-label">État à la capture :</label>
<div class="col-sm-4">
<select class="form-control" name="capture_etat_id" id="capture_etat_id">
<option value="" {if $dataSearch.capture_etat_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$capture_etat}
<option value={$capture_etat[lst].capture_etat_id} {if $dataSearch.capture_etat_id == $capture_etat[lst].capture_etat_id}selected{/if}>
{$capture_etat[lst].capture_etat_libelle}
</option>
{/section}
</select>
</div>
</div>

<div class="form-group">
<label for="pays_id" class="col-sm-1 control-label">Pays :</label>
<div class="col-sm-2">
<select class="form-control" id="pays_id" name="pays_id">
<option value="" {if $dataSearch.pays_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$pays}
<option value={$pays[lst].pays_id} {if $dataSearch.pays_id == $pays[lst].pays_id}selected{/if}>
{$pays[lst].pays_libelle}
</option>
{/section}
</select>
</div>
<label for="ciem_id" class="col-sm-1 control-label">Zone CIEM :</label>
<div class="col-sm-2">
<select class="form-control" id="ciem_id" name="ciem_id">
<option value="" {if $dataSearch.ciem_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$ciem}
<option value={$ciem[lst].ciem_id} {if $dataSearch.ciem_id == $ciem[lst].ciem_id}selected{/if}>
{$ciem[lst].ciem_libelle}
</option>
{/section}
</select>
</div>
<label for="engin_type_id" class="col-sm-2 control-label">Engin de pêche :</label>
<div class="col-sm-4">
<select class="form-control " id="engin_type_id" name="engin_type_id">
<option value="" {if $dataSearch.engin_type_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$engin_type}
<option value={$engin_type[lst].engin_type_id} {if $dataSearch.engin_type_id == $engin_type[lst].engin_type_id}selected{/if}>
{$engin_type[lst].engin_type_libelle}
</option>
{/section}
</select>
</div>
</div>

<label for="milieu_id" class="col-sm-1 control-label">Milieu :</label>
<div class="col-sm-2">
<select class="form-control" id="milieu_id" name="milieu_id">
<option value="" {if $dataSearch.milieu_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$milieu}
<option value={$milieu[lst].milieu_id} {if $dataSearch.milieu_id == $milieu[lst].milieu_id}selected{/if}>
{$milieu[lst].milieu_libelle}
</option>
{/section}
</select>
</div>
<label for="annee_debut" class="col-sm-2 control-label">Année de la déclaration : de </label>
<div class="col-sm-2">
<select class="form-control" id="annee_debut" name="annee_debut">
{foreach from=$annees item=annee}
<option value="{$annee}" {if $annee==$dataSearch.annee_debut}selected{/if}>
{$annee}
</option>
{/foreach}
</select>
</div>
</div>
<div class="form-group">
<input type="submit" class="btn btn-success col-sm-offset-4 col-sm-2" value="{t}Rechercher{/t}" autofocus>
 <label for="annee_fin" class="col-sm-2 control-label">à </label>
 <div class="col-sm-2">
<select class="form-control" id="annee_fin" name="annee_fin">
{foreach from=$annees item=annee}
<option value="{$annee}" {if $annee==$dataSearch.annee_fin}selected{/if}>
{$annee}
</option>
{/foreach}
</select>
</div>
</div>
 </form>
</fieldset>
</div>
