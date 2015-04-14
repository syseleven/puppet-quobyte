define quobyte::resources::service_port (
  $service, $port_type, $port_nr,
) {

  if $port_nr {
    ini_setting {"quobyte_${service}_${port_type}_port":
      path              => "/etc/quobyte/${service}.cfg",
      key_val_separator => '=',
      section           => '',
      setting           => "${port_type}.port",
      value             => $port_nr,
      ensure            => present,
      notify            => Service["quobyte-${service}"]
    }
  } else {
    ini_setting {"quobyte_${service}_${port_type}_port":
      path              => "/etc/quobyte/${service}.cfg",
      key_val_separator => '=',
      section           => '',
      setting           => "${port_type}.port",
      ensure            => absent,
      notify            => Service["quobyte-${service}"]
    }
  }
}
