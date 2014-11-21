class quobyte::profile::server::webconsole (
  $run_service = true,
  $public_ip = undef,
) {

  service { 'quobyte-webconsole':
    ensure => $run_service,
    enable => $run_service,
  }

  # Sets the public_ip directive in service configuration file. You may have
  # to set this explicitely because autodetection sometimes picks the wrong
  # interface's address.

  if $public_ip {
    quobyte::resources::public_ip{'/etc/quobyte/webconsole.cfg':
      public_ip => $public_ip,
      notify    => Service['quobyte-webconsole'],
    }
  }

}
