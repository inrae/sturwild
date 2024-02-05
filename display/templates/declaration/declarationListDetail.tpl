<script>
    $(document).ready(function () {
        $("#declarationSelectGlobal").change(function () {
            $('.checkDeclaration').prop('checked', this.checked);
        });
        $("#checkedActionDeclaration").change(function () {
            if ($(this).val() != "") {
                $("#formContent").show();
            }
        });
        $("#declarationListForm").on("submit", function (event) {
            var action = $("#checkedActionDeclaration").val();
            if (action.length > 0) {
                var conf = confirm("{t}Attention : cette opération est définitive. Est-ce bien ce que vous voulez faire ?{/t}");
                if (conf == true) {
                    $("#module").val(action);
                    $(this.form).prop('target', '_self').submit();
                } else {
                    event.preventDefault();
                }
            } else {
                event.preventDefault();
            }
        });
    });
</script>
<div class="row">
    <div class="col-md-12">
        <form method="POST" id="declarationListForm" action="index.php">
            <input type="hidden" name="module" id="module">
            <table id="declarationList" data-order='[[0,"desc"]]' class="table table-bordered table-hover datatable ">
                <thead>
                    <tr>
                        {if $droits.gestion == 1}
                        <th class="center">
                            <input type="checkbox" id="declarationSelectGlobal" class="checkDeclaration">
                        </th>
                        {/if}
                        <th>{t}N°{/t}</th>
                        <th>{t}Espèce{/t}</th>
                        <th>{t}État à la capture{/t}</th>
                        <th>{t}Année{/t}</th>
                        <th>{t}Date de capture{/t}</th>
                        <th>{t}Localisation{/t}</th>
                        <th>{t}Nbre de poissons{/t}</th>
                        <th title="{t}Nombre total de documents associés, photos, vidéo, etc.{/t}">{t}Nbre de photos{/t}
                        </th>
                        <th>{t}Engin de pêche{/t}</th>
                        <th>{t}Code du pécheur{/t}</th>
                        <th>{t}Interlocuteur{/t}</th>
                        <th>{t}Institut{/t}</th>
                        <th>{t}Statut{/t}</th>
                    </tr>
                </thead>
                <tbody>
                    {section name=lst loop=$data}
                    <tr>
                        {if $droits.gestion == 1}
                        <td class="center">
                            <input type="checkbox" class="checkDeclaration" name="declaration_ids[]"
                                value="{$data[lst].declaration_id}">
                        </td>
                        {/if}
                        <td class="center">
                            <a href="index.php?module=declarationDisplay&declaration_id={$data[lst].declaration_id}">
                                <!--  img src="display/images/detail.png" height="20"-->
                                {$data[lst].declaration_id}
                            </a>
                        </td>
                        <td>{$data[lst].species_name}</td>
                        <td>{$data[lst].capture_state_name}</td>
                        <td>{$data[lst].year}</td>
                        <td>
                            {if strlen($data[lst].capture_date) > 0}
                            {$data[lst].capture_date}
                            {else}
                            {$data[lst].estimated_capture_date}
                            {/if}
                        </td>
                        <td>
                            {$data[lst].country_name}
                            {if !empty($data[lst].ices_name)}
                            {$data[lst].ices_name}
                            {/if}
                            {if !empty($data[lst].environment_name) }
                            {$data[lst].environment_name}
                            {/if}
                            {if !empty($data[lst].environment_detail_name)}
                            {$data[lst].environment_detail_name}
                            {/if}
                        </td>
                        <td class="center">{$data[lst].caught_number}</td>
                        <td class="center">
                            {if $data[lst].document_nb > 0}{$data[lst].document_nb}{/if}
                        </td>
                        <td>{$data[lst].gear_type_name}</td>
                        <td>{$data[lst].fisher_code}</td>
                        <td>{$data[lst].contact}</td>
                        <td>{$data[lst].institute_code}</td>
                        <td>{$data[lst].status_name}</td>
                    </tr>
                    {/section}
                </tbody>
            </table>
            {if $droits.gestion == 1}
            <div class="row">
                <div class="col-md-6 form-horizontal">
                    {t}Pour les déclarations validées sélectionnées :{/t}
                    <select id="checkedActionDeclaration" class="form-control">
                        <option value="" selected>{t}Choisissez{/t}</option>
                        <option value="declarationExportCSV">{t}Exporter les déclarations en CSV{/t}</option>
                        <option value="fishExportCSV">{t}Exporter les poissons rattachés aux déclarations en CSV{/t}
                        </option>
                        <option value="declarationExportJson">
                            {t}Exporter les déclarations et les poissons rattachés (JSON){/t}
                        </option>
                    </select>
                    <div id="formContent" hidden>
                        <div class="form-group ">
                            <label for="use_exchange_labels" class="control-label col-md-4">
                                <span class="red">*</span> 
                                {t}Exporter les libellés des tables de paramètres dans le format d'échange :{/t}
                            </label>
                            <div class="col-md-8">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="use_exchange_labels" id="use_exchange_labels1"
                                            value="1" checked>
                                        {t}oui{/t}
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="use_exchange_labels" id="use_exchange_labels0"
                                            value="0">
                                        {t}non{/t}
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="center">
                            <button id="checkedButtonContainer" class="btn btn-danger">{t}Exécuter{/t}</button>
                        </div>
                    </div>
                </div>
            </div>
            {/if}
        </form>
    </div>
</div>