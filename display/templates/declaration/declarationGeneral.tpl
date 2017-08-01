{if $droits.gestion ==1}
<a href="index.php?module=declarationChange&declaration_id={$data.declaration_id}">
<img src="display/images/edit.gif" height="20">Modifier...
</a>
{/if}
<div class="formDisplay">
				<dl>
					<dt>
						Statut  :
					</dt>
					<dd>{$data.statut_libelle}					
					</dd>
				</dl>
				<dl>
				<dt>Espèce :</dt>
				<dd>{$data.espece_libelle}
				&nbsp;({if $data.qualite_identification == 1}Sûr{else}incertain{/if})
				</dl>
				<dl><dt>Nombre total d'esturgeons capturés :</dt>
				<dd>{$data.nombre_capture}</dl>
				<dl>
				<dt>Année de capture :</dt>
				<dd>{$data.annee}</dd>
				</dl>	
				<dl>
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
				<dl>
					<dt>
						profondeur (ou gamme de profondeur) :
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
				<dl>
					<dt>
						Statut du déclarant  :
					</dt>
					<dd>
						{$data.capture_type_libelle}
					</dd>
				</dl>	
				<dl>
					<dt>
						Code du pécheur :
					</dt>
					<dd>
						{$data.pecheur_code}
					</dd>
				</dl>
				<dl>
					<dt>
						Port d'attache du navire de pêche :
					</dt>
					<dd>
						{$data.navire_port}
					</dd>
				</dl>
				<dl>
					<dt>
						Autre correspondant et coordonnées :
					</dt>
					<dd>
						{$data.interlocuteur}
						<br>
<span class="textareaDisplay">{$data.interlocuteur_coord}</span>
					</dd>
				</dl>
				
				<dl>
					<dt>
						Mode de capture  :
					</dt>
					<dd>
						{$data.capture_mode_libelle}
					</dd>
				</dl>
				<dl>
					<dt>
						Type d'engin utilisé et maille :
					</dt>
					<dd>
						{$data.engin_type_libelle} {$data.engin_maille}
					</dd>
				</dl>
				<dl>
					<dt>
						Espèce ciblée :
					</dt>
					<dd>
						{$data.espece_ciblee}
					</dd>
				</dl>
				<dl>
					<dt>
						Mode de déclaration :
					</dt>
					<dd>
						{$data.declaration_mode}
					</dd>
				</dl>
				
				<dl>
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
				<dl>
				<dt>Longueur totale :</dt>
				<dd>de : {$data.lt_min} mm à : {$data.lt_max} mm</dd>
				</dl>
				{/if}
				{if $data.masse_min > 0 || $data.masse_max > 0}
				<dl>
				<dt>Masse :</dt>
				<dd>de : {$data.masse_min} kg à : {$data.masse_max} kg</dd>
				</dl>
				{/if}
				<dl>
				<dt>État à la capture :</dt>
				<dd>{$data.capture_etat_libelle}</dd>
				</dl>
				<dl>
				<dt>Manipulation effectuée :</dt>
				<dd>{$data.manipulation}</dd>
				</dl>
				<dl><dt>Devenir du lot :</dt>
				<dd>{$data.devenir_libelle}</dd>
				</dl>
				</fieldset>
				
				<dl></dl>
</div>