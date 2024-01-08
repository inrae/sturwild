<?php
class DeclarationImportException extends Exception{}

class DeclarationImport {
    private $handle;
    private $fileColumn = array();
    private $colonnes = array();
    public PDO $connection;
    private $separator = ",";

    function initFileCSV($filename, $separator = ",", $utf8_encode = false)
    {
        if ($separator == "tab") {
            $separator = "\t";
        }
        $this->separator = $separator;
        $this->utf8_encode = $utf8_encode;
        /**
         * Ouverture du fichier
         */
        if ($this->handle = fopen($filename, 'r')) {
            /**
             * Lecture de la premiere ligne et affectation des colonnes
             */
            $data = $this->readLine();
            $range = 0;
            for ($range = 0; $range < count($data); $range++) {
                $value = $data[$range];
               
                if (in_array($value, $this->colonnes)) {
                    $this->fileColumn[$range] = $value;
                } else {
                    throw new DeclarationImportException(sprintf(_('La colonne %1$s n\'est pas reconnue (%2$s)'), $range, $value));
                }
            }
        } else {
            throw new DeclarationImportException(sprintf(_("Le fichier %s n'a pas été trouvé ou n'est pas lisible"), $filename));
        }
    }
    function readLine()
    {
        if ($this->handle) {
            $data = fgetcsv($this->handle, 1000, $this->separator);
            if ($data !== false) {
                if ($this->utf8_encode) {
                    foreach ($data as $key => $value) {
                        $data[$key] = utf8_encode($value);
                    }
                }
            }
            return $data;
        } else {
            return null;
        }
    }

    /**
     * Ferme le fichier
     */
    function fileClose()
    {
        if ($this->handle) {
            fclose($this->handle);
        }
    }
}