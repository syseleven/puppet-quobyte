class quobyte::profile::server::data (
  $run_service = true,
  $public_ip = undef,
  $rpc_port = false,
  $http_port = false,
) {

  service { 'quobyte-data':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitly because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/data.cfg':
      public_ip => $public_ip,
      notify => Service['quobyte-data'],
    }
  }

  quobyte::resources::service_port {'data_rpc_port':
    service   => 'data',
    port_type => 'rpc',
    port_nr   => $rpc_port,
  }

  quobyte::resources::service_port {'data_http_port':
    service   => 'data',
    port_type => 'http',
    port_nr   => $http_port,
  }

}
