class quobyte::profile::server::s3 (
  $run_service = true,
  $public_ip = undef,
  $s3_hostname = false,
  $s3_keystone_host = undef,
  $s3_keystone_port = '35357',
  $s3_keystone_username = undef,
  $s3_keystone_password = undef,
  $s3_port = false,
  $rpc_port = false,
  $http_port = false,
) {

  service { 'quobyte-s3':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitly because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/s3.cfg':
      public_ip => $public_ip,
      notify    => Service['quobyte-s3'],
    }
  }

  if $s3_hostname {
    ini_setting {"quobyte_s3_s3_hostname":
      path              => "/etc/quobyte/s3.cfg",
      key_val_separator => '=',
      section           => '',
      setting           => "s3.hostname",
      value             => $s3_hostname,
      ensure            => present,
      notify            => Service['quobyte-s3'],
    }
  }

  if $s3_keystone_host {
    ini_setting {"quobyte_s3_s3_keystone_hostport":
      path              => "/etc/quobyte/s3.cfg",
      key_val_separator => '=',
      section           => '',
      setting           => "s3.ks.host",
      value             => "${s3_keystone_host}:${s3_keystone_port}",
      ensure            => present,
      notify            => Service['quobyte-s3'],
    } ->
    ini_setting {"quobyte_s3_s3_keystone_username":
      path              => "/etc/quobyte/s3.cfg",
      key_val_separator => '=',
      section           => '',
      setting           => "s3.ks.user",
      value             => $s3_keystone_username,
      ensure            => present,
      notify            => Service['quobyte-s3'],
    } ->
    ini_setting {"quobyte_s3_s3_keystone_password":
      path              => "/etc/quobyte/s3.cfg",
      key_val_separator => '=',
      section           => '',
      setting           => "s3.ks.password",
      value             => $s3_keystone_password,
      ensure            => present,
      notify            => Service['quobyte-s3'],
    }
  }

  quobyte::resources::service_port {'s3_s3_port':
    service   => 's3',
    port_type => 's3',
    port_nr   => $s3_port,
  }

  quobyte::resources::service_port {'s3_rpc_port':
    service   => 's3',
    port_type => 'rpc',
    port_nr   => $rpc_port,
  }

  quobyte::resources::service_port {'s3_http_port':
    service   => 's3',
    port_type => 'http',
    port_nr   => $http_port,
  }

}
