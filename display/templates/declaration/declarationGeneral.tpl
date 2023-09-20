<div class="row">
{if $droits.gestion ==1}
<a href="index.php?module=declarationChange&declaration_id={$data.declaration_id}">
<img src="display/images/edit.gif" height="20">Modifier...
</a>
{/if}
</div>
<div class="row">
<div class="form-display col-sm-6">
  <dl class="dl-horizontal">
    <dt>Statut  :</dt>
    <dd>{$data.status_name}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Espèce :</dt>
    <dd>{$data.species_name}&nbsp;({if $data.identification_quality == 1}Sûr{else}incertain{/if})
  </dl>
  <dl class="dl-horizontal">
    <dt>Nombre total<br>d'esturgeons<br>capturés :</dt>
    <dd>{$data.caught_number}</dl>
  <dl class="dl-horizontal">
  <dt>Année de capture :</dt>
  <dd>{$data.year}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Date de capture {if !empty($data.estimated_capture_date)}(période/heure){/if} :</dt>
    <dd>{$data.capture_date}{if !empty($data.estimated_capture_date)}&nbsp;({$data.estimated_capture_date}){/if}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>depth (ou gamme de depth) :</dt>
    <dd>{if $data.depth > 0}{$data.depth} m{/if}
      {if ($data.depth_min > 0 || $data.depth_max > 0)}(min : {$data.depth_min} m. - max : {$data.depth_max} m.){/if}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Statut du déclarant  :</dt>
    <dd>{$data.origin_name}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Code du pécheur :</dt>
    <dd>{$data.fisher_code}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Port d'attache du navire de pêche :</dt>
    <dd>{$data.harbour_vessel}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Autre correspondant et coordonnées :</dt>
    <dd>{$data.contact}&nbsp;<span class="textareaDisplay">{$data.contact_coord}</span></dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Mode de capture  :</dt>
    <dd>{$data.capture_method_name}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Type d'engin utilisé et maille :</dt>
    <dd>{$data.gear_type_name} {$data.gear_mesh}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Espèce ciblée :</dt>
    <dd>{$data.target_species}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>Mode de déclaration :</dt>
    <dd>{$data.declaration_mode}</dd>
  </dl>

  <dl class="dl-horizontal">
    <dt>Observations :</dt>
    <dd><span class="textareaDisplay">{$data.remarks}</span></dd>
  </dl>
  <fieldset>
    <legend>Informations sur le lot d'esturgeons</legend>
    {if ($data.length_min > 0 || $data.length_max > 0)}
      <dl class="dl-horizontal">
        <dt>Longueur totale :</dt>
        <dd>de : {$data.length_min} mm à : {$data.length_max} mm</dd>
      </dl>
    {/if}
    {if $data.weight_min > 0 || $data.weight_max > 0}
      <dl class="dl-horizontal">
        <dt>Masse :</dt>
        <dd>de : {$data.weight_min} kg à : {$data.weight_max} kg</dd>
      </dl>
    {/if}
    <dl class="dl-horizontal">
      <dt>État à la capture :</dt>
      <dd>{$data.capture_state_name}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>Manipulation<br>effectuée :</dt>
      <dd>{$data.handling}</dd>
    </dl>
      <dl class="dl-horizontal"><dt>Devenir du lot :</dt>
      <dd>{$data.fate_name}</dd>
    </dl>
  </fieldset>
</div>
</div>
