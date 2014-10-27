class quobyte::profile::server::mrc (
  $run_service = true,
) {

  service { 'quobyte-mrc':
    ensure => $run_service,
    enable => $run_service,
  }

}
