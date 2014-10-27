class quobyte::profile::server::webconsole (
  $run_service = true,
) {

  service { 'quobyte-webconsole':
    ensure => $run_service,
    enable => $run_service,
  }

}
