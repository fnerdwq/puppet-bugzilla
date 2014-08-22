# (private)
class bugzilla::install {

  ensure_resource('file', '/var/local/packages', {'ensure' => 'directory'})

  $version      = $bugzilla::version

  archive { "bugzilla-${version}":
    ensure           => present,
    url              => "${bugzilla::url}/bugzilla-${version}.tar.gz",
    src_target       => '/var/local/packages',
    checksum         => false,
    extension        => 'tar.gz',
    target           => $bugzilla::basedir,
    root_dir         => "bugzilla-${version}",
    strip_components => 1,
  }

  if $bugzilla::digest {
    Archive <|title == "bugzilla-${version}"|> {
      checksum         => true,
      digest_string    => $bugzilla::digest,
      digest_type      => 'md5',
    }
  }

  # to avoid double directory handling (basedir it is created by apache::vhost)
  # -> 'archive' would not extract (due to 'creates' check in exec)
  file { "${bugzilla::basedir}/bugzilla":
    ensure  => link,
    target  => "${bugzilla::basedir}/bugzilla-${version}",
    require => Archive["bugzilla-${version}"],
  }

  # install german localization
  if $bugzilla::germzilla {

    # extract major/minor version string
    if $version !~ /^(\d+)\.(\d+)(\.\d)*$/ {
      fail('Germzilla only installable for numerical bugzilla::version!')
    }
    $major_version = regsubst($version, '^(\d+)\.(\d+)(\.\d)*$', '\1.\2')

    archive { "germzilla-${version}":
      ensure           => present,
      url              => "${bugzilla::germzilla_url}/${major_version}/${version}/germzilla-${version}-1.utf-8.tar.gz",
      src_target       => '/var/local/packages',
      checksum         => false,
      extension        => 'tar.gz',
      target           => $bugzilla::basedir,
      root_dir         => "bugzilla-${version}/template",
      strip_components => 0,
      require          => Archive["bugzilla-${version}"],
    }

    if $bugzilla::germzilla_digest {
      Archive <|title == "germzilla-${version}"|> {
        checksum         => true,
        digest_string    => $bugzilla::germzilla_digest,
        digest_type      => 'md5',
      }
    }

  }

  # install dependencies?
  if $bugzilla::install_deps {
    contain bugzilla::install::dependencies

    Class['bugzilla::install::dependencies'] ->
    Archive["bugzilla-${version}"]
  }


}

