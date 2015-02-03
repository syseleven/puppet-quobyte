class quobyte::profile::server::registry (
  $run_service = true,
  $enabled_networks = undef,
  $public_ip = undef,
  $rpc_port = false,
  $http_port = false,
) {

  service { 'quobyte-registry':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the enabled_networks directive in /etc/quobyte/registry.cfg
  # You may have to set this explicitely because autodetection sometimes picks
  # the wrong network.

  if $enabled_networks {
    file_line {'quobyte-registry-enabled_networks':
      path   => '/etc/quobyte/registry.cfg',
      line   => "registry.enabled_networks = $enabled_networks",
      notify => Service['quobyte-registry'],
    }
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitely because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/registry.cfg':
      public_ip => $public_ip,
      notify    => Service['quobyte-registry'],
    }

  }

  quobyte::resources::service_port {'registry_rpc_port':
    service   => 'registry',
    port_type => 'rpc',
    port_nr   => $rpc_port,
  }

  quobyte::resources::service_port {'registry_http_port':
    service   => 'registry',
    port_type => 'http',
    port_nr   => $http_port,
  }

}
