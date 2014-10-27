class quobyte::profile::server::directory (
  $run_service = true,
) {

  service { 'quobyte-dir':
    ensure => $run_service,
    enable => $run_service,
  }

}
