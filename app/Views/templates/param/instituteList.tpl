<h2>{t}Liste des instituts partenaires{/t}</h2>
{if $rights.param == 1}
<a href="instituteChange?institute_id=0">
    <img src="display/images/new.png" height="20">{t}Nouveau{/t}</a>
{/if}
<div class="row">
    <div class="col-sm-6">
        <table id="instituteListe" class="table table-bordered datatable table-hover">
            <thead>
                <tr>
                    <th>{t}Code{/t}</th>
                    <th>{t}Description{/t}</th>
                </tr>
            </thead>
            <tbody> {section name=lst loop=$data}
                <tr>
                    <td>
                        {if $rights.param == 1}
                        <a href="instituteChange?institute_id={$data[lst].institute_id}">
                            {$data[lst].institute_code}</a>
                        {else}{$data[lst].institute_code}
                        {/if}
                    </td>
                    <td class="tableTextarea">{$data[lst].institute_description}</td>
                </tr>
                {/section}
            </tbody>
        </table>
    </div>
</div>