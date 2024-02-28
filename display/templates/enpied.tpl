<div class="container">
  <p class="text-muted">
    {t}Copyright © 2015- 2024 - Tous droits réservés. Auteur : Éric Quinton, pour EABX - INRAE - Logiciel diffusé sous licence AGPL{/t}
    <br>
    {t}En cas de problème :{/t}&nbsp;
    <a href="{$appliAssist}">{$appliAssist}</a>
  </p>
  <ul class="nav pull-right scroll-top scrolltotop">
    <li><a href="#" title="Scroll to top"><i class="glyphicon glyphicon-chevron-up"></i></a></li>
  </ul>
  {if !empty($developpementMode)}
  <div class="text-warning">{$developpementMode}</div>
  {/if}
</div>
