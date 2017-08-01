<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
} ) ;
</script>

<table class="noborder">
<tr><td>
<fieldset>
<legend>Critères de recherche des déclarations</legend>
<form method="GET" action="index.php" id="search">
<input type="hidden" name="module" value="declarationList">
<input type="hidden" name="isSearch" value="1">
Texte à rechercher : 
<input class="commentaire" name="libelle" value="{$dataSearch.libelle}" 
placeholder="N° déclaration, code pêcheur ou interlocuteur" 
title="Recherche à partir du N° de la déclaration, du code du pêcheur ou du nom de l'interlocuteur">
Statut : 
<select name="statut_id">
<option value="" {if $dataSearch.statut_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$statut}
<option value={$statut[lst].statut_id} {if $dataSearch.statut_id == $statut[lst].statut_id}selected{/if}>
{$statut[lst].statut_libelle}
</option>
{/section}
</select>
<br>
Espèce : 
<select name="espece_id">
<option value="" {if $dataSearch.espece_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$espece}
<option value={$espece[lst].espece_id} {if $dataSearch.espece_id == $espece[lst].espece_id}selected{/if}>
{$espece[lst].espece_libelle}
</option>
{/section}
</select>
État à la capture :
<select name="capture_etat_id">
<option value="" {if $dataSearch.capture_etat_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$capture_etat}
<option value={$capture_etat[lst].capture_etat_id} {if $dataSearch.capture_etat_id == $capture_etat[lst].capture_etat_id}selected{/if}>
{$capture_etat[lst].capture_etat_libelle}
</option>
{/section}
</select>

<br>
Pays :
<select name="pays_id">
<option value="" {if $dataSearch.pays_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$pays}
<option value={$pays[lst].pays_id} {if $dataSearch.pays_id == $pays[lst].pays_id}selected{/if}>
{$pays[lst].pays_libelle}
</option>
{/section}
</select>
Zone CIEM :
<select name="ciem_id">
<option value="" {if $dataSearch.ciem_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$ciem}
<option value={$ciem[lst].ciem_id} {if $dataSearch.ciem_id == $ciem[lst].ciem_id}selected{/if}>
{$ciem[lst].ciem_libelle}
</option>
{/section}
</select>
Engin de pêche :
<select name="engin_type_id">
<option value="" {if $dataSearch.engin_type_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$engin_type}
<option value={$engin_type[lst].engin_type_id} {if $dataSearch.engin_type_id == $engin_type[lst].engin_type_id}selected{/if}>
{$engin_type[lst].engin_type_libelle}
</option>
{/section}
</select>

<br>
Région :
<select name="region_id">
<option value="" {if $dataSearch.region_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$region}
<option value={$region[lst].region_id} {if $dataSearch.region_id == $region[lst].region_id}selected{/if}>
{$region[lst].region_libelle}
</option>
{/section}
</select>
Milieu :
<select name="milieu_id">
<option value="" {if $dataSearch.milieu_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$milieu}
<option value={$milieu[lst].milieu_id} {if $dataSearch.milieu_id == $milieu[lst].milieu_id}selected{/if}>
{$milieu[lst].milieu_libelle}
</option>
{/section}
</select>


Année de la déclaration : de 
<select name="annee_debut">
{foreach from=$annees item=annee}
<option value="{$annee}" {if $annee==$dataSearch.annee_debut}selected{/if}>
{$annee}
</option>
{/foreach}
</select>
 à 
<select name="annee_fin">
{foreach from=$annees item=annee}
<option value="{$annee}" {if $annee==$dataSearch.annee_fin}selected{/if}>
{$annee}
</option>
{/foreach}
</select>
<input type="submit" name="Chercher..." autofocus>
 </form>
</fieldset>
</td></tr>
</table>
