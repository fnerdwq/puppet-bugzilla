# == Class: bugzilla
#
# This class installs and configures bugzilla.
# Does _not_ install/configure a webserver nor php.
#
# Only initially configures bugzille (when no 'data/params' exists).
# 
# This works on Debian like systems.
# Puppet Version >= 3.4.0
#
# === Parameters
#
# [*install_deps*]
#   Install dependency packages?
#   *Optional* (defaults to _true_)
#
# [*basedir*]
#   Basedir in which to install Bugzilla
#   *Optional* (defaults to _/var/www_)
#
# [*url*]
#   Where to fetch bugzilla.
#   *Optional* (defaults to _http://ftp.mozilla.org/pub/mozilla.org/webtools_)
#
# [*version*]
#   Version to fetch.
#   *Optional* (defaults to _STABLE_)
#
# [*digest*]
#   MD5 digest of tarball.
#   *Optional* (defaults to _undef_)
#
# [*germzilla*]
#   Install german localization.
#   Only possible for numerical versions!
#   *Optional* (defaults to _false_)
#
# [*germzilla_url*]
#   Where to fetch germzilla.
#   *Optional* (defaults to _http://downloads.sourceforge.net/project/bugzilla-de_)
#
# [*germzilla_digest*]
#   MD5 digest of garmzilla tarball.
#   *Optional* (defaults to _undef_)
#
# [*db_host*]
#   Host of bugzilla DB.
#   *Optional* (defaults to _localhost_)
#
# [*db_name*]
#   Name of bugzilla DB.
#   *Optional* (defaults to _bugs_)
#
# [*db_user*]
#   DB user for bugzilla.
#   *Optional* (defaults to _bugs_)
#
# [*db_pass*]
#   DB name for bugzilla controll Database.
#   *Optional* (defaults to _''_)
#
# [*db_port*]
#   DB User for bugzilla controll Database.
#   *Optional* (defaults to _0_)
#
# [*site_wide_secret*]
#   DB password for bugzilla.
#   *Optional* (defaults to _sha1($::fqdn)_)
#
# [*admin_email*]
#   Email address of admin user.
#   *Optional* (defaults to _admin@$::domain_)
#
# [*admin_password*]
#   Password of admin user.
#   *Optional* (defaults to _administrator_)
#
# [*admin_realname*]
#   Realname of admin user.
#   *Optional* (defaults to _Administrator_)
#
# [*urlbase*]
#   URL where to reach bugzilla.
#   *Optional* (defaults to _$::fqdn/bugzilla_)
#
# [*ssl_redirect*]
#   Force ssl redirects.
#   *Optional* (defaults to _Off_)
#
# [*sslbase*]
#   Where ssl enabled installation is found.
#   *Optional* (defaults to _''_)
#
# [*cookiepath*]
#   Cookie path should be the same location as in urlbase.
#   *Optional* (defaults to _/bugzilla_)
#
# [*config_hash*]
#   Additional parameters which should be set.
#   *Optional* (defaults to _{}_)
#
# === Examples
#
# include bugzilla
#
# === Authors
#
# Frederik Wagner <wagner@wagit.de>
#
# === Copyright
#
# Copyright 2014 Frederik Wagner
#
class bugzilla (
  $install_deps     = $bugzilla::params::install_deps,
  $basedir          = $bugzilla::params::basedir,
  $url              = $bugzilla::params::url,
  $version          = $bugzilla::params::version,
  $digest           = $bugzilla::params::digest,
  $germzilla        = $bugzilla::params::germzilla,
  $germzilla_url    = $bugzilla::params::germzilla_url,
  $germzilla_digest = $bugzilla::params::germzilla_digest,
  $db_host          = $bugzilla::params::db_host,
  $db_name          = $bugzilla::params::db_name,
  $db_user          = $bugzilla::params::db_user,
  $db_pass          = $bugzilla::params::db_pass,
  $db_port          = $bugzilla::params::db_port,
  $site_wide_secret = $bugzilla::params::site_wide_secret,
  $admin_email      = $bugzilla::params::admin_email,
  $admin_password   = $bugzilla::params::admin_password,
  $admin_realname   = $bugzilla::params::admin_realname,
  $urlbase          = $bugzilla::params::urlbase,
  $ssl_redirect     = $bugzilla::params::ssl_redirect,
  $sslbase          = $bugzilla::params::sslbase,
  $cookiepath       = $bugzilla::params::cookiepath,
  $config_hash      = $bugzilla::params::config_hash,
) inherits bugzilla::params {

  contain 'bugzilla::install'
  contain 'bugzilla::config'

  # notification for ./chkconfig.pl run
  Class['bugzilla::install'] ~>
  Class['bugzilla::config']

}

