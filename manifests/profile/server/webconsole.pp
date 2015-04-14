class quobyte::profile::server::webconsole (
  $run_service = true,
  $public_ip = undef,
  $webconsole_port = false,
  $rpc_port = false,
  $http_port = false,
) {

  service { 'quobyte-webconsole':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitly because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/webconsole.cfg':
      public_ip => $public_ip,
      notify    => Service['quobyte-webconsole'],
    }
  }

  quobyte::resources::service_port {'webconsole_webconsole_port':
    service   => 'webconsole',
    port_type => 'webconsole',
    port_nr   => $api_port,
  }

  quobyte::resources::service_port {'webconsole_rpc_port':
    service   => 'webconsole',
    port_type => 'rpc',
    port_nr   => $rpc_port,
  }

  quobyte::resources::service_port {'webconsole_http_port':
    service   => 'webconsole',
    port_type => 'http',
    port_nr   => $http_port,
  }

}
