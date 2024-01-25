<script>
    $(document).ready(function () {
        var myStorage = window.localStorage;
        var defaults = {};
        try {
            defaults = JSON.parse(myStorage.getItem("jsonImportParameters"));
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
                "encoding": $("#utf8_encode").val(),
                "use_exchange_label": uel
            };
            myStorage.setItem("jsonImportParameters", JSON.stringify(defaults));
        });
    });
</script>
<h2>{t}Import de déclarations et des poissons associés à partir d'un fichier JSON{/t}</h2>

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
        <input type="hidden" name="module" value="importJSONExec">
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
            <input type="hidden" name="module" value="importJSONControl">
            <div class="form-group">
                <label for="upfile" class="control-label col-md-4"><span class="red">*</span>
                    {t}Nom du fichier à importer (JSON) :{/t}
                </label>
                <div class="col-md-8">
                    <input type="file" name="upfile" class="form-control" accept=".json" required>
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
            <h3>{t}Contenu du fichier JSON{/t}</h3>
            {t}La structuration du fichier est la suivante :{/t}
            <ul>
                <li>{t}Chaque déclaration  est au premier niveau du fichier{/t}</li>
                <li>{t}Les poissons associés sont présents dans le champ fishes de chaque déclaration{/t}</li>
                <li>{t}Les colonnes (les variables) attendues sont les mêmes que celles décrites pour les importations en CSV{/t}</li>
            </ul>
        </div>
    </div>
</div>