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
    <dt>{t}Statut  :{/t}</dt>
    <dd>{$data.status_name}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Espèce :{/t}</dt>
    <dd>{$data.species_name}&nbsp;({if $data.identification_quality == 1}Sûr{else}incertain{/if})
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Nombre total d'esturgeons capturés :{/t}</dt>
    <dd>{$data.caught_number}</dl>
  <dl class="dl-horizontal">
  <dt>{t}Année de capture :{/t}</dt>
  <dd>{$data.year}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Date de capture :{/t}{if !empty($data.estimated_capture_date)}({t}période/heure{/t}){/if}</dt>
    <dd>{$data.capture_date}{if !empty($data.estimated_capture_date)}&nbsp;({$data.estimated_capture_date}){/if}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Profondeur (ou gamme de profondeur) :{/t}</dt>
    <dd>{if $data.depth > 0}{$data.depth} m{/if}
      {if ($data.depth_min > 0 || $data.depth_max > 0)}(min : {$data.depth_min} m. - max : {$data.depth_max} m.){/if}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Statut du déclarant  :{/t}</dt>
    <dd>{$data.origin_name}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Code du pécheur :{/t}</dt>
    <dd>{$data.fisher_code}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Port d'attache du navire de pêche :{/t}</dt>
    <dd>{$data.harbour_vessel}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Autre correspondant et coordonnées :{/t}</dt>
    <dd>{$data.contact}&nbsp;<span class="textareaDisplay">{$data.contact_coord}</span></dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Mode de capture  :{/t}</dt>
    <dd>{$data.capture_method_name}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Type d'engin utilisé et maille :{/t}</dt>
    <dd>{$data.gear_type_name} {$data.gear_mesh}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Espèce ciblée :{/t}</dt>
    <dd>
      {$data.target_species_name}
      {if !empty($data.target_species)}
      <br>
      {$data.target_species}
      {/if}
    </dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Mode de déclaration :{/t}</dt>
    <dd>{$data.declaration_mode}</dd>
  </dl>
  <dl class="dl-horizontal">
    <dt>{t}Institut ayant enregistré la déclaration :{/t}</dt>
    <dd>{$data.institute_code}</dd>
  </dl>

   <dl class="dl-horizontal">
    <dt>{t}identifiant technique (UUID) :{/t}</dt>
    <dd>{$data.declaration_uuid}</dd>
  </dl>

  <dl class="dl-horizontal">
    <dt>{t}Observations :{/t}</dt>
    <dd><span class="textareaDisplay">{$data.remarks}</span></dd>
  </dl>
  <fieldset>
    <legend>{t}Informations sur le lot d'esturgeons{/t}</legend>
    {if ($data.length_min > 0 || $data.length_max > 0)}
      <dl class="dl-horizontal">
        <dt>{t}Longueur totale :{/t}</dt>
        <dd>{t}de :{/t} {$data.length_min} mm {t}à :{/t} {$data.length_max} mm</dd>
      </dl>
    {/if}
    {if $data.weight_min > 0 || $data.weight_max > 0}
      <dl class="dl-horizontal">
        <dt>{t}Masse :{/t}</dt>
        <dd>{t}de :{/t} {$data.weight_min} kg {t}à :{/t} {$data.weight_max} kg</dd>
      </dl>
    {/if}
    <dl class="dl-horizontal">
      <dt>{t}État à la capture :{/t}</dt>
      <dd>{$data.capture_state_name}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Manipulations effectuées :{/t}</dt>
      <dd>
        {$data.handlings}
        {if !empty($data.handling)}
        <br>{$data.handling}
        {/if}
      </dd>
    </dl>
      <dl class="dl-horizontal"><dt>{t}Devenir du lot :{/t}</dt>
      <dd>{$data.fate_name}</dd>
    </dl>
  </fieldset>
</div>
</div>
