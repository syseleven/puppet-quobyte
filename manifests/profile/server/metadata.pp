class quobyte::profile::server::metadata (
  $run_service = true,
  $public_ip = undef,
  $rpc_port = false,
  $http_port = false,
) {

  service { 'quobyte-metadata':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitely because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/metadata.cfg':
      public_ip => $public_ip,
      notify    => Service['quobyte-metadata'],
    }
  }

  quobyte::resources::service_port {'metadata_rpc_port':
    service   => 'metadata',
    port_type => 'rpc',
    port_nr   => $rpc_port,
  }

  quobyte::resources::service_port {'metadata_http_port':
    service   => 'metadata',
    port_type => 'http',
    port_nr   => $http_port,
  }

}
