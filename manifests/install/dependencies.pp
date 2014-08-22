# (private)
class bugzilla::install::dependencies {

  package { $bugzilla::params::perl_packages: ensure => installed }

}
