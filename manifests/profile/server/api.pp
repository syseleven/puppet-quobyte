class quobyte::profile::server::api (
  $run_service = true,
  $public_ip = undef,
  $api_port = false,
  $rpc_port = false,
  $http_port = false,
) {

  service { 'quobyte-api':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitly because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/api.cfg':
      public_ip => $public_ip,
      notify    => Service['quobyte-api'],
    }
  }

  quobyte::resources::service_port {'api_api_port':
    service   => 'api',
    port_type => 'api',
    port_nr   => $api_port,
  }

  quobyte::resources::service_port {'api_rpc_port':
    service   => 'api',
    port_type => 'rpc',
    port_nr   => $rpc_port,
  }

  quobyte::resources::service_port {'api_http_port':
    service   => 'api',
    port_type => 'http',
    port_nr   => $http_port,
  }

}
