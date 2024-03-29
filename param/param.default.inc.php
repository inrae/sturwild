<?php
/** Fichier cree le 4 mai 07 par quinton
*
*UTF-8
*
* Parametres par defaut de l'application
*/
$APPLI_version = "v24.0.1";
$APPLI_dbversion = "24.0";
$APPLI_versiondate = _("29/02/2024");
$language = "fr";
$DEFAULT_formatdate = "fr";
/*
 * Navigation a partir du fichier xml
 */
$navigationxml = array("framework/actions.xml","param/actions.xml");
/*
 * Duree de la session par defaut
 * @var unknown_type
 */
// 4 heures
$APPLI_session_ttl = 14400;
// 3 mois
$APPLI_cookie_ttl = 7776000;
// 10 heures
$APPLI_absolute_session = 36000;

/*
 * Duree de conservation des traces (en jours) dans la table log
 */
$LOG_duree = 365;
/*
 * Type d'identification
 *
 * BDD : mot de passe en base de donnees
 * CAS : utilisation d'un serveur CAS
 * LDAP : utilisation d'un serveur LDAP
 * LDAP-BDD : test d'abord aupres du serveur LDAP, puis du serveur BDD
 * HEADER : l'identification est fournie dans une variable HEADER (derriere un proxy comme
 * LemonLdap, par exemple)
 */
$ident_header_vars = array(
	"login" => "MELLON_MAIL",
	"mail" => "MELLON_MAIL",
	"name" => "MELLON_cn",
	"firstname"=>"MELLON_givenname",
	"lastname" => "MELLON_sn",
	"organization" => "MELLON_supannentiteaffectationprincipale",
	"organizationGranted" => array(),
	"createUser" => true,
	"groupAttribute" => "MELLON_supannentiteaffectation",
	"groupsGranted" => array()
);
$user_attributes = array (
	"mail" => "mail",
	"firstname"=>"givenName",
	"lastname"=>"sn",
	"name"=>"cn",
	"groups"=>"supannentiteaffectationprincipale"
);
$ident_header_login_var = "AUTH_USER";
$ident_header_logout_address = "https://server/cas/logout";
$ident_type = "BDD";
$CAS_address = "localhost";
$CAS_uri = "/cas";
$CAS_port = 443;
$CAS_debug = false;
$CAS_CApath = "";
$CAS_get_groups = 1;
$CAS_group_attribute = "supannEntiteAffectation";
$LDAP = array(
		"address"=>"localhost",
		"port" => 389,
		"rdn" => "cn=manager,dc=example,dc=com",
		"basedn" => "ou=people,ou=example,o=societe,c=fr",
		"user_attrib" => "uid",
		"v3" => true,
		"tls" => false,
		"groupSupport"=>true,
		"groupAttrib"=>"supannentiteaffectation",
		"commonNameAttrib"=>"displayname",
		"mailAttrib"=>"mail",
		'attributgroupname' => "cn",
		'attributloginname' => "memberuid",
		'basedngroup' => 'ou=example,o=societe,c=fr',
		"timeout"=>2
);

/*
 * Parametres concernant la base de donnees
 */
$BDD_login = "proto";
$BDD_passwd = "proto";
$BDD_dsn = "pgsq:host=localhost;dbname=proto";
$BDD_schema = "public";
/*
 * Parametres concernant SMARTY
 */
$SMARTY_param = array("templates"=> 'display/templates',
		"templates_c"=>'display/templates_c',
		"cache"=>false,
		"cache_dir"=>'display/smarty_cache',
		"template_main"=>"main.htm"
);


/*
 * Variables de base de l'application
 */
$APPLI_mail = "proto@proto.com";
$APPLI_assist_address = "https://github.com/inrae/sturwild/issues/new/choose";
$APPLI_fds = "display/CSS/blue.css";
$APPLI_address = "http://localhost/proto";
$APPLI_modeDeveloppement = false;
$APPLI_modeDeveloppementDroit = false;
$APPLI_utf8 = true;
$APPLI_menufile = "param/menu.xml";
$APPLI_temp = "temp";
$APPLI_titre = "Software Name";

/*
 * Variables systematiques pour SMARTY
 */
$SMARTY_variables = array(
	"entete"=>"entete.tpl",
	"enpied"=>"enpied.tpl",
	"corps"=>"main.tpl",
	"melappli"=>$APPLI_mail,
	"ident_type"=>$ident_type,
	"appliAssist"=>$APPLI_assist_address,
	"display"=>"/display",
	"favicon"=>"/favicon.png"
);
/*
 * Variables liees a GACL et l'identification via base de donnees
 */
$GACL_dblogin = "proto";
$GACL_dbpasswd = "proto";
$GACL_aco = "col";
$GACL_dsn = "pgsql:host=localhost;dbname=proto";
$GACL_schema = "gacl";

/*
 * Gestion des erreurs
 */
$ERROR_level=E_ERROR;
/*
 * Pour le developpement :
 * $ERROR_level = E_ALL & ~E_NOTICE & E_STRICT
 * En production :
 * $ERROR_level = E_ERROR ;
 */
$ERROR_display=0;
$ADODB_debugmode = 0;
$OBJETBDD_debugmode = 1;
/*
 * Modules de traitement des erreurs
 */
$APPLI_moduleDroitKO = "droitko";
$APPLI_moduleErrorBefore = "errorbefore";
$APPLI_moduleNoLogin = "errorlogin";
$APPLI_notSSL = false;
/*
 * Cles privee et publique utilisees
 * pour la generation des jetons
 */
$privateKey = "param/id_sturwild";
$pubKey = "param/id_sturwild.pub";
/*
 * Duree de validite du token d'identification
 */
$tokenIdentityValidity = 36000; // 10 heures
/*
 * Emplacement du fichier contenant les paramètres spécifiques de l'entree DNS (multiples applications avec
 * le meme code)
 */
$paramIniFile = "./param.ini";

$MAPS_enabled = 1;
$MAPS_url = "https://maps.googleapis.com/maps/api/js?key=CLE_IDENTIFICATION&callback=initMap";
/*
 * Nombre maximum d'essais de connexion
 */
$CONNEXION_max_attempts = 5;
/*
 * Duree de blocage du compte (duree reinitialisee a chaque tentative)
 */
$CONNEXION_blocking_duration = 600;
/*
 * Laps de temps avant de renvoyer un mail a l'administrateur en cas de blocage de compte
 */
$APPLI_mailToAdminPeriod = 7200;
$APPLI_admin_ttl = 600; // Duree maxi d'inactivite pour acceder a un module d'administration

$APPLI_passwordMinLength = 12;
$APPLI_lostPassword = 1; // Autorise la recuperation d'un nouveau mot de passe en cas de perte
$APPLI_hour_duration = 3600; // Duration of an hour for count all calls to a module
$APPLI_day_duration = 36000; //Duration of a day for count all calls to a module
$MAIL_enabled = 1; // send mails

$CAS_address = "localhost/CAS"; // Address of CAS server
$CAS_port = 443; //port of CAS server
$CAS_debug = false; // Activation of debug mode
$CAS_CApath=""; // path to the certificate of the CAS
$GACL_disable_new_right = 1;
$APPLI_release_url = "https://api.github.com/repos/inrae/sturwild/releases/latest";
$APPLI_release_url_tag = "tag_name";
$APPLI_release_url_date = "published_at";
$APPLI_release_right_minimal = "gestion";
$APPLI_release_user_agent = 'inrae/sturwild';
$APPLI_release_description = "body";