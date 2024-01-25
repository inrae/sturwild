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
<h2>{t}Import de déclarations à partir d'un fichier CSV{/t}</h2>

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
    <form id="importForm" method="post" action="index.php">
        <input type="hidden" name="module" value="importCSVExec">
        {t}Contrôles OK.{/t} {t 1=$importParameters.name}Vous pouvez réaliser l'import du fichier (%1) :{/t}
        <button type="submit" class="btn btn-danger">{t}Déclencher l'import{/t}</button>
    </form>
</div>
{/if}
{/if}
<!-- Select the file to import -->
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="controlForm" method="post" action="index.php" enctype="multipart/form-data">
            <input type="hidden" name="module" value="importCSVControl">
            <div class="form-group">
                <label for="upfile" class="control-label col-md-4"><span class="red">*</span>
                    {t}Nom du fichier à importer (CSV) :{/t}
                </label>
                <div class="col-md-8">
                    <input type="file" name="upfile" class="form-control" required>
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
        </form>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="bg-info">
            <h3>{t}Liste des colonnes utilisables dans le fichier d'import{/t}</h3>
            <p>
                {t}Les informations suffixées par _name vont alimenter les tables de paramètres : consultez-les pour éviter de créer des libellés en doublon{/t}&nbsp;
                {t}Le suffixe _name peut être remplacé par _exchange : dans ce cas, les libellés attendus sont ceux qui sont utilisés pour les échanges d'informations inter-organismes{/t}
            </p>

            <u>{t}Informations obligatoires{/t}</u>
            <ul>
                <li><b>origin_name</b> {t}Sigle de l'organisme{/t}</li>
                <li><b>origin_identifier</b> {t}Code d'identification de la déclaration dans le fichier d'origine : clé
                    utilisée pour importer ensuite les poissons rattachés à la déclaration{/t}</li>
                <li><b>declaration_uuid</b> {t}UUID de la déclaration, si existant. Peut se substituer à  origin_identifier{/t}</li>
                <li><b>capture_date</b> {t}Date de la capture, au format YYYY-MM-DD{/t}</li>
                <li><b>year</b> {t}Année de capture, au format YYYY. L'année est obligatoire si capture_date n'est pas renseigné{/t}</li>
            </ul>
            <u>{t}Informations facultatives{/t}</u>
            <ul>
                <li><b>capture_methode_name</b> {t}Méthode de capture{/t}</li>
                <li><b>gear_type_name</b> {t}Type d'engin{/t}</li>
                <li><b>species_name</b> {t}Espèce d'esturgeon capturée{/t}</li>
                <li><b>capture_state_name</b> {t}État à la capture{/t}</li>
                <li><b>fate_name</b> {t}Devenir des poissons{/t}</li>
                <li><b>target_species_name</b> {t}Espèce ciblée lors de la pêche{/t}</li>
                <li><b>estimated_capture_date</b> {t}Date estimée de la capture{/t}</li>
                <li><b>caught_number</b> {t}Nombre de poissons capturés (obligatoire){/t}</li>
                <li><b>gear_mesh</b> {t}Taille de la maille du filet{/t}</li>
                <li><b>target_species</b> {t}Liste textuelle des espèces ciblées{/t}</li>
                <li><b>depth</b> {t}Profondeur de pêche, en mètres{/t}</li>
                <li><b>depth_min</b> {t}Profondeur minimale de pêche{/t}</li>
                <li><b>depth_max</b> {t}Profondeur maximale de pêche{/t}</li>
                <li><b>length_min</b> {t}Longueur minimale des poissons capturés, en millimètres{/t}</li>
                <li><b>length_max</b> {t}Longueur maximale des poissons capturés{/t}</li>
                <li><b>weight_min</b> {t}Poids minimum des poissons capturés, en grammes{/t}</li>
                <li><b>weight_max</b> {t}Poids maximum, en grammes{/t}</li>
                <li><b>fisher_code</b> {t}Code du pêcheur{/t}</li>
                <li><b>contact</b> {t}Nom ou organisme à contacter{/t}</li>
                <li><b>contact_coordinates</b> {t}Coordonnées complètes du contact{/t}</li>
                <li><b>harbour_vessel</b> {t}Port d'attache du navire{/t}</li>
                <li><b>declaration_mode</b> {t}Mode de déclaration (texte libre){/t}</li>
                <li><b>remarks</b> {t}Remarques sur la déclaration{/t}</li>
                <li><b>handlings_name</b> {t}Manipulations réalisées sur les poissons, séparées par une virgule{/t}</li>
                <li><b>identification_quality</b> {t}0 : identification incertaine de l'espèce, 1 : identification
                    sûre{/t}</li>
                <li><b>country_name</b> {t}Pays de capture{/t}</li>
                <li><b>ices_name</b> {t}Zone CIEM{/t}</li>
                <li><b>environment_name</b> {t}Milieu{/t}</li>
                <li><b>environment_detail_name</b> {t}Milieu détaillé{/t}</li>
                <li><b>area_detail</b> {t}informations complémentaire sur la zone de capture{/t}</li>
                <li><b>longitude_gps</b> {t}Longitude WGS84, exprimée sous forme degré-minute-seconde{/t}</li>
                <li><b>latitude_gps</b> {t}Latitude WGS84, exprimée sous forme degré-minute-seconde{/t}</li>
                <li><b>longitude_dd</b> {t}Longitude WGS84, sous forme décimale{/t}</li>
                <li><b>latitude_dd</b> {t}Latitude WGS84, sous forme décimale{/t}</li>
                <li><b>accuracy_name</b> {t}Précision de la localisation{/t}</li>
            </ul>
        </div>
    </div>
</div>