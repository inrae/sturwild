<script>
    $(document).ready(function () {
        var myStorage = window.localStorage;
        var defaults = {};
        try {
            defaults = JSON.parse(myStorage.getItem("csvImportParameters"));
            $("#separator").val(defaults["separator"]);
            $("#utf8_encode").val(defaults["utf8_encode"]);
            $("#use_exchange_label".defaults["use_exchange_label"]).checked();
        } catch (Exception) {
        }
        $("#controlForm").submit(function () {
            var uel = 0;
            if ($("#use_exchange_labels1").checked()) {
                uel = 1;
            }
            defaults = {
                "separator": $("#separator").val(),
                "encoding": $("#utf8_encode").val(),
                "use_exchange_label": uel
            };
            myStorage.setItem("csvImportParameters", JSON.stringify(defaults));
        });
    });
</script>
<h2>{t}Import de poissons à partir d'un fichier CSV{/t}</h2>

<!-- Start import -->
{if $controlDone == 1}
{if isset($parameters) && count($parameters) > 0}
<h3>{t}Liste des paramètres qui vont être créés{/t}</h3>
<div class="row col-md-12">
    <table id="parametersList" class="table table-bordered table-hover datatable ">
        <thead>
            <tr>
                <th>{t}Table{/t}</th>
                <th>{t}Libellés à créer{/t}</th>
            </tr>
        </thead>
        <tbody>
            {foreach $parameters as $parameter}
            <tr>
                <td class="">{$parameter@key}</td>
                <td class="">{foreach $parameter as $content}
                    {if $content@iteration > 1}<br>{/if}
                    {$content}
                    {/foreach}
                </td>
            </tr>
            {/foreach}
        </tbody>
    </table>
</div>
{/if}
{if count($errors) > 0}
<div class="row col-md-12">
    <table id="errorsList" class="table table-bordered table-hover datatable ">
        <thead>
            <tr>
                <th>{t}N° de ligne{/t}</th>
                <th>{t}Anomalie détectée{/t}</th>
            </tr>
        </thead>
        <tbody>
            {foreach $errors as $error}
            <tr>
                <td class="center">{$error.line}</td>
                <td>{$error.message}</td>
            </tr>
            {/foreach}
        </tbody>
    </table>
</div>
{/if}
{if $hasErrors == 0}
<div class="row col-md-8">
    <form id="importForm" method="post" action="importFishCSVExec">
        {t}Contrôles OK.{/t} {t 1=$importParameters.name}Vous pouvez réaliser l'import du fichier (%1) :{/t}
        <button type="submit" class="btn btn-danger">{t}Déclencher l'import{/t}</button>
    {$csrf}</form>
</div>
{/if}
{/if}
<!-- Select the file to import -->
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="controlForm" method="post" action="importFishCSVControl" enctype="multipart/form-data">
            <div class="form-group">
                <label for="upfile" class="control-label col-md-4"><span class="red">*</span>
                    {t}Nom du fichier à importer (CSV) :{/t}
                </label>
                <div class="col-md-8">
                    <input type="file" name="upfile" class="form-control" accept=".csv,.txt" required>
                </div>
            </div>
            <div class="form-group">
                <label for="separator" class="control-label col-md-4">{t}Séparateur utilisé :{/t}</label>
                <div class="col-md-8">
                    <select id="separator" name="separator" class="form-control">
                        <option value="," {if $separator=="," }selected{/if}>{t}Virgule{/t}</option>
                        <option value=";" {if $separator==";" }selected{/if}>{t}Point-virgule{/t}</option>
                        <option value="tab" {if $separator=="tab" }selected{/if}>{t}Tabulation{/t}</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="utf8_encode" class="control-label col-md-4">{t}Encodage du fichier :{/t}</label>
                <div class="col-md-8">
                    <select id="utf8_encode" name="utf8_encode" class="form-control">
                        <option value="0" {if $utf8_encode==0}selected{/if}>UTF-8</option>
                        <option value="1" {if $utf8_encode==1}selected{/if}>ISO-8859-x</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="use_exchange_labels" class="control-label col-md-4">
                    {t}Rechercher les libellés des tables de paramètres parmi ceux utilisés pour les échanges :{/t}
                </label>
                <div class="col-md-8">
                    <div class="radio">
                        <label>
                            <input type="radio" name="use_exchange_labels" id="use_exchange_labels1" value="1" checked>
                            {t}oui{/t}
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" name="use_exchange_labels" id="use_exchange_labels0" value="0">
                            {t}non{/t}
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary">{t}Vérifier le fichier{/t}</button>
            </div>
        {$csrf}</form>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="bg-info">
            <h3>{t}Liste des colonnes utilisables dans le fichier d'import{/t}</h3>
            <p>
                {t}Les informations suffixées par _name vont alimenter les tables de paramètres : consultez-les pour éviter de créer des libellés en doublon.{/t}&nbsp;
                {t}Le suffixe _name peut être remplacé par _exchange : dans ce cas, les libellés attendus sont ceux qui sont utilisés pour les échanges d'informations inter-organismes{/t}
            </p>

            <u>{t}Informations obligatoires{/t}</u>
            <ul>
                <li><b>origin_identifier</b> {t}Code d'identification de la déclaration dans le fichier d'origine{/t}</li>
                <li><b>declaration_uuid</b> {t}UUID de la déclaration, si existant. Peut se substituer à  origin_identifier{/t}</li>
            </ul>
            <u>{t}Informations facultatives{/t}</u>
            <ul>
                <li><b>species_name</b> {t}Espèce d'esturgeon capturée{/t}</li>
                <li><b>tag_presence_name</b> {t}Présence de marque sur le poisson (présent, non signalé, absent){/t}</li>
                <li><b>capture_state_name</b> {t}État à la capture{/t}</li>
                <li><b>fate_name</b> {t}Devenir du poisson{/t}</li>
                <li><b>weight</b> {t}Poids du poisson, en grammes{/t}</li>
                <li><b>handling</b> {t}Manipulations effectuées (forme littéraire){/t}</li>
                <li><b>handlings_name</b> {t}Liste des manipulations effectuées, séparées par une virgule, pour alimenter la table handling{/t}</li>
                <li><b>tag_number</b> {t}Numéro de la marque{/t}</li>
                <li><b>fish_length</b> {t}Longueur du poisson, en millimètres{/t}</li>
                <li><b>estimated_cohort</b> {t}Cohorte estimée{/t}</li>
                <li><b>validated_cohort</b> {t}Cohorte validée{/t}</li>
                <li><b>background</b> {t}Historique du poisson{/t}</li>
                <li><b>remarks</b> {t}Remarque sur le poisson{/t}</li>
                <li><b>identification_quality</b> {t}0: identification incertaine, 1: identification sûre{/t}</li>
            </ul>
        </div>
    </div>
</div>