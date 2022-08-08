<?php











namespace Composer;

use Composer\Autoload\ClassLoader;
use Composer\Semver\VersionParser;






class InstalledVersions
{
private static $installed = array (
  'root' => 
  array (
    'pretty_version' => '1.2.0',
    'version' => '1.2.0.0',
    'aliases' => 
    array (
    ),
    'reference' => NULL,
    'name' => 'inrae/sturwild',
  ),
  'versions' => 
  array (
    'beberlei/assert' => 
    array (
      'pretty_version' => 'v3.3.2',
      'version' => '3.3.2.0',
      'aliases' => 
      array (
      ),
      'reference' => 'cb70015c04be1baee6f5f5c953703347c0ac1655',
    ),
    'bjeavons/zxcvbn-php' => 
    array (
      'pretty_version' => '0.4.0',
      'version' => '0.4.0.0',
      'aliases' => 
      array (
      ),
      'reference' => '7a7e1130c74c715e84c60c27384f657e9574a933',
    ),
    'inrae/sturwild' => 
    array (
      'pretty_version' => '1.2.0',
      'version' => '1.2.0.0',
      'aliases' => 
      array (
      ),
      'reference' => NULL,
    ),
    'jasig/phpcas' => 
    array (
      'pretty_version' => '1.5.0',
      'version' => '1.5.0.0',
      'aliases' => 
      array (
      ),
      'reference' => 'd6f5797fb568726f34c8e48741776d81e4a2646b',
    ),
    'paragonie/constant_time_encoding' => 
    array (
      'pretty_version' => 'v2.6.3',
      'version' => '2.6.3.0',
      'aliases' => 
      array (
      ),
      'reference' => '58c3f47f650c94ec05a151692652a868995d2938',
    ),
    'paragonie/random_compat' => 
    array (
      'pretty_version' => 'v9.99.100',
      'version' => '9.99.100.0',
      'aliases' => 
      array (
      ),
      'reference' => '996434e5492cb4c3edcb9168db6fbb1359ef965a',
    ),
    'psr/log' => 
    array (
      'pretty_version' => '1.1.4',
      'version' => '1.1.4.0',
      'aliases' => 
      array (
      ),
      'reference' => 'd49695b909c3b7628b6289db5479a1c204601f11',
    ),
    'ramsey/uuid' => 
    array (
      'pretty_version' => '3.9.6',
      'version' => '3.9.6.0',
      'aliases' => 
      array (
      ),
      'reference' => 'ffa80ab953edd85d5b6c004f96181a538aad35a3',
    ),
    'rhumsaa/uuid' => 
    array (
      'replaced' => 
      array (
        0 => '3.9.6',
      ),
    ),
    'smarty-gettext/smarty-gettext' => 
    array (
      'pretty_version' => '1.6.2',
      'version' => '1.6.2.0',
      'aliases' => 
      array (
      ),
      'reference' => '22e5b91b642cd643f9acdd8d04ab0e05647b98a7',
    ),
    'smarty/smarty' => 
    array (
      'pretty_version' => 'v3.1.46',
      'version' => '3.1.46.0',
      'aliases' => 
      array (
      ),
      'reference' => 'b3ade90dece67812410954528e0039fb5b73bcf7',
    ),
    'spomky-labs/otphp' => 
    array (
      'pretty_version' => 'v10.0.3',
      'version' => '10.0.3.0',
      'aliases' => 
      array (
      ),
      'reference' => '9784d9f7c790eed26e102d6c78f12c754036c366',
    ),
    'symfony/polyfill-ctype' => 
    array (
      'pretty_version' => 'v1.26.0',
      'version' => '1.26.0.0',
      'aliases' => 
      array (
      ),
      'reference' => '6fd1b9a79f6e3cf65f9e679b23af304cd9e010d4',
    ),
    'thecodingmachine/safe' => 
    array (
      'pretty_version' => 'v1.3.3',
      'version' => '1.3.3.0',
      'aliases' => 
      array (
      ),
      'reference' => 'a8ab0876305a4cdaef31b2350fcb9811b5608dbc',
    ),
  ),
);
private static $canGetVendors;
private static $installedByVendor = array();







public static function getInstalledPackages()
{
$packages = array();
foreach (self::getInstalled() as $installed) {
$packages[] = array_keys($installed['versions']);
}


if (1 === \count($packages)) {
return $packages[0];
}

return array_keys(array_flip(\call_user_func_array('array_merge', $packages)));
}









public static function isInstalled($packageName)
{
foreach (self::getInstalled() as $installed) {
if (isset($installed['versions'][$packageName])) {
return true;
}
}

return false;
}














public static function satisfies(VersionParser $parser, $packageName, $constraint)
{
$constraint = $parser->parseConstraints($constraint);
$provided = $parser->parseConstraints(self::getVersionRanges($packageName));

return $provided->matches($constraint);
}










public static function getVersionRanges($packageName)
{
foreach (self::getInstalled() as $installed) {
if (!isset($installed['versions'][$packageName])) {
continue;
}

$ranges = array();
if (isset($installed['versions'][$packageName]['pretty_version'])) {
$ranges[] = $installed['versions'][$packageName]['pretty_version'];
}
if (array_key_exists('aliases', $installed['versions'][$packageName])) {
$ranges = array_merge($ranges, $installed['versions'][$packageName]['aliases']);
}
if (array_key_exists('replaced', $installed['versions'][$packageName])) {
$ranges = array_merge($ranges, $installed['versions'][$packageName]['replaced']);
}
if (array_key_exists('provided', $installed['versions'][$packageName])) {
$ranges = array_merge($ranges, $installed['versions'][$packageName]['provided']);
}

return implode(' || ', $ranges);
}

throw new \OutOfBoundsException('Package "' . $packageName . '" is not installed');
}





public static function getVersion($packageName)
{
foreach (self::getInstalled() as $installed) {
if (!isset($installed['versions'][$packageName])) {
continue;
}

if (!isset($installed['versions'][$packageName]['version'])) {
return null;
}

return $installed['versions'][$packageName]['version'];
}

throw new \OutOfBoundsException('Package "' . $packageName . '" is not installed');
}





public static function getPrettyVersion($packageName)
{
foreach (self::getInstalled() as $installed) {
if (!isset($installed['versions'][$packageName])) {
continue;
}

if (!isset($installed['versions'][$packageName]['pretty_version'])) {
return null;
}

return $installed['versions'][$packageName]['pretty_version'];
}

throw new \OutOfBoundsException('Package "' . $packageName . '" is not installed');
}





public static function getReference($packageName)
{
foreach (self::getInstalled() as $installed) {
if (!isset($installed['versions'][$packageName])) {
continue;
}

if (!isset($installed['versions'][$packageName]['reference'])) {
return null;
}

return $installed['versions'][$packageName]['reference'];
}

throw new \OutOfBoundsException('Package "' . $packageName . '" is not installed');
}





public static function getRootPackage()
{
$installed = self::getInstalled();

return $installed[0]['root'];
}







public static function getRawData()
{
return self::$installed;
}



















public static function reload($data)
{
self::$installed = $data;
self::$installedByVendor = array();
}




private static function getInstalled()
{
if (null === self::$canGetVendors) {
self::$canGetVendors = method_exists('Composer\Autoload\ClassLoader', 'getRegisteredLoaders');
}

$installed = array();

if (self::$canGetVendors) {

foreach (ClassLoader::getRegisteredLoaders() as $vendorDir => $loader) {
if (isset(self::$installedByVendor[$vendorDir])) {
$installed[] = self::$installedByVendor[$vendorDir];
} elseif (is_file($vendorDir.'/composer/installed.php')) {
$installed[] = self::$installedByVendor[$vendorDir] = require $vendorDir.'/composer/installed.php';
}
}
}

$installed[] = self::$installed;

return $installed;
}
}
