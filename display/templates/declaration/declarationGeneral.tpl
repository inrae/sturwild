{if $droits.gestion ==1}
<a href="index.php?module=declarationChange&declaration_id={$data.declaration_id}">
<img src="display/images/edit.gif" height="20">Modifier...
</a>
{/if}
<div class="form-display">
				<dl class="dl-horizontal">
					<dt>
						Statut  :
					</dt>
					<dd>{$data.statut_libelle}					
					</dd>
				</dl>
				<dl class="dl-horizontal">
				<dt>Espèce :</dt>
				<dd>{$data.espece_libelle}
				&nbsp;({if $data.qualite_identification == 1}Sûr{else}incertain{/if})
				</dl>
				<dl class="dl-horizontal"><dt>Nombre total<br>d'esturgeons<br>capturés :</dt>
				<dd>{$data.nombre_capture}</dl>
				<dl class="dl-horizontal">
				<dt>Année de capture :</dt>
				<dd>{$data.annee}</dd>
				</dl>	
				<dl class="dl-horizontal">
					<dt>
						Date de capture {if strlen($data.capture_date_estimee)>0}(période/heure){/if} :
					</dt>
					<dd>
						{$data.capture_date} 
						{if strlen($data.capture_date_estimee)>0}
						({$data.capture_date_estimee})
						{/if}
					</dd>
				</dl>
				<dl class="dl-horizontal">
					<dt>
						profondeur<br>(ou gamme de<br>profondeur) :
					</dt>
					<dd>
						{if $data.profondeur > 0}
						{$data.profondeur} m
						{/if}
						{if ($data.prof_min > 0 || $data.prof_max > 0)}
						 (min : {$data.prof_min} m. - max : {$data.prof_max} m.)
						 {/if}
					</dd>
				</dl>
				<dl class="dl-horizontal">
					<dt>
						Statut du déclarant  :
					</dt>
					<dd>
						{$data.capture_type_libelle}
					</dd>
				</dl>	
				<dl class="dl-horizontal">
					<dt>
						Code du pécheur :
					</dt>
					<dd>
						{$data.pecheur_code}
					</dd>
				</dl>
				<dl class="dl-horizontal">
					<dt>
						Port d'attache<br>du navire de pêche :
					</dt>
					<dd>
						{$data.navire_port}
					</dd>
				</dl>
				<dl class="dl-horizontal">
					<dt>
						Autre correspondant<br>et coordonnées :
					</dt>
					<dd>
						{$data.interlocuteur}
						<br>
<span class="textareaDisplay">{$data.interlocuteur_coord}</span>
					</dd>
				</dl>
				
				<dl class="dl-horizontal">
					<dt>
						Mode de capture  :
					</dt>
					<dd>
						{$data.capture_mode_libelle}
					</dd>
				</dl>
				<dl class="dl-horizontal">
					<dt>
						Type d'engin<br>utilisé et maille :
					</dt>
					<dd>
						{$data.engin_type_libelle} {$data.engin_maille}
					</dd>
				</dl>
				<dl class="dl-horizontal">
					<dt>
						Espèce ciblée :
					</dt>
					<dd>
						{$data.espece_ciblee}
					</dd>
				</dl>
				<dl class="dl-horizontal">
					<dt>
						Mode de déclaration :
					</dt>
					<dd>
						{$data.declaration_mode}
					</dd>
				</dl>
				
				<dl class="dl-horizontal">
					<dt>
						Observations :
					</dt>
					<dd>
						<span class="textareaDisplay">{$data.observation}</span>							
					</dd>
				</dl>
				<fieldset>
				<legend>Informations sur le lot d'esturgeons</legend>
				{if ($data.lt_min > 0 || $data.lt_max > 0)}
				<dl class="dl-horizontal">
				<dt>Longueur<br>totale :</dt>
				<dd>de : {$data.lt_min} mm à : {$data.lt_max} mm</dd>
				</dl>
				{/if}
				{if $data.masse_min > 0 || $data.masse_max > 0}
				<dl class="dl-horizontal">
				<dt>Masse :</dt>
				<dd>de : {$data.masse_min} kg à : {$data.masse_max} kg</dd>
				</dl>
				{/if}
				<dl class="dl-horizontal">
				<dt>État à la capture :</dt>
				<dd>{$data.capture_etat_libelle}</dd>
				</dl>
				<dl class="dl-horizontal">
				<dt>Manipulation<br>effectuée :</dt>
				<dd>{$data.manipulation}</dd>
				</dl>
				<dl class="dl-horizontal"><dt>Devenir du lot :</dt>
				<dd>{$data.devenir_libelle}</dd>
				</dl>
				</fieldset>

</div>