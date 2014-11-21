class quobyte::profile::server::directory (
  $run_service = true,
  $enabled_networks = undef,
  $public_ip = undef,
) {

  service { 'quobyte-dir':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the enabled_networks directive in /etc/quobyte/dir.cfg
  # You may have to set this explicitely because autodetection sometimes picks
  # the wrong network.

  if $enabled_networks {
    file_line {'quobyte-dir-enabled_networks':
      path   => '/etc/quobyte/dir.cfg',
      line   => "registry.enabled_networks = $enabled_networks",
      notify => Service['quobyte-dir'],
    }
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitely because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/dir.cfg':
      public_ip => $public_ip,
      notify    => Service['quobyte-dir'],
    }

  }
}
