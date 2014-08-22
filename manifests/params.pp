# default parameters (private)
class bugzilla::params {

  $install_deps     = true
  $basedir          = '/var/www'
  $url              = 'http://ftp.mozilla.org/pub/mozilla.org/webtools'
  $version          = 'STABLE' # or 4.4.5
  $digest           = undef
  $germzilla        = false
  $germzilla_url    = 'http://downloads.sourceforge.net/project/bugzilla-de'
  $germzilla_digest = undef

  $db_host          = 'localhost'
  $db_name          = 'bugs'
  $db_user          = 'bugs'
  $db_pass          = ''
  $db_port          = 0
  $site_wide_secret = undef

  $admin_email      = "admin@${::domain}"
  $admin_password   = 'administrator'
  $admin_realname   = 'Administrator'

  $urlbase          = "${::fqdn}/bugzilla"
  $ssl_redirect     = 'Off'
  $sslbase          = ''
  $cookiepath       = '/bugzilla'

  $config_hash      = {}

  case $::osfamily {
    'Debian': {
      $www_owner = 'www-data'
      $perl_deps = [
        'datetime',
        'template',
        'email-mime',
        'email-send',
        'net-ldap',
        'dbd-mysql',
        'uri',
        'math-random-isaac',
        'gd-gd2',
        'chart',
        'template-plugin-gd',
        'xml-twig',
        'net-smtp-ssl',
        'encode-detect',
        'html-formattext-withlinks',
        'html-scrubber',
        'file-mimeinfo',
        'io-stringy',
        'theschwartz',
        'file-slurp',
      ]
      $perl_packages = suffix(prefix($perl_deps,'lib'),'-perl')
    }
    'RedHat': {
      $www_owner = 'apache'
      $perl_deps = []         # TODO!
      $perl_packages = prefix($perl_deps,'perl-')
    }
    default:  {
      fail("Module ${module_name} is not supported on ${::operatingsystem}/${::osfamily}")
    }
  }

}
