<div class="row">
    <h2>{t}Import ou mise à jour des tables de paramètres{/t}</h2>
</div>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="updateparamExec" method="post" action="index.php" enctype="multipart/form-data">
            <input type="hidden" name="module" value="updateparamExec">
            <div class="form-group">
                <label for="upfile" class="control-label col-md-4"><span class="red">*</span>
                    {t}Nom du fichier à importer (ODS) :{/t}
                </label>
                <div class="col-md-8">
                    <input type="file" name="upfile" class="form-control" accept=".ods" required>
                </div>
            </div>
            <div class="center">
                <button type="submit" class="btn btn-danger">{t}Déclencher l'import{/t}</button>
            </div>
        </form>
    </div>
</div>
<div class="row">
    <div class="col-md-6 bg-info">
        {t}Ce module permet d'importer ou de mettre à jour l'ensemble des tables de paramètres à partir d'un fichier ODS{/t}
        <br>
        {t}Le fichier doit contenir une feuille par table (le nom de la feuille doit être strictement équivalent au nom de la table){/t}
        <br>
        {t}Chaque feuille doit contenir impérativement les colonnes suivantes (conservez l'ordre des colonnes) :{/t}
        <br>
        <ul>
            <li>id : {t}laissée à vide{/t}</li>
            <li>name : {t}nom dans la langue courante{/t}</li>
            <li>exchange : {t}nom en anglais, utilisé pour les échanges{/t}</li>
            <li>order : {t}ordre d'affichage des enregistrements{/t}</li>
        </ul>
    </div>
</div>

