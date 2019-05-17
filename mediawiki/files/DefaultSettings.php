<?php
# This file is automatically generated by Salt.
# Any changes done here will be overwritten.
#
# See includes/DefaultSettings.php for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# https://www.mediawiki.org/wiki/Manual:Configuration_settings

# Protect against web entry
#------------------
# Default Settings
#------------------
if ( !defined( 'MEDIAWIKI' ) ) {
  exit;
}

$wgSitename = "{{ site }}";

$wgScriptPath = "";
$wgScriptExtension = ".php";

{%- if site_items.Localtimezone is defined %}
$wgLocaltimezone = "{{ site_items.Localtimezone|default('UTC') }}";
{%- endif %}
date_default_timezone_set("$wgLocaltimezone );

$wgServer = "{{ site_items.Server|default('') }}";

$wgResourceBasePath = $wgScriptPath;

$wgLogo = "{{ site_items.Logo|default('$wgResourceBasePath/resources/assets/wiki.png') }}";

$wgEnableEmail = true;
$wgEnableUserEmail = true; # UPO

$wgEmergencyContact = "{{ site_items.EmergencyContact|default('') }}";
$wgPasswordSender = "{{ site_items.PasswordSender|default('') }}";

$wgEnotifUserTalk = false; # UPO
$wgEnotifWatchlist = false; # UPO
$wgEmailAuthentication = true;

#-------------------
# Database Settings
#-------------------
$wgDBtype = "{{ site_items.DBtype|default('') }}";
$wgDBserver = "{{ site_items.DBserver|default('') }}";
$wgDBname = "{{ site_items.DBname|default('') }}";
$wgDBuser = "{{ site_items.DBuser|default('') }}";
$wgDBpassword = "{{ site_items.DBpassword|default('') }}";

{%- if site_items.DBtype == 'mysql' %}
# MySQL specific settings
$wgDBprefix = "";
# MySQL table options to use during installation or update
$wgDBTableOptions = "ENGINE=InnoDB, DEFAULT CHARSET=utf8";
# Experimental charset support for MySQL 5.0.
$wgDBmysql5 = false;
{%- endif %}

#----------------
# Cache Settings
#----------------
$wgMainCacheType = {{ site_items.CacheType|default('CACHE_ACCEL') }};
{% if site_items.CacheType == 'CACHE_MEMCACHED' %}
$wgMemCachedServers = {{ site_items.MemCachedServers|default('') }};
{% endif %}

#-----------------
# Upload Settings
#-----------------
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";

## Configure file extension types
$wgFileExtensions = array(
  'png','gif','jpg','jpeg','doc','xls','pdf','docx','xlsx','pptx','ps','odt','ods','odp','odg','php','md','csv','vsdx','xml','txt','json'
);

# InstantCommons allows wiki to use images from https://commons.wikimedia.org
$wgUseInstantCommons = false;

#--------------------
# Telemetry Settings
#--------------------
$wgPingback = true;

## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 locale
$wgShellLocale = "en_US.utf8";

# Site language code, should be one of the list in ./languages/data/Names.php
$wgLanguageCode = "en";

$wgSecretKey = "f7043c11f2b7af9566d47767cc8f6aeafa7d257a5abc7e55a4d4b397e684d4b9";

# Changing this will log out all existing sessions.
$wgAuthenticationTokenVersion = "1";

# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = "e3f3c84ae6f2db35";

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "";
$wgRightsText = "";
$wgRightsIcon = "";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";

#-------
# Skins
#-------
# Default skin
$wgDefaultSkin = "vector";

# Loaded Skins
{%- for skin in site_items.skins %}
wfLoadSkin( '{{ skin }}' );
{%- endfor %}

#-----------------
# Enabled Plugins
#-----------------
{%- for plugin in site_items.plugins %}
wfLoadExtension( '{{ plugin }}' );
{%- endfor %}

#---------------------------
# Group Permission Settings
#---------------------------
{%- for permission, permission_items in site_items.GroupPermissions.items() %}
$wgGroupPermissions['{{ permission_items.user }}']['{{ permission }}'] = {{ permission_items.enable }};
{%- endfor %}

#---------
# Logging
#---------
{%- if site_items.debug %}
$wgDebugLogFile = "/var/log/mediawiki/{{ site }}-debug.log";
{%- endif %}

## Session Expiry
$wgSessionInObjetCache = true;
$wgObjectCacheSessionExpiry = 28800;

##------------
## Extensions
##------------

{%- for plugin, plugin_items in site_items.plugins.items() %}
{%- if plugin_items.settings is defined %}
###---------------
### {{ plugin }}
###--------------
{%- for key, value in plugin_items.settings.items() %}
{%- if "array" in value|string or value|int %}
$wg{{ key }} = {{ value|string }};
{%- else %}
$wg{{ key }} = "{{ value|string }}";
{%- endif %}
{%- endfor %}
{%- endif %}
{%- endfor %}
