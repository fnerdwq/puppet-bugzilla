# (private)
class bugzilla::config {

  $www_owner = $bugzilla::params::www_owner
  $db_host   = $bugzilla::db_host
  $db_name   = $bugzilla::db_name
  $db_user   = $bugzilla::db_user
  $db_pass   = $bugzilla::db_pass
  $db_port   = $bugzilla::db_port

  if $bugzilla::site_wide_secret {
    $site_wide_secret = $bugzilla::site_wide_secret
  } else {
    $site_wide_secret = sha1($::certname)
  }

  file {'localconfig':
    path    => "${bugzilla::basedir}/bugzilla/localconfig",
    owner   => root,
    group   => $www_owner,
    mode    => '0640',
    content => template('bugzilla/localconfig.erb'),
    notify  => Exec['checksetup.pl'],
  }

  $admin_email    = $bugzilla::admin_email
  $admin_password = $bugzilla::admin_password
  $admin_realname = $bugzilla::admin_realname
  $urlbase        = $bugzilla::urlbase
  $ssl_redirect   = $bugzilla::ssl_redirect
  $sslbase        = $bugzilla::sslbase
  $cookiepath     = $bugzilla::cookiepath
  $config_hash    = $bugzilla::config_hash

  file {'localconfig.answer':
    path    => "${bugzilla::basedir}/bugzilla/localconfig.answer",
    owner   => root,
    group   => $www_owner,
    mode    => '0640',
    content => template('bugzilla/localconfig.answer.erb'),
    notify  => Exec['checksetup.pl'],
  }

  exec {'checksetup.pl':
    command     => "${bugzilla::basedir}/bugzilla/checksetup.pl localconfig.answer",
    cwd         => "${bugzilla::basedir}/bugzilla",
    refreshonly => true,
  }
}
