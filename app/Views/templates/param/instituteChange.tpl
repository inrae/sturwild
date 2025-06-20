<h2>{t}Création / modification d'un institut partenaire{/t}</h2>

<div class="row">
    <div class="col-sm-12">
        <a href="instituteList">{t}Retour à la liste{/t}</a>
    </div>

    <div class="col-sm-6">
        <form class="form-horizontal " method="post" action="instituteWrite">
            <input type="hidden" name="institute_id" id="institute_id" value="{$data.institute_id}">
            <input type="hidden" name="moduleBase" value="institute">
            <div class="form-group">
                <label for="institute_code" class="control-label col-sm-4">
                    {t}Code :{/t}<span class="red">*</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="institute_code" name="institute_code" value="{$data.institute_code}"
                        autofocus required>
                </div>
            </div>
            <div class="form-group">
                <label for="institute_description" class="control-label col-sm-4">
                    {t}Description :{/t}
                </label>
                <div class="col-sm-8">
                    <textarea class="form-control" name="institute_description" rows="5">{$data.institute_description}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="groups" class="control-label col-md-4">
                    {t}Groupes autorisés à modifier les déclarations de cet institut :{/t}
                </label>
                <div class="col-md-7">
                    {foreach $groups as $group}
                    <div class="col-md-4 col-sm-offset-1">
                        <div class="checkbox" class="form-control">
                            <label>
                                <input type="checkbox" name="groups[]" value="{$group.aclgroup_id}" 
                                {if $group.checked== 1}checked{/if}
                                >
                                {$group.groupe}
                            </label>
                        </div>
                    </div>
                    {/foreach}
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.institute_id > 0 && $canBeDeleted == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
        <span class="red">*</span>
        <span class="messagebas">{t}Champ obligatoire{/t}</span>
    </div>
</div>